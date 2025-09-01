import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class NewVideoScreen3 extends StatefulWidget {
  final String? videoName;

  const NewVideoScreen3({Key? key, this.videoName}) : super(key: key);

  @override
  _NewVideoScreen3State createState() => _NewVideoScreen3State();
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

class _NewVideoScreen3State extends State<NewVideoScreen3> {
  late YoutubePlayerController _controller;
  int _videoPositionInSeconds = 0;
  int _videoDurationInSeconds = 0;
  Timer? _positionTimer;
  bool _isLoading = true;
  String? _errorMessage;

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
    _initializeController();
  }

  void _initializeController() {
    try {
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

      _controller.setFullScreenListener((isFullScreen) {
        if (!isFullScreen) {
          // When user exits fullscreen, navigate back
          Navigator.pop(context);
        }
      });

      // Load video content
      _loadVideoContent();

      // Force fullscreen mode when entering the screen
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.enterFullScreen();
      });

      // Start periodic timer to track position
      _startPositionTimer();
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to initialize video player: $e';
        _isLoading = false;
      });
    }
  }

  void _loadVideoContent() {
    try {
      if (widget.videoName != null) {
        _controller.loadVideoById(videoId: widget.videoName!);
      } else {
        _controller.loadPlaylist(
          list: _videoIds,
          listType: ListType.playlist,
          startSeconds: 0, // Changed from 136 to 0 for better UX
        );
      }

      // Set loading to false after a short delay to allow video to load
      Future.delayed(Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load video: $e';
        _isLoading = false;
      });
    }
  }

  void _startPositionTimer() {
    _positionTimer = Timer.periodic(Duration(milliseconds: 500), (_) async {
      try {
        if (!mounted) return;

        final position = await _controller.currentTime;
        final metadata = await _controller.metadata;
        final duration = metadata.duration.inSeconds;

        if (mounted) {
          setState(() {
            _videoPositionInSeconds = position.toInt();
            _videoDurationInSeconds = duration;
          });
        }
      } catch (e) {
        // Handle timer errors silently to avoid crashes
        print('Error updating video position: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Exit fullscreen before navigating back
        try {
          _controller.exitFullScreen();
        } catch (e) {
          print('Error exiting fullscreen: $e');
        }
        return true; // Allow back navigation
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: _buildVideoPlayer(),
            ),
            if (_isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.black,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFFFF0033)),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Loading video...',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            if (_errorMessage != null)
              Positioned.fill(
                child: Container(
                  color: Colors.black,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, color: Colors.red, size: 48),
                        SizedBox(height: 16),
                        Text(
                          'Error loading video',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        SizedBox(height: 8),
                        Text(
                          _errorMessage!,
                          style: TextStyle(color: Colors.white70),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _errorMessage = null;
                              _isLoading = true;
                            });
                            _initializeController();
                          },
                          child: Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            if (!_isLoading && _errorMessage == null)
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
                            _controller.currentTime.then((currentTime) {
                              _controller.seekTo(
                                  seconds: currentTime + 10,
                                  allowSeekAhead: true);
                            });
                          },
                        ),
                      ],
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

  Widget _buildVideoPlayer() {
    return YoutubePlayerScaffold(
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
    );
  }

  @override
  void dispose() {
    _positionTimer?.cancel();
    try {
      _controller.close();
    } catch (e) {
      print('Error closing controller: $e');
    }
    super.dispose();
  }
}
