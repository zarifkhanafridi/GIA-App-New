import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';

/// Utility class to manage video player selection
/// Handles switching between old YouTube player and new native player
class PlayerSelector extends GetxController {
  static const String _preferenceKey = 'use_native_player';

  // Reactive variable for player preference
  static final RxBool _useNativePlayer = false.obs;

  /// Initialize the player selector
  static void init() {
    _useNativePlayer.value = Hive.box('userBox')
        .get(_preferenceKey, defaultValue: true); // Default to native player
  }

  /// Check if native player should be used
  static bool shouldUseNativePlayer() {
    return _useNativePlayer.value;
  }

  /// Set the player preference
  static void setPlayerPreference(bool useNative) {
    _useNativePlayer.value = useNative;
    Hive.box('userBox').put(_preferenceKey, useNative);
  }

  /// Get current player preference
  static bool getPlayerPreference() {
    return _useNativePlayer.value;
  }

  /// Toggle between players
  static bool togglePlayer() {
    final newValue = !_useNativePlayer.value;
    setPlayerPreference(newValue);
    return newValue;
  }

  /// Get player display name
  static String getPlayerDisplayName() {
    return _useNativePlayer.value
        ? 'Youtube Player (New)'
        : 'YouTube Player (Old)';
  }

  /// Get player description
  static String getPlayerDescription() {
    return _useNativePlayer.value
        ? 'Using the new native ExoPlayer with better performance'
        : 'Using the traditional YouTube iframe player';
  }

  /// Get the reactive variable for UI updates
  static RxBool get reactiveValue => _useNativePlayer;

  /// Force refresh the preference from storage
  static void refreshFromStorage() {
    _useNativePlayer.value =
        Hive.box('userBox').get(_preferenceKey, defaultValue: true);
  }
}
