import 'dart:async';
import 'dart:developer';

import 'package:academy/View/commonPage/background.dart';
import 'package:academy/theme/colors/light_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:screen_capture_restrictions/screen_capture_restrictions.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoScreen extends StatefulWidget {
  final String? videoName;

  const VideoScreen({Key? key, this.videoName}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}





// class _VideoScreenState extends State<VideoScreen> {
//   late final List<YoutubePlayerController> _controllers;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controllers = List.generate(
//       widget.videoName!.length,
//           (index) {
//         final controller = YoutubePlayerController.fromVideoId(
//           videoId: widget.videoName!,
//       autoPlay: true,
//       params: const YoutubePlayerParams(
//         enableCaption: true,
//         showFullscreenButton: true,
//         mute: false,
//         showControls: true,
//         playsInline: true,
//         enableJavaScript: true,
//         loop: true,
//         strictRelatedVideos: true,
//       ),
//         );
//
//         controller.setFullScreenListener(
//               (_) async {
//             final videoData = await controller.videoData;
//             final startSeconds = await controller.currentTime;
//
//             if (!mounted) return;
//
//             final currentTime = await FullscreenYoutubePlayer.launch(
//               context,
//               videoId: videoData.videoId,
//               startSeconds: startSeconds,
//             );
//
//             if (currentTime != null) {
//               controller.seekTo(seconds: currentTime);
//             }
//           },
//         );
//
//         return controller;
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Video List Demo'),
//       ),
//       body: GridView.builder(
//         padding: const EdgeInsets.all(16),
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: MediaQuery.sizeOf(context).width > 500 ? 2 : 1,
//           crossAxisSpacing: 8,
//           mainAxisSpacing: 8,
//           childAspectRatio: 16 / 9,
//         ),
//         itemCount: _controllers.length,
//         itemBuilder: (context, index) {
//           final controller = _controllers[index];
//
//           return YoutubePlayer(
//             key: ObjectKey(controller),
//             aspectRatio: 16 / 9,
//             enableFullScreenOnVerticalDrag: false,
//             controller: controller,
//             // keepAlive: true,
//           );
//         },
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     for (final controller in _controllers) {
//       controller.close();
//     }
//
//     super.dispose();
//   }
// }
const List<String> _videoIds = [
  'j4lDDQTKN8s',
  'bmgia-h1qNg',
  'Cohbiz2lOQI',
  'CoNgsfBbxJk',
  'c9gzcPkSdw0',
  'UEA_uwpvqtI',
  'j61j9X4xCnA',
];


class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(showVideoAnnotations: true,
        enableKeyboard: true,
        strictRelatedVideos: false,

        enableCaption: true,
        playsInline: false,
        enableJavaScript: false,
        loop: false,
        showControls: true,
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
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Exit fullscreen before navigating back
        _controller.exitFullScreen();
        return true; // Allow back navigation
      },
      child: SafeArea(
        child: YoutubePlayerScaffold(
          controller: _controller,
          builder: (context, player) {
            return Scaffold(
              body: LayoutBuilder(
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
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}


// class Controls extends StatelessWidget {
//   ///
//   const Controls({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const MetaDataSection(),
//           _space,
//           // const SourceInputSection(),
//           _space,
//           PlayPauseButtonBar(),
//           _space,
//           const VideoPositionSeeker(),
//           // _space,
//           // const PlayerStateSection(),
//         ],
//       ),
//     );
//   }
//
//   Widget get _space => const SizedBox(height: 10);
// }
// class _VideoScreenState extends State<VideoScreen> with WidgetsBindingObserver {
//   late final YoutubePlayerController _controller;
//   Timer? _timer;
//   bool isFullScreen = false;
//   Duration totalDuration = Duration.zero;
//   Duration watchedTime = Duration.zero;
//   // final screenCaptureRestriction = ScreenCaptureRestrictions();
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this); // Add observer
//     // enableScreenCapture();
//
//     // screenCaptureRestriction.addScreenShotListener((imgPath) {
//     //   print('Screenshot taken: $imgPath');
//     // });
//     //
//     // screenCaptureRestriction.addScreenRecordListener((isRecording) {
//     //   print('Screen Recording: $isRecording');
//     // });
//
//     final videoId = widget.videoName?.isNotEmpty == true
//         ? widget.videoName!
//         : 'dQw4w9WgXcQ'; // Default video ID
//
//     _controller = YoutubePlayerController.fromVideoId(
//       videoId: videoId,
//       autoPlay: true,
//       params: const YoutubePlayerParams(
//         enableCaption: true,
//         showFullscreenButton: true,
//         mute: false,
//         showControls: true,
//         playsInline: true,
//         enableJavaScript: true,
//         loop: true,
//         strictRelatedVideos: true,
//       ),
//     );
//
//     // Listen for fullscreen changes
//     _controller.listen((event) {
//       if (mounted) {
//         setState(() {
//           isFullScreen = event.fullScreenOption.enabled;
//         });
//       }
//     });
//
//     _startTrackingTime();
//   }
//
//   void _startTrackingTime() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
//       final seconds = await _controller.currentTime;
//       if (mounted) {
//         setState(() {
//           watchedTime = Duration(seconds: seconds.toInt());
//         });
//       }
//     });
//   }
//
//   // enableScreenCapture() async {
//   //   await ScreenCaptureRestrictions.enableSecure();
//   // }
//   //
//   // disableScreenCapture() async {
//   //   await ScreenCaptureRestrictions.disableSecure();
//   // }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _timer?.cancel();
//     _controller.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Duration remainingTime = totalDuration - watchedTime;
//
//     return SafeArea(
//       child: Background(
//         child: Scaffold(
//           appBar: isFullScreen
//               ? null
//               : AppBar(
//                   backgroundColor: Colors.transparent,
//                   leading: IconButton(
//                     icon: const Icon(Icons.arrow_back, color: Colors.white),
//                     onPressed: () {
//                       if (isFullScreen) {
//                         _controller.listen((event) {
//                           event.fullScreenOption.locked == false;
//                         });
//                       } else {
//                         Navigator.pop(context);
//                         // disableScreenCapture();
//                       }
//                     },
//                   ),
//                 ),
//           backgroundColor: Colors.transparent,
//           body: Column(
//             children: [
//               if (!isFullScreen)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   child: Text(
//                     _controller.metadata.title,
//                     style: const TextStyle(
//                       color: Colors.black,
//                       fontSize: 18.0,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 2,
//                   ),
//                 ),
//               Expanded(
//                 child: YoutubePlayerScaffold(
//                   enableFullScreenOnVerticalDrag: true,
//                   controller: _controller,
//                   aspectRatio: 16 / 9,
//                   builder: (BuildContext context, Widget player) {
//                     return player;
//                   },
//                 ),
//               ),
//               if (!isFullScreen)
//                 Column(
//                   children: [
//                     _text(
//                       'Playback Quality',
//                       _controller.value.playbackQuality ?? '',
//                     ),
//                     _text(
//                       'Playback Rate',
//                       '${_controller.value.playbackRate}x',
//                     ),
//                     Text(
//                       "${_formatDuration(watchedTime)}/${_formatDuration(remainingTime)}",
//                       style: const TextStyle(color: Colors.blue),
//                     ),
//                   ],
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   String _formatDuration(Duration duration) {
//     String minutes = duration.inMinutes.toString().padLeft(2, '0');
//     String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
//     return "$minutes:$seconds";
//   }
//
//   Widget _text(String title, String value) {
//     return RichText(
//       text: TextSpan(
//         text: '$title: ',
//         style: const TextStyle(
//           color: AppColors.kDarkBlue,
//           fontWeight: FontWeight.w700,
//         ),
//         children: [
//           TextSpan(
//             text: value,
//             style: const TextStyle(
//               color: Colors.blue,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


//
// class VideoPlaylistIconButton extends StatelessWidget {
//   ///
//   const VideoPlaylistIconButton({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = context.ytController;
//
//     return IconButton(
//       onPressed: () async {
//         controller.pauseVideo();
//         // router.go('/playlist');
//       },
//       icon: const Icon(Icons.playlist_play_sharp),
//     );
//   }
// }
//
//
// class VideoPositionIndicator extends StatelessWidget {
//   ///
//   const VideoPositionIndicator({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = context.ytController;
//
//     return StreamBuilder<YoutubeVideoState>(
//       stream: controller.videoStateStream,
//       initialData: const YoutubeVideoState(),
//       builder: (context, snapshot) {
//         final position = snapshot.data?.position.inMilliseconds ?? 0;
//         final duration = controller.metadata.duration.inMilliseconds;
//
//         return LinearProgressIndicator(
//           value: duration == 0 ? 0 : position / duration,
//           minHeight: 1,
//         );
//       },
//     );
//   }
// }
//
// ///
// class VideoPositionSeeker extends StatelessWidget {
//   ///
//   const VideoPositionSeeker({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var value = 0.0;
//
//     return Row(
//       children: [
//         const Text(
//           'Seek',
//           style: TextStyle(fontWeight: FontWeight.w300),
//         ),
//         const SizedBox(width: 14),
//         Expanded(
//           child: StreamBuilder<YoutubeVideoState>(
//             stream: context.ytController.videoStateStream,
//             initialData: const YoutubeVideoState(),
//             builder: (context, snapshot) {
//               final position = snapshot.data?.position.inSeconds ?? 0;
//               final duration = context.ytController.metadata.duration.inSeconds;
//
//               value = position == 0 || duration == 0 ? 0 : position / duration;
//
//               return StatefulBuilder(
//                 builder: (context, setState) {
//                   return Slider(
//                     value: value,
//                     onChanged: (positionFraction) {
//                       value = positionFraction;
//                       setState(() {});
//
//                       context.ytController.seekTo(
//                         seconds: (value * duration).toDouble(),
//                         allowSeekAhead: true,
//                       );
//                     },
//                     min: 0,
//                     max: 1,
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }






// class MetaDataSection extends StatelessWidget {
//   const MetaDataSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return YoutubeValueBuilder(
//       buildWhen: (o, n) {
//         return o.metaData != n.metaData ||
//             o.playbackQuality != n.playbackQuality;
//       },
//       builder: (context, value) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _Text('Title', value.metaData.title),
//             const SizedBox(height: 10),
//             _Text('Channel', value.metaData.author),
//             const SizedBox(height: 10),
//             _Text(
//               'Playback Quality',
//               value.playbackQuality ?? '',
//             ),
//             const SizedBox(height: 10),
//             const _Text(
//               'Speed',
//               '',
//             ),
//             YoutubeValueBuilder(
//               builder: (context, value) {
//                 return DropdownButton(
//                   value: value.playbackRate,
//                   isDense: true,
//                   underline: const SizedBox(),
//                   items: PlaybackRate.all
//                       .map(
//                         (rate) => DropdownMenuItem(
//                       value: rate,
//                       child: Text(
//                         '${rate}x',
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w300,
//                         ),
//                       ),
//                     ),
//                   )
//                       .toList(),
//                   onChanged: (double? newValue) {
//                     if (newValue != null) {
//                       context.ytController.setPlaybackRate(newValue);
//                     }
//                   },
//                 );
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
//
// class _Text extends StatelessWidget {
//   final String title;
//   final String value;
//
//   const _Text(this.title, this.value);
//
//   @override
//   Widget build(BuildContext context) {
//     return Text.rich(
//       TextSpan(
//         text: '$title : ',
//         style: Theme.of(context).textTheme.labelLarge,
//         children: [
//           TextSpan(
//             text: value,
//             style: Theme.of(context)
//                 .textTheme
//                 .labelMedium!
//                 .copyWith(fontWeight: FontWeight.w300),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
// class PlayPauseButtonBar extends StatelessWidget {
//   PlayPauseButtonBar({super.key});
//
//   final ValueNotifier<bool> _isMuted = ValueNotifier(false);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         IconButton(
//           icon: const Icon(Icons.skip_previous),
//           onPressed: context.ytController.previousVideo,
//         ),
//         YoutubeValueBuilder(
//           builder: (context, value) {
//             return IconButton(
//               icon: Icon(
//                 value.playerState == PlayerState.playing
//                     ? Icons.pause
//                     : Icons.play_arrow,
//               ),
//               onPressed: () {
//                 value.playerState == PlayerState.playing
//                     ? context.ytController.pauseVideo()
//                     : context.ytController.playVideo();
//               },
//             );
//           },
//         ),
//         ValueListenableBuilder<bool>(
//           valueListenable: _isMuted,
//           builder: (context, isMuted, _) {
//             return IconButton(
//               icon: Icon(isMuted ? Icons.volume_off : Icons.volume_up),
//               onPressed: () {
//                 _isMuted.value = !isMuted;
//                 isMuted
//                     ? context.ytController.unMute()
//                     : context.ytController.mute();
//               },
//             );
//           },
//         ),
//         IconButton(
//           icon: const Icon(Icons.skip_next),
//           onPressed: context.ytController.nextVideo,
//         ),
//       ],
//     );
//   }
// }
//
//
// class PlayerStateSection extends StatelessWidget {
//   const PlayerStateSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return YoutubeValueBuilder(
//       builder: (context, value) {
//         return AnimatedContainer(
//           duration: const Duration(milliseconds: 800),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20.0),
//             color: _getStateColor(value.playerState),
//           ),
//           width: double.infinity,
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             value.playerState.toString(),
//             style: const TextStyle(
//               fontWeight: FontWeight.w300,
//               color: Colors.white,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         );
//       },
//     );
//   }
//
//   Color _getStateColor(PlayerState state) {
//     switch (state) {
//       case PlayerState.unknown:
//         return Colors.grey[700]!;
//       case PlayerState.unStarted:
//         return Colors.pink;
//       case PlayerState.ended:
//         return Colors.red;
//       case PlayerState.playing:
//         return Colors.blueAccent;
//       case PlayerState.paused:
//         return Colors.orange;
//       case PlayerState.buffering:
//         return Colors.yellow;
//       case PlayerState.cued:
//         return Colors.blue[900]!;
//       default:
//         return Colors.blue;
//     }
//   }
// }
//
//
//
//
//
//
// class SourceInputSection extends StatefulWidget {
//   const SourceInputSection({super.key});
//
//   @override
//   State<SourceInputSection> createState() => _SourceInputSectionState();
// }
//
// class _SourceInputSectionState extends State<SourceInputSection> {
//   late TextEditingController _textController;
//   ListType? _playlistType;
//
//   @override
//   void initState() {
//     super.initState();
//     _textController = TextEditingController();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _PlaylistTypeDropDown(
//           onChanged: (type) {
//             _playlistType = type;
//             setState(() {});
//           },
//         ),
//         const SizedBox(height: 10),
//         AnimatedSize(
//           duration: const Duration(milliseconds: 300),
//           child: TextField(
//             controller: _textController,
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               hintText: _hint,
//               helperText: _helperText,
//               fillColor: Theme.of(context).colorScheme.background,
//               filled: true,
//               hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                 color: Theme.of(context).colorScheme.onSurfaceVariant,
//                 fontWeight: FontWeight.w300,
//               ),
//               suffixIcon: IconButton(
//                 icon: const Icon(Icons.clear),
//                 onPressed: () => _textController.clear(),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 10),
//         GridView.count(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           childAspectRatio: 4,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//           crossAxisCount: 2,
//           children: [
//             _Button(
//               action: 'Load',
//               onTap: () {
//                 context.ytController.loadVideoById(
//                   videoId: _cleanId(_textController.text) ?? '',
//                 );
//               },
//             ),
//             _Button(
//               action: 'Cue',
//               onTap: () {
//                 context.ytController.cueVideoById(
//                   videoId: _cleanId(_textController.text) ?? '',
//                 );
//               },
//             ),
//             _Button(
//               action: 'Load Playlist',
//               onTap: _playlistType == null
//                   ? null
//                   : () {
//                 context.ytController.loadPlaylist(
//                   list: [_textController.text],
//                   listType: _playlistType!,
//                 );
//               },
//             ),
//             _Button(
//               action: 'Cue Playlist',
//               onTap: _playlistType == null
//                   ? null
//                   : () {
//                 context.ytController.cuePlaylist(
//                   list: [_textController.text],
//                   listType: _playlistType!,
//                 );
//               },
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   String? get _helperText {
//     switch (_playlistType) {
//       case ListType.playlist:
//         return '"PLj0L3ZL0ijTdhFSueRKK-mLFAtDuvzdje", ...';
//       case ListType.userUploads:
//         return '"pewdiepie", "tseries"';
//       default:
//         return null;
//     }
//   }
//
//   String get _hint {
//     switch (_playlistType) {
//       case ListType.playlist:
//         return 'Enter playlist id';
//       case ListType.userUploads:
//         return 'Enter channel name';
//       default:
//         return r'Enter youtube <video id> or <link>';
//     }
//   }
//
//   String? _cleanId(String source) {
//     if (source.startsWith('http://') || source.startsWith('https://')) {
//       return YoutubePlayerController.convertUrlToId(source);
//     } else if (source.length != 11) {
//       _showSnackBar('Invalid Source');
//     }
//     return source;
//   }
//
//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           message,
//           textAlign: TextAlign.center,
//           style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
//         ),
//         behavior: SnackBarBehavior.floating,
//         elevation: 1,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(50),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _textController.dispose();
//     super.dispose();
//   }
// }
//
// class _PlaylistTypeDropDown extends StatefulWidget {
//   const _PlaylistTypeDropDown({required this.onChanged});
//
//   final ValueChanged<ListType?> onChanged;
//
//   @override
//   _PlaylistTypeDropDownState createState() => _PlaylistTypeDropDownState();
// }
//
// class _PlaylistTypeDropDownState extends State<_PlaylistTypeDropDown> {
//   ListType? _playlistType;
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField<ListType>(
//       decoration: InputDecoration(
//         border: InputBorder.none,
//         fillColor: Theme.of(context).colorScheme.background,
//         filled: true,
//       ),
//       isExpanded: true,
//       value: _playlistType,
//       items: [
//         DropdownMenuItem(
//           child: Text(
//             'Select playlist type',
//             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//               color: Theme.of(context).colorScheme.onSurfaceVariant,
//               fontWeight: FontWeight.w300,
//             ),
//           ),
//         ),
//         ...ListType.values.map(
//               (type) => DropdownMenuItem(value: type, child: Text(type.value)),
//         ),
//       ],
//       onChanged: (value) {
//         _playlistType = value;
//         setState(() {});
//         widget.onChanged(value);
//       },
//     );
//   }
// }
//
// class _Button extends StatelessWidget {
//   const _Button({required this.onTap, required this.action});
//
//   final VoidCallback? onTap;
//   final String action;
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onTap == null
//           ? null
//           : () {
//         onTap?.call();
//         FocusScope.of(context).unfocus();
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8),
//         child: Text(action),
//       ),
//     );
//   }
// }