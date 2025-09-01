import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../yt_native_player.dart';

class NativeVideoScreen extends StatelessWidget {
  final String videoId;
  const NativeVideoScreen({super.key, required this.videoId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   foregroundColor: Colors.white,
      //   title: const Text('Player', style: TextStyle(color: Colors.white)),
      // ),
      body: SafeArea(
        child: Center(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: YtNativePlayer(initialVideoId: videoId),
          ),
        ),
      ),
    );
  }
}

class NativeFullscreenRoute extends StatelessWidget {
  final String videoId;
  const NativeFullscreenRoute({super.key, required this.videoId});
  @override
  Widget build(BuildContext context) {
    // Force landscape on enter, restore on exit
    SystemChrome.setPreferredOrientations(const [
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return WillPopScope(
      onWillPop: () async {
        await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
        return true;
      },
      child: const SizedBox.shrink(),
    );
  }
}
