import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class YtNativePlayerController {
  final MethodChannel _methods;
  final StreamController<Map<String, dynamic>> _eventsCtrl =
      StreamController.broadcast();

  Stream<Map<String, dynamic>> get events => _eventsCtrl.stream;

  YtNativePlayerController(int viewId)
      : _methods = MethodChannel('custom_exoplayer/methods_$viewId') {
    final events = EventChannel('custom_exoplayer/events_$viewId');
    events.receiveBroadcastStream().listen((e) {
      _eventsCtrl.add(Map<String, dynamic>.from(e as Map));
    });
  }

  Future<void> load(String videoId) =>
      _methods.invokeMethod('load', {"videoId": videoId});
  Future<void> play() => _methods.invokeMethod('play');
  Future<void> pause() => _methods.invokeMethod('pause');
  Future<void> seekTo(Duration d) =>
      _methods.invokeMethod('seekTo', {"ms": d.inMilliseconds});
  Future<void> setSpeed(double s) =>
      _methods.invokeMethod('setSpeed', {"speed": s});
  Future<void> setQuality(dynamic idOrIdx) =>
      _methods.invokeMethod('setQuality', {"id": idOrIdx});
  Future<void> setSubtitle(String lang) =>
      _methods.invokeMethod('setSubtitle', {"lang": lang});
  Future<void> enterPip() => _methods.invokeMethod('enterPip');

  void dispose() {
    _eventsCtrl.close();
  }
}

class YtNativePlayer extends StatefulWidget {
  final String initialVideoId;
  final bool autoPlay;
  const YtNativePlayer(
      {super.key, required this.initialVideoId, this.autoPlay = true});

  @override
  State<YtNativePlayer> createState() => _YtNativePlayerState();
}

class _YtNativePlayerState extends State<YtNativePlayer> {
  YtNativePlayerController? controller;
  List<Map<String, dynamic>> qualities = [];
  List<Map<String, dynamic>> subtitles = [];
  bool isPlaying = false;
  String? title;
  int? currentHeight;
  bool _isFullscreen = false;
  bool _controllerVisible = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AndroidView(
          viewType: 'custom_exoplayer_view',
          onPlatformViewCreated: (id) async {
            controller = YtNativePlayerController(id);
            controller!.events.listen(_onEvent);
            await controller!.load(widget.initialVideoId);
          },
          creationParams: const {},
          creationParamsCodec: const StandardMessageCodec(),
        ),
        if (title != null && _controllerVisible)
          Positioned(
            left: 12,
            right: 12,
            top: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                title!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        // _buildControls(),
      ],
    );
  }

  Widget _buildControls() {
    return IgnorePointer(
      ignoring: false,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white),
                onPressed: () =>
                    isPlaying ? controller?.pause() : controller?.play(),
              ),
              const SizedBox(width: 8),
              _SpeedMenu(onSpeed: (s) => controller?.setSpeed(s)),
              const SizedBox(width: 8),
              _QualityMenu(
                qualities: qualities,
                currentHeight: currentHeight,
                onSelect: (q) => controller?.setQuality(q['height']),
              ),
              const SizedBox(width: 8),
              _SubtitleMenu(
                subtitles: subtitles,
                onSelect: (s) => controller?.setSubtitle(s['lang']),
              ),
              const Spacer(),
              // Fullscreen button removed; now controlled by native overlay via event
            ],
          ),
        ),
      ),
    );
  }

  void _onEvent(Map<String, dynamic> e) {
    final type = e['type'];
    final rawData = e['data'];
    final Map<String, dynamic> data = rawData is Map
        ? Map<String, dynamic>.from(rawData as Map)
        : <String, dynamic>{};
    if (type == 'isPlaying')
      setState(() => isPlaying = data['isPlaying'] == true);
    if (type == 'controllerVisibility') {
      final vis = data['visible'] == true;
      setState(() => _controllerVisible = vis);
    }
    if (type == 'toggleFullscreen') {
      _toggleFullscreen();
      return;
    }
    if (type == 'loaded') {
      setState(() {
        title = data['title'];
        final qList = data['qualities'];
        if (qList is List) {
          qualities = qList
              .map((it) => it is Map
                  ? Map<String, dynamic>.from(it)
                  : <String, dynamic>{})
              .where((m) => m.isNotEmpty)
              .toList();
        } else {
          qualities = [];
        }
        final sList = data['subtitles'];
        if (sList is List) {
          subtitles = sList
              .map((it) => it is Map
                  ? Map<String, dynamic>.from(it)
                  : <String, dynamic>{})
              .where((m) => m.isNotEmpty)
              .toList();
        } else {
          subtitles = [];
        }
      });
    }
    if (type == 'qualitiesUpdate') {
      setState(() {
        final qList = data['qualities'];
        if (qList is List) {
          qualities = qList
              .map((it) => it is Map
                  ? Map<String, dynamic>.from(it)
                  : <String, dynamic>{})
              .where((m) => m.isNotEmpty)
              .toList();
        } else {
          qualities = [];
        }
        currentHeight = data['currentHeight'];
      });
    }
    if (type == 'debug') {
      // Print chosen URL or any debug info from native
      // ignore: avoid_print
      print('[NativePlayer][DEBUG] ${data.toString()}');
    }
    if (type == 'error') {
      final msg = data['message']?.toString() ?? 'Unknown error';
      // ignore: avoid_print
      print('[NativePlayer][ERROR] $msg');
      final ctx = context;
      if (ctx.mounted) {
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(content: Text('Player error: $msg')),
        );
      }
    }
  }

  Future<void> _toggleFullscreen() async {
    if (!_isFullscreen) {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }
    if (mounted) setState(() => _isFullscreen = !_isFullscreen);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

class _SpeedMenu extends StatelessWidget {
  final void Function(double) onSpeed;
  const _SpeedMenu({required this.onSpeed});
  @override
  Widget build(BuildContext context) {
    final speeds = [0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0];
    return DropdownButton<double>(
      value: 1.0,
      dropdownColor: Colors.black87,
      style: const TextStyle(color: Colors.white),
      items: speeds
          .map((s) => DropdownMenuItem(value: s, child: Text('${s}x')))
          .toList(),
      onChanged: (v) {
        if (v != null) onSpeed(v);
      },
    );
  }
}

class _QualityMenu extends StatelessWidget {
  final List<Map<String, dynamic>> qualities;
  final int? currentHeight;
  final void Function(Map<String, dynamic>) onSelect;
  const _QualityMenu(
      {required this.qualities, required this.onSelect, this.currentHeight});
  @override
  Widget build(BuildContext context) {
    if (qualities.isEmpty) return const SizedBox.shrink();
    // Try to match the current playing height
    Map<String, dynamic>? selected = currentHeight == null
        ? null
        : qualities.cast<Map<String, dynamic>?>().firstWhere(
              (q) => (q?['height'] as int?) == currentHeight,
              orElse: () => null,
            );
    selected ??= qualities.last; // fallback to highest listed
    return DropdownButton<Map<String, dynamic>>(
      value: selected,
      dropdownColor: Colors.black87,
      style: const TextStyle(color: Colors.white),
      items: qualities.map((q) {
        final h = q['height'] ?? '?';
        final brVal = q['bitrate'];
        String br = '';
        if (brVal is num) br = ' ${(brVal / 1000).round()}kbps';
        return DropdownMenuItem(value: q, child: Text('${h}p$br'));
      }).toList(),
      onChanged: (v) {
        if (v != null) onSelect(v);
      },
      underline: const SizedBox.shrink(),
      iconEnabledColor: Colors.white,
    );
  }
}

class _SubtitleMenu extends StatelessWidget {
  final List<Map<String, dynamic>> subtitles;
  final void Function(Map<String, dynamic>) onSelect;
  const _SubtitleMenu({required this.subtitles, required this.onSelect});
  @override
  Widget build(BuildContext context) {
    if (subtitles.isEmpty) return const SizedBox.shrink();
    return DropdownButton<Map<String, dynamic>>(
      value: subtitles.first,
      dropdownColor: Colors.black87,
      style: const TextStyle(color: Colors.white),
      items: subtitles
          .map(
              (s) => DropdownMenuItem(value: s, child: Text(s['lang'] ?? 'cc')))
          .toList(),
      onChanged: (v) {
        if (v != null) onSelect(v);
      },
    );
  }
}
