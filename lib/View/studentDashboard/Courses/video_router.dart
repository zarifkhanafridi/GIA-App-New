import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:academy/util/player_selector.dart';
import 'videoScreen3.dart';
import 'native_video_screen.dart';

/// Router class that handles video player selection
/// Automatically routes to the appropriate video player based on user preference
///
/// Usage throughout the app:
/// - VideoRouter.navigateToVideo(videoId: "your_video_id")
/// - VideoRouter.navigateToVideoWithName(videoName: "your_video_name")
class VideoRouter {
  /// Navigate to video screen with appropriate player
  static void navigateToVideo({
    required String videoId,
    String? videoName,
  }) {
    if (PlayerSelector.shouldUseNativePlayer()) {
      // Use new native player
      Get.to(() => NativeVideoScreen(videoId: videoId));
    } else {
      // Use old YouTube player
      Get.to(() => NewVideoScreen3(videoName: videoId));
    }
  }

  /// Navigate to video screen with video name (for YouTube player)
  static void navigateToVideoWithName({
    required String videoName,
  }) {
    if (PlayerSelector.shouldUseNativePlayer()) {
      // Use new native player with video name as ID
      Get.to(() => NativeVideoScreen(videoId: videoName));
    } else {
      // Use old YouTube player
      Get.to(() => NewVideoScreen3(videoName: videoName));
    }
  }

  /// Get the current player type
  static String getCurrentPlayerType() {
    return PlayerSelector.shouldUseNativePlayer() ? 'Native' : 'YouTube';
  }

  /// Check if native player is enabled
  static bool isNativePlayerEnabled() {
    return PlayerSelector.shouldUseNativePlayer();
  }
}
