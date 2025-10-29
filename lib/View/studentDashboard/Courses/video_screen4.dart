import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class NewVideoScreen extends StatefulWidget {
  final String? videoName;

  const NewVideoScreen({Key? key, this.videoName}) : super(key: key);

  @override
  _NewVideoScreen4State createState() => _NewVideoScreen4State();
}

class _NewVideoScreen4State extends State<NewVideoScreen> with WidgetsBindingObserver {
  YoutubePlayerController? _controller;
  bool _isLoading = true;
  String? _errorMessage;
  bool _hasRotatedToLandscape = false;
  bool _isInitializing = true;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    
    // Add orientation observer
    WidgetsBinding.instance.addObserver(this);
    
    // Force landscape orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    
    // Give time for landscape rotation, then mark as initialized
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted && !_isDisposed) {
        setState(() {
          _isInitializing = false;
        });
      }
    });
    
    // Initialize YouTube player
    _initializePlayer();
  }

  void _initializePlayer() {
    if (widget.videoName == null || widget.videoName!.isEmpty) {
      setState(() {
        _errorMessage = 'No video ID provided';
        _isLoading = false;
      });
      return;
    }

    final videoId = widget.videoName!.trim();
    
    // Debug logging
    debugPrint('========================================');
    debugPrint('Loading YouTube Video (video_screen4 - youtube_player_flutter)');
    debugPrint('Video ID: $videoId');
    debugPrint('Video URL: https://www.youtube.com/watch?v=$videoId');
    debugPrint('Embed URL: https://www.youtube.com/embed/$videoId');
    debugPrint('========================================');
    
    try {
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          enableCaption: true,
          controlsVisibleAtStart: true,
          loop: false,
          isLive: false,
          forceHD: true, // Set HD quality by default
          startAt: 0,
          hideControls: false,
          hideThumbnail: false,
          disableDragSeek: false,
        ),
      )..addListener(_playerListener);
    } catch (e) {
      debugPrint('Error initializing YouTube player: $e');
      if (mounted && !_isDisposed) {
        setState(() {
          _errorMessage = 'Failed to initialize video player';
          _isLoading = false;
        });
      }
    }
  }

  void _playerListener() {
    if (_isDisposed || !mounted || _controller == null) return;

    if (_controller!.value.isReady) {
      if (mounted && !_isDisposed && _isLoading) {
        setState(() {
          _isLoading = false;
        });
      }
    }

    if (_controller!.value.hasError) {
      debugPrint('YouTube Player Error: ${_controller!.value.errorCode}');
      if (mounted && !_isDisposed) {
        setState(() {
          _errorMessage = 'Error loading video: ${_controller!.value.errorCode}';
          _isLoading = false;
        });
      }
    }
  }
  
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    
    // Only check for portrait pop after initialization is complete
    if (_isDisposed || !mounted || _isInitializing) return;

    try {
      final mediaQuery = MediaQuery.of(context);
      
      // Track when we rotate to landscape
      if (mediaQuery.orientation == Orientation.landscape) {
        _hasRotatedToLandscape = true;
      }
      
      // Only pop if user manually rotates to portrait AFTER being in landscape
      if (mediaQuery.orientation == Orientation.portrait && _hasRotatedToLandscape) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted && !_isDisposed) {
            // Restore portrait mode and navigate back
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ]);
            Navigator.of(context).pop();
          }
        });
      }
    } catch (e) {
      debugPrint('Error checking orientation: $e');
    }
  }

  void _retryVideo() {
    if (_isDisposed || !mounted) return;
    
    setState(() {
      _errorMessage = null;
      _isLoading = true;
    });
    
    // Dispose old controller
    _controller?.dispose();
    _controller = null;
    
    // Reinitialize player
    _initializePlayer();
  }

  Future<void> _restoreOrientations() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Force portrait mode before going back
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        // Restore all orientations after a brief delay
        Future.delayed(const Duration(milliseconds: 100), _restoreOrientations);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // YouTube Player
            if (_controller != null && _errorMessage == null)
              Positioned.fill(
                child: YoutubePlayerBuilder(
                  onExitFullScreen: () {
                    // Handle fullscreen exit - ensure proper cleanup
                    debugPrint('Exited fullscreen');
                    // EGL context should stabilize automatically
                    // No additional action needed as dispose() handles cleanup
                  },
                  player: YoutubePlayer(
                    controller: _controller!,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: const Color(0xFFFF0033),
                    progressColors: const ProgressBarColors(
                      playedColor: Color(0xFFFF0033),
                      handleColor: Color(0xFFFF0033),
                      bufferedColor: Colors.grey,
                      backgroundColor: Colors.grey,
                    ),
                    onReady: () {
                      debugPrint('YouTube Player is ready - HD quality enabled');
                      if (mounted && !_isDisposed) {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                    onEnded: (metaData) {
                      debugPrint('Video ended');
                      // Optionally handle video end event
                    },
                  ),
                  builder: (context, player) => player,
                ),
              ),
            
            // Loading indicator
            if (_isLoading)
              const Positioned.fill(
                child: _LoadingIndicator(),
              ),
            
            // Error message
            if (_errorMessage != null)
              Positioned.fill(
                child: _ErrorWidget(
                  errorMessage: _errorMessage!,
                  onRetry: _retryVideo,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _isDisposed = true;
    
    // Remove orientation observer
    WidgetsBinding.instance.removeObserver(this);
    
    // Dispose controller with proper cleanup to prevent EGL errors
    try {
      _controller?.pause();
      _controller?.dispose();
      _controller = null;
    } catch (e) {
      debugPrint('Error disposing controller: $e');
    }
    
    // Force portrait mode when disposing
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    // Restore all orientations after a brief delay
    Future.delayed(const Duration(milliseconds: 200), _restoreOrientations);
    
    super.dispose();
  }
}

// Extracted loading indicator widget for better performance
class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF0033)),
            ),
            SizedBox(height: 16),
            Text(
              'Loading video...',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

// Extracted error widget for better performance
class _ErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const _ErrorWidget({
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.white70, size: 48),
              const SizedBox(height: 16),
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF0033),
                ),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}