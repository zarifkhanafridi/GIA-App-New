import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class NewVideoScreen extends StatefulWidget {
  final String? videoName;

  const NewVideoScreen({Key? key, this.videoName}) : super(key: key);

  @override
  _NewVideoScreenState createState() => _NewVideoScreenState();
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

class _NewVideoScreenState extends State<NewVideoScreen> {
  late YoutubePlayerController _controller;
  int _videoPositionInSeconds = 0;
  int _videoDurationInSeconds = 0;
  Timer? _positionTimer;
  bool _hasEnteredFullscreen = false;


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
    
    // Validate video ID
    if (widget.videoName != null && widget.videoName!.isEmpty) {
      print('ERROR: Video ID is empty!');
      return;
    }
    
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showVideoAnnotations: false,
        enableKeyboard: false,
        strictRelatedVideos: true,
        enableCaption: false,
        playsInline: false,
        enableJavaScript: true,
        loop: false,
        showControls: true, // Enable controls so user can see the player
        mute: true, // Start muted to bypass autoplay restrictions
        showFullscreenButton: false,
      ),
    );

    _controller.setFullScreenListener((isFullScreen) {
      if (!isFullScreen) {
        // When user exits fullscreen, navigate back
        Navigator.pop(context);
      }
    });

    if (widget.videoName != null && widget.videoName!.isNotEmpty) {
      final videoId = widget.videoName!.trim();
      print('========================================');
      print('Loading YouTube Video');
      print('Video ID: $videoId');
      print('Video ID Length: ${videoId.length}');
      print('Video URL: https://www.youtube.com/watch?v=$videoId');
      print('Testing URL: https://www.youtube.com/embed/$videoId');
      print('========================================');
      
      try {
        _controller.loadVideoById(videoId: videoId, startSeconds: 0);
      } catch (e) {
        print('ERROR loading video: $e');
      }
      
      // Try to play the video after a delay (multiple attempts)
      Future.delayed(Duration(milliseconds: 2000), () {
        if (mounted) {
          try {
            print('Attempting to play video after load (attempt 1)...');
            _controller.playVideo();
          } catch (e) {
            print('Error playing video initially: $e');
          }
        }
      });
      
      // Second attempt after longer delay
      Future.delayed(Duration(milliseconds: 3500), () {
        if (mounted) {
          try {
            print('Attempting to play video after load (attempt 2)...');
            _controller.playVideo();
          } catch (e) {
            print('Error playing video on second attempt: $e');
          }
        }
      });
    } else {
      print('Loading YouTube Playlist with ${_videoIds.length} videos');
      _controller.loadPlaylist(
        list: _videoIds,
        listType: ListType.playlist,
        startSeconds: 136,
      );
    }

    // Note: Error handling will be done in the listen callback

    // Wait for player to be ready before entering fullscreen
    _controller.listen((value) async {
      // Check for errors in the player value
      if (value.hasError) {
        print('========================================');
        print('YouTube Player Error Detected!');
        print('Error: ${value.error}');
        print('Video ID: ${widget.videoName}');
        print('Video URL: https://www.youtube.com/watch?v=${widget.videoName}');
        print('========================================');
      }
      
      // Log all player state changes for debugging
      print('Player State Changed: ${value.playerState}');
      
      if (_hasEnteredFullscreen) return;
      
      // Handle video being cued - try to play it
      if (value.playerState == PlayerState.cued) {
        print('Video is cued, attempting to play...');
        try {
          Future.delayed(Duration(milliseconds: 500), () {
            if (mounted && !_hasEnteredFullscreen) {
              _controller.playVideo();
            }
          });
        } catch (e) {
          print('Error attempting to play video: $e');
        }
      }
      
      // Handle unStarted state - video loaded but not playing
      if (value.playerState == PlayerState.unStarted) {
        print('Video is unStarted, attempting to play...');
        try {
          Future.delayed(Duration(milliseconds: 800), () {
            if (mounted && !_hasEnteredFullscreen) {
              print('Calling playVideo() from unStarted state...');
              _controller.playVideo();
            }
          });
        } catch (e) {
          print('Error attempting to play video from unStarted: $e');
        }
      }
      
      // Handle buffering state - video might be ready to play
      if (value.playerState == PlayerState.buffering) {
        print('Video is buffering...');
        // Try to play after buffering completes
        Future.delayed(Duration(milliseconds: 1500), () {
          if (mounted && !_hasEnteredFullscreen) {
            try {
              // Check current state and try to play
              print('Attempting to play after buffering...');
              _controller.playVideo();
            } catch (e) {
              print('Error playing after buffering: $e');
            }
          }
        });
      }
      
      if (value.playerState == PlayerState.playing || 
          value.playerState == PlayerState.paused) {
        // Check if both metadata and videoData are available (indicates player is fully ready)
        try {
          final metadata = await _controller.metadata;
          final videoData = await _controller.videoData;
          
          // Unmute the video once it starts playing
          if (value.playerState == PlayerState.playing) {
            try {
              _controller.unMute();
              print('Video unmuted after starting to play');
            } catch (e) {
              print('Error unmuting video: $e');
            }
          }
          
          // Print video information
          print('========================================');
          print('YouTube Video Started Playing');
          print('Video ID: ${videoData.videoId}');
          print('Video Title: ${metadata.title}');
          print('Video Author: ${metadata.author}');
          print('Video Duration: ${metadata.duration}');
          print('Player State: ${value.playerState}');
          print('========================================');
          
          // Both are available, player is ready
          if (!_hasEnteredFullscreen && mounted) {
            _hasEnteredFullscreen = true;
            // Add longer delay to ensure YouTube JS API is fully initialized
            Future.delayed(Duration(milliseconds: 2500), () {
              if (mounted) {
                try {
                  print('Entering fullscreen mode for video: ${videoData.videoId}');
                  _controller.enterFullScreen();
                } catch (e) {
                  print('Error entering fullscreen: $e');
                }
              }
            });
          }
        } catch (e) {
          // Player data not ready yet, log the error
          print('Error getting video metadata/data: $e');
        }
      }
    });

    // Start periodic timer to track position
    _positionTimer = Timer.periodic(Duration(milliseconds: 500), (_) async {
      if (!mounted) return;
      try {
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
        // Handle errors silently to avoid crashes
        print('Error updating video position: $e');
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
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
    print('========================================');
    print('Video Screen Disposed');
    if (widget.videoName != null) {
      print('Closing video: ${widget.videoName}');
    }
    print('========================================');
    _positionTimer?.cancel();
    _controller.close();

    super.dispose();
  }
}
