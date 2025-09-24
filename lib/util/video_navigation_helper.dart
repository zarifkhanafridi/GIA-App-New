import 'package:academy/View/studentDashboard/Courses/video_router.dart';

/// Helper class for easy video navigation throughout the app
/// This provides simple methods that work with your existing video data
class VideoNavigationHelper {
  /// Navigate to video using course overview URL
  /// Use this for course overview videos
  static void playCourseOverview(String? courseOverviewUrl) {
    if (courseOverviewUrl == null || courseOverviewUrl.isEmpty) {
      return;
    }

    VideoRouter.navigateToVideo(videoId: courseOverviewUrl);
  }

  /// Navigate to video using video name
  /// Use this for course videos
  static void playCourseVideo(String? videoName) {
    if (videoName == null || videoName.isEmpty) {
      return;
    }

    VideoRouter.navigateToVideoWithName(videoName: videoName);
  }

  /// Navigate to video with any video ID
  /// Use this for any video content
  static void playVideo(String? videoId) {
    if (videoId == null || videoId.isEmpty) {
      return;
    }

    VideoRouter.navigateToVideo(videoId: videoId);
  }

  /// Check if native player is currently enabled
  static bool isNativePlayerEnabled() {
    return VideoRouter.isNativePlayerEnabled();
  }

  /// Get current player type as string
  static String getCurrentPlayerType() {
    return VideoRouter.getCurrentPlayerType();
  }
}
