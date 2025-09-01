package com.example.academy

import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.ResponseBody
import org.schabi.newpipe.extractor.downloader.Downloader
import org.schabi.newpipe.extractor.downloader.Response
import org.schabi.newpipe.extractor.downloader.Request as NPRequest
import java.io.IOException
import okhttp3.MediaType.Companion.toMediaTypeOrNull
import okhttp3.RequestBody

/**
 * Minimal OkHttp-based Downloader for NewPipeExtractor.
 */
object DownloaderImpl : Downloader() {
    private val client: OkHttpClient = OkHttpClient.Builder().build()

    fun okHttp(): Downloader = this

    private fun applyHeaders(builder: Request.Builder, headers: Map<String, List<String>>) {
        // Flatten headers (first value only)
        headers.forEach { (k, v) ->
            if (v.isNotEmpty()) builder.addHeader(k, v.first())
        }
        if (!headers.containsKey("User-Agent")) {
            builder.header(
                "User-Agent",
                "Mozilla/5.0 (Android 13; Mobile) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36"
            )
        }
    }

    private fun headersFirst(headers: Map<String, List<String>>, key: String): String? =
        headers[key]?.firstOrNull()

    @Throws(IOException::class)
    override fun execute(request: NPRequest): Response {
        val method = request.httpMethod()
        val url = request.url()
        val headers = request.headers()

        val builder = Request.Builder().url(url)
        applyHeaders(builder, headers)

        when (method.uppercase()) {
            "GET" -> builder.get()
            "HEAD" -> builder.head()
            "POST" -> {
                val bytes = request.dataToSend()
                val ct = headersFirst(headers, "Content-Type") ?: "application/octet-stream"
                val body: RequestBody = RequestBody.create(ct.toMediaTypeOrNull(), bytes ?: ByteArray(0))
                builder.post(body)
            }
            else -> builder.get()
        }

        client.newCall(builder.build()).execute().use { r ->
            val body: ResponseBody? = r.body
            val content = body?.string() ?: ""
            val headerMap: Map<String, List<String>> = r.headers.toMultimap()
            val latestUrl = r.request.url.toString()
            return Response(
                r.code,
                r.message,
                headerMap,
                content,
                latestUrl
            )
        }
    }
}
