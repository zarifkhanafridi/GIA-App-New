package com.example.academy

import android.content.Context
import android.net.Uri
import android.view.View
import android.view.Gravity
import android.widget.FrameLayout
import android.widget.Button
import android.widget.LinearLayout
import android.widget.PopupMenu
import com.google.android.exoplayer2.ExoPlayer
import com.google.android.exoplayer2.MediaItem
import com.google.android.exoplayer2.Player
import com.google.android.exoplayer2.source.MediaSource
import com.google.android.exoplayer2.source.dash.DashMediaSource
import com.google.android.exoplayer2.source.hls.HlsMediaSource
import com.google.android.exoplayer2.trackselection.DefaultTrackSelector
import com.google.android.exoplayer2.ui.StyledPlayerView
import com.google.android.exoplayer2.upstream.DefaultDataSource
import com.google.android.exoplayer2.upstream.DefaultHttpDataSource
import com.google.android.exoplayer2.util.MimeTypes
import com.google.android.exoplayer2.C
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import kotlinx.coroutines.*
import org.schabi.newpipe.extractor.NewPipe
import org.schabi.newpipe.extractor.ServiceList
import org.schabi.newpipe.extractor.stream.StreamInfo
import org.schabi.newpipe.extractor.localization.Localization
import org.schabi.newpipe.extractor.MediaFormat

class CustomExoPlayerView(
    context: Context,
    messenger: BinaryMessenger,
    viewId: Int
) : PlatformView, MethodChannel.MethodCallHandler {

    private val root = FrameLayout(context)
    private val playerView = StyledPlayerView(context)
    private val trackSelector = DefaultTrackSelector(context)
    private val player = ExoPlayer.Builder(context)
        .setTrackSelector(trackSelector)
        .setSeekBackIncrementMs(10_000)
        .setSeekForwardIncrementMs(10_000)
        .build()

    private val methodChannel = MethodChannel(messenger, "custom_exoplayer/methods_$viewId")
    private val eventChannel = EventChannel(messenger, "custom_exoplayer/events_$viewId")

    private var eventsSink: EventChannel.EventSink? = null
    private val scope = CoroutineScope(SupervisorJob() + Dispatchers.IO)

    private var lastDashUrl: String? = null
    private var lastHlsUrl: String? = null
    private var progressiveByHeight: Map<Int, String> = emptyMap()
    private var currentSourceType: String = "unknown" // dash | hls | progressive
    private var availableSubtitles: List<Map<String, String>> = emptyList()
    private var availableHeights: MutableSet<Int> = mutableSetOf()

    private val overlayBar: LinearLayout by lazy {
        LinearLayout(root.context).apply {
            orientation = LinearLayout.HORIZONTAL
            setPadding(16, 8, 16, 16)
            alpha = 0.95f
            // ✅ assign layoutParams to this LinearLayout
            layoutParams = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.WRAP_CONTENT,
                FrameLayout.LayoutParams.WRAP_CONTENT
            ).apply {
                gravity = Gravity.BOTTOM or Gravity.CENTER_HORIZONTAL
                bottomMargin = 24 // lift slightly above screen bottom
            }
            // Buttons: <<10s | Speed | Quality | 10s>>
            val back10 = Button(root.context).apply {
                text = "<< 10s"
                setOnClickListener {
                    val pos = player.currentPosition
                    player.seekTo((pos - 10_000).coerceAtLeast(0))
                }
            }
            val speedBtn = Button(root.context).apply {
                text = "1.0x"
                setOnClickListener { v ->
                    val pm = PopupMenu(v.context, v)
                    listOf(0.5f, 0.75f, 1.0f, 1.25f, 1.5f, 2.0f).forEachIndexed { idx, sp ->
                        pm.menu.add(0, idx, idx, "${sp}x")
                    }
                    pm.setOnMenuItemClickListener { item ->
                        val sp = when (item.title.toString()) {
                            "0.5x" -> 0.5f
                            "0.75x" -> 0.75f
                            "1.0x" -> 1.0f
                            "1.25x" -> 1.25f
                            "1.5x" -> 1.5f
                            "2.0x" -> 2.0f
                            else -> 1.0f
                        }
                        player.setPlaybackSpeed(sp)
                        text = "${sp}x"
                        true
                    }
                    pm.show()
                }
            }
            val qualityBtn = Button(root.context).apply {
                text = "Quality"
                setOnClickListener { v ->
                    val allowed = setOf(360, 480, 720)
                    val heights = (if (currentSourceType == "progressive" && progressiveByHeight.isNotEmpty()) {
                        availableHeights + progressiveByHeight.keys
                    } else availableHeights).toSet()
                    val show = heights.filter { it in allowed }.ifEmpty { heights.toList() }.sorted()
                    val pm = PopupMenu(v.context, v)
                    show.forEachIndexed { idx, h -> pm.menu.add(0, h, idx, "${h}p") }
                    pm.setOnMenuItemClickListener { item ->
                        val h = item.itemId
                        // Switch quality using same logic as method channel
                        if (currentSourceType == "progressive" && progressiveByHeight.containsKey(h)) {
                            progressiveByHeight[h]?.takeIf { it.isNotBlank() }?.let { u ->
                                val pos = player.currentPosition
                                val httpFactory = DefaultHttpDataSource.Factory()
                                    .setUserAgent("Mozilla/5.0 (Android) ExoPlayer")
                                    .setAllowCrossProtocolRedirects(true)
                                val dsf = DefaultDataSource.Factory(root.context, httpFactory)
                                val itemMi = MediaItem.fromUri(Uri.parse(u))
                                val ms = com.google.android.exoplayer2.source.ProgressiveMediaSource.Factory(dsf)
                                    .createMediaSource(itemMi)
                                player.setMediaSource(ms)
                                player.prepare()
                                player.seekTo(pos)
                                player.playWhenReady = true
                            }
                        } else {
                            val params = trackSelector.parameters
                            val newParams = params.buildUpon().setMaxVideoSize(Int.MAX_VALUE, h).build()
                            trackSelector.setParameters(newParams)
                        }
                        text = "${h}p"
                        true
                    }
                    pm.show()
                }
            }
            val fwd10 = Button(root.context).apply {
                text = "10s >>"
                setOnClickListener {
                    val pos = player.currentPosition
                    val dur = player.duration.takeIf { it > 0 } ?: Long.MAX_VALUE
                    player.seekTo((pos + 10_000).coerceAtMost(dur))
                }
            }
            val fullBtn = Button(root.context).apply {
                text = "Full"
                setOnClickListener {
                    // Let Flutter control orientation and UI changes
                    sendEvent("toggleFullscreen", emptyMap())
                }
            }
//            addView(back10)
            addView(speedBtn)
            addView(qualityBtn)
//            addView(fwd10)
            addView(fullBtn)
        }
    }

    init {
        // Modern default controls
        playerView.useController = true
        playerView.controllerAutoShow = true
        playerView.controllerHideOnTouch = true
        playerView.controllerShowTimeoutMs = 4000
        playerView.setShowBuffering(StyledPlayerView.SHOW_BUFFERING_WHEN_PLAYING)
        playerView.player = player
        root.addView(
            playerView,
            FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.MATCH_PARENT
            )
        )

        // Add overlay bar anchored to bottom center, initially hidden
        root.addView(
            overlayBar,
            FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.WRAP_CONTENT,
                FrameLayout.LayoutParams.WRAP_CONTENT,
                Gravity.BOTTOM or Gravity.CENTER_HORIZONTAL
            )
        )
        overlayBar.visibility = View.GONE

        methodChannel.setMethodCallHandler(this)
        eventChannel.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(args: Any?, sink: EventChannel.EventSink?) { eventsSink = sink }
            override fun onCancel(args: Any?) { eventsSink = null }
        })

        playerView.setControllerVisibilityListener(object : StyledPlayerView.ControllerVisibilityListener {
            override fun onVisibilityChanged(visibility: Int) {
                // Post to allow controller animation/state settle, then query actual state
                root.post {
                    val visible = playerView.isControllerFullyVisible
                    overlayBar.visibility = if (visible) View.VISIBLE else View.GONE
                    // Notify Flutter so it can show/hide its own overlays (e.g., title)
                    sendEvent("controllerVisibility", mapOf("visible" to visible))
                }
            }
        })
        player.addListener(object : Player.Listener {
            override fun onPlaybackStateChanged(state: Int) {
                sendEvent("state", mapOf("state" to state))
            }
            override fun onIsPlayingChanged(isPlaying: Boolean) {
                sendEvent("isPlaying", mapOf("isPlaying" to isPlaying))
            }
            override fun onTracksChanged(tracks: com.google.android.exoplayer2.Tracks) {
                // Collect available video heights from current track groups
                val heights = mutableSetOf<Int>()
                tracks.groups.forEach { group ->
                    if (group.type == C.TRACK_TYPE_VIDEO) {
                        for (i in 0 until group.mediaTrackGroup.length) {
                            val fmt = group.mediaTrackGroup.getFormat(i)
                            val h = fmt.height
                            if (h > 0) heights.add(h)
                        }
                    }
                }
                // If we are on progressive source, merge in heights from extracted streams
                if (currentSourceType == "progressive" && progressiveByHeight.isNotEmpty()) {
                    heights.addAll(progressiveByHeight.keys)
                }
                availableHeights = heights
                // Only surface common heights
                val allowed = setOf(360, 480, 720)
                val filtered = heights.filter { it in allowed }.ifEmpty { heights.toList() }
                val list = filtered.sorted().map { h -> mapOf("height" to h) }
                val currentH = player.videoFormat?.height ?: 0
                sendEvent("qualitiesUpdate", mapOf("qualities" to list, "currentHeight" to currentH))
            }
        })
    }

    override fun getView(): View = root

    override fun dispose() {
        scope.cancel()
        player.release()
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "load" -> {
                val videoId = call.argument<String>("videoId")
                if (videoId.isNullOrBlank()) {
                    result.error("arg_error", "videoId required", null)
                } else {
                    scope.launch { loadVideo(videoId) }
                    result.success(null)
                }
            }
            "play" -> { player.play(); result.success(null) }
            "pause" -> { player.pause(); result.success(null) }
            "seekTo" -> { player.seekTo((call.argument<Long>("ms") ?: 0L)); result.success(null) }
            "setSpeed" -> {
                val spd = call.argument<Double>("speed")?.toFloat() ?: 1f
                player.setPlaybackSpeed(spd); result.success(null)
            }
            "setQuality" -> {
                val height = call.argument<Int>("id") ?: call.argument<Int>("height")
                if (height != null) {
                    if (currentSourceType == "progressive" && progressiveByHeight.containsKey(height)) {
                        // Swap progressive source preserving position
                        progressiveByHeight[height]?.takeIf { it.isNotBlank() }?.let { u ->
                            val pos = player.currentPosition
                            val httpFactory = DefaultHttpDataSource.Factory()
                                .setUserAgent("Mozilla/5.0 (Android) ExoPlayer")
                                .setAllowCrossProtocolRedirects(true)
                            val dsf = DefaultDataSource.Factory(root.context, httpFactory)
                            val item = MediaItem.fromUri(Uri.parse(u))
                            val ms = com.google.android.exoplayer2.source.ProgressiveMediaSource.Factory(dsf)
                                .createMediaSource(item)
                            player.setMediaSource(ms)
                            player.prepare()
                            player.seekTo(pos)
                            player.playWhenReady = true
                        }
                    } else {
                        // Adaptive (DASH/HLS): guide track selector
                        val params = trackSelector.parameters
                        val newParams = params
                            .buildUpon()
                            .setMaxVideoSize(Int.MAX_VALUE, height)
                            .build()
                        trackSelector.setParameters(newParams)
                    }
                }
                result.success(null)
            }
            "setSubtitle" -> {
                val lang = call.argument<String>("lang")
                val chosen = availableSubtitles.firstOrNull { it["lang"] == lang }
                val base = lastDashUrl ?: lastHlsUrl
                if (chosen != null && base != null) {
                    val subUrl = chosen["url"]
                    if (subUrl != null) {
                        val subtitle = MediaItem.SubtitleConfiguration.Builder(Uri.parse(subUrl))
                            .setMimeType(MimeTypes.TEXT_VTT)
                            .setLanguage(lang)
                            .setSelectionFlags(C.SELECTION_FLAG_DEFAULT)
                            .build()
                        val mediaItem = MediaItem.Builder()
                            .setUri(base)
                            .setSubtitleConfigurations(listOf(subtitle))
                            .build()
                        val pos = player.currentPosition
                        player.setMediaItem(mediaItem, pos)
                        player.prepare()
                        player.playWhenReady = true
                    }
                }
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }

    private fun sendEvent(type: String, data: Map<String, Any?>) {
        eventsSink?.success(mapOf("type" to type, "data" to data))
    }

    private suspend fun loadVideo(videoId: String) {
        try {
            NewPipe.init(DownloaderImpl.okHttp(), Localization.DEFAULT)
            val url = if (videoId.startsWith("http://") || videoId.startsWith("https://")) {
                videoId
            } else {
                "https://www.youtube.com/watch?v=$videoId"
            }
            val service = ServiceList.YouTube
            val info: StreamInfo = StreamInfo.getInfo(service, url)

            val dashUrl = info.dashMpdUrl
            val hlsUrl = info.hlsUrl
            lastDashUrl = dashUrl
            lastHlsUrl = hlsUrl

            withContext(Dispatchers.Main) {
                val httpFactory = DefaultHttpDataSource.Factory()
                    .setUserAgent("Mozilla/5.0 (Android) ExoPlayer")
                    .setAllowCrossProtocolRedirects(true)
                val dsf = DefaultDataSource.Factory(root.context, httpFactory)
                val validDash = dashUrl?.takeIf { it.isNotBlank() && (it.startsWith("http://") || it.startsWith("https://")) }
                val validHls = hlsUrl?.takeIf { it.isNotBlank() && (it.startsWith("http://") || it.startsWith("https://")) }
                sendEvent("debug", mapOf(
                    "streams" to mapOf(
                        "videoCount" to info.videoStreams.size,
                        "dash" to (validDash != null),
                        "hls" to (validHls != null)
                    )
                ))
                val mediaSource: MediaSource = when {
                    validDash != null -> {
                        sendEvent("debug", mapOf("type" to "dash", "chosenUrl" to validDash))
                        currentSourceType = "dash"
                        progressiveByHeight = emptyMap()
                        DashMediaSource.Factory(dsf)
                            .createMediaSource(MediaItem.fromUri(Uri.parse(validDash)))
                    }
                    validHls != null -> {
                        sendEvent("debug", mapOf("type" to "hls", "chosenUrl" to validHls))
                        currentSourceType = "hls"
                        progressiveByHeight = emptyMap()
                        HlsMediaSource.Factory(dsf)
                            .createMediaSource(MediaItem.fromUri(Uri.parse(validHls)))
                    }
                    else -> {
                        // Fallback to progressive muxed stream
                        // Build height->url map for quality switching
                        progressiveByHeight = info.videoStreams
                            .mapNotNull { s ->
                                val u = s.url
                                if (u != null && (u.startsWith("http://") || u.startsWith("https://"))) s.height to u else null
                            }
                            .toMap()

                        val best = info.videoStreams.maxByOrNull { it.bitrate }
                        val progUrl = best?.url
                        if (progUrl.isNullOrBlank() || !(progUrl.startsWith("http://") || progUrl.startsWith("https://"))) {
                            sendEvent("error", mapOf("message" to "No playable stream url found"))
                            return@withContext
                        }
                        sendEvent("debug", mapOf("type" to "progressive", "chosenUrl" to progUrl))
                        currentSourceType = "progressive"
                        val item = MediaItem.fromUri(Uri.parse(progUrl))
                        com.google.android.exoplayer2.source.ProgressiveMediaSource.Factory(dsf)
                            .createMediaSource(item)
                    }
                }
                player.setMediaSource(mediaSource)
                player.prepare()
                player.playWhenReady = true

                val qualities = info.videoStreams.map { s ->
                    val mime = MediaFormat.getMimeById(s.formatId)
                    mapOf(
                        "itag" to s.itag,
                        "height" to s.height,
                        "mime" to mime,
                        "bitrate" to s.bitrate
                    )
                }
                val subs = info.subtitles.map { s -> mapOf("lang" to s.languageTag, "url" to s.url) }
                availableSubtitles = subs.mapNotNull { m ->
                    val l = m["lang"]
                    val u = m["url"]
                    if (l is String && u is String) mapOf("lang" to l, "url" to u) else null
                }

                sendEvent(
                    "loaded",
                    mapOf(
                        "title" to info.name,
                        "durationMs" to (info.duration * 1000),
                        "qualities" to qualities,
                        "subtitles" to subs
                    )
                )
            }
        } catch (e: Throwable) {
            withContext(Dispatchers.Main) {
                sendEvent("error", mapOf("message" to (e.message ?: "unknown")))
            }
        }
    }
}
