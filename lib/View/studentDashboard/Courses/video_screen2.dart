import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class NewVideoScreen2 extends StatefulWidget {
  final String? videoName;

  const NewVideoScreen2({Key? key, this.videoName}) : super(key: key);

  @override
  _NewVideoScreen2State createState() => _NewVideoScreen2State();
}

const List<String> _videoIds = [
  'j4lDDQTKN8s',
  'bmgia-h1qNg',
  'Cohbiz2lOQI',
  'CoNgsfBbxJk',
  'c9gzcPkSdw0',
  'UEA_uwpvqtI',
  'j61j9X4xCnA',
];

class _NewVideoScreen2State extends State<NewVideoScreen2> {
  late YoutubePlayerController _controller;
  int _videoPositionInSeconds = 0;
  int _videoDurationInSeconds = 0;
  Timer? _positionTimer;

  bool _showControls = true;
  Timer? _hideTimer;

  void _startHideTimer() {
    _hideTimer?.cancel(); // cancel if running
    _hideTimer = Timer(const Duration(seconds: 5), () {
      setState(() {
        _showControls = false;
      });
    });
  }

  void _onScreenTap() {
    setState(() {
      _showControls = !_showControls;
    });
    if (_showControls) {
      _startHideTimer();
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final hours = duration.inHours;
    return hours > 0 ? '$hours:$minutes:$seconds' : '$minutes:$seconds';
  }

  @override
  void initState() {
    super.initState();
    super.initState();
    _startHideTimer();
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showVideoAnnotations: false,
        enableKeyboard: false,
        strictRelatedVideos: true,
        enableCaption: false,
        playsInline: false,
        enableJavaScript: true,
        loop: false,
        showControls: false,
        mute: false,
        showFullscreenButton: false,
      ),
    );

    @override
    void dispose() {
      _hideTimer?.cancel();
      super.dispose();
    }

    _controller.setFullScreenListener((isFullScreen) {
      if (!isFullScreen) {
        // When user exits fullscreen, navigate back
        Navigator.pop(context);
      }
    });

    if (widget.videoName != null) {
      _controller.loadVideoById(videoId: widget.videoName!);
    } else {
      _controller.loadPlaylist(
        list: _videoIds,
        listType: ListType.playlist,
        startSeconds: 136,
      );
    }

    // Force fullscreen mode when entering the screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.enterFullScreen();
    });

    // Start periodic timer to track position
    _positionTimer = Timer.periodic(Duration(milliseconds: 500), (_) async {
      final position = await _controller.currentTime;
      final duration = (await _controller.metadata).duration.inSeconds;
      if (mounted) {
        setState(() {
          _videoPositionInSeconds = position.toInt();
          _videoDurationInSeconds = duration;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Exit fullscreen before navigating back
        _controller.exitFullScreen();
        return true; // Allow back navigation
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: IgnorePointer(
                ignoring: true,
                child: YoutubePlayerScaffold(
                  controller: _controller,
                  builder: (context, player) {
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        if (kIsWeb && constraints.maxWidth > 750) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  children: [
                                    player,
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                        return ListView(
                          children: [
                            player,
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            if (_showControls)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Control Buttons Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // IconButton(
                        //   icon: Icon(Icons.skip_previous, color: Colors.white),
                        //   onPressed: () => _controller.previousVideo(),
                        // ),
                        IconButton(
                          icon: Icon(Icons.replay_10, color: Colors.white),
                          onPressed: () {
                            _controller.currentTime.then((currentTime) {
                              _controller.seekTo(
                                  seconds:
                                      (currentTime - 10).clamp(0, currentTime),
                                  allowSeekAhead: true);
                            });
                          },
                        ),
                        YoutubeValueBuilder(
                          controller: _controller,
                          builder: (context, value) {
                            return IconButton(
                              icon: Icon(
                                value.playerState == PlayerState.playing
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                value.playerState == PlayerState.playing
                                    ? _controller.pauseVideo()
                                    : _controller.playVideo();
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.forward_10, color: Colors.white),
                          onPressed: () {
                            _controller
                              ..currentTime.then((currentTime) {
                                _controller.seekTo(
                                    seconds: currentTime + 10,
                                    allowSeekAhead: true);
                              });
                          },
                        ),
                        // IconButton(
                        //   icon: Icon(Icons.skip_next, color: Colors.white),
                        //   onPressed: () => _controller.nextVideo(),
                        // ),
                      ],
                    ),
                    // Playback Speed Buttons Row
                    YoutubeValueBuilder(
                      controller: _controller,
                      builder: (context, value) {
                        final speeds = [1.0, 1.25, 1.5, 1.75, 2.0];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: speeds.map((speed) {
                            final isSelected = value.playbackRate == speed;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: isSelected
                                      ? Color(0xFFFF0033)
                                      : Colors.transparent,
                                  side: BorderSide(color: Colors.white),
                                ),
                                onPressed: () {
                                  _controller.setPlaybackRate(speed);
                                  setState(() {});
                                },
                                child: Text(
                                  '${speed}x',
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.white70,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),

                    // Video Progress Slider with time
                    YoutubeValueBuilder(
                      controller: _controller,
                      builder: (context, value) {
                        return Material(
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              Slider(
                                value: _videoPositionInSeconds
                                    .clamp(0, _videoDurationInSeconds)
                                    .toDouble(),
                                min: 0.0,
                                max: _videoDurationInSeconds > 0
                                    ? _videoDurationInSeconds.toDouble()
                                    : 1.0,
                                activeColor: Color(0xFFFF0033),
                                inactiveColor: Color(0xFF686E70),
                                onChanged: (newValue) {
                                  _controller.seekTo(
                                      seconds: newValue, allowSeekAhead: true);
                                  setState(() {
                                    _videoPositionInSeconds = newValue.toInt();
                                  });
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _formatDuration(Duration(
                                          seconds: _videoPositionInSeconds)),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      _formatDuration(Duration(
                                          seconds: _videoDurationInSeconds)),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _positionTimer?.cancel();
    _controller.close();

    super.dispose();
  }
}
