import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'connectivity_checker_platform_interface.dart';

/// An implementation of [ConnectivityCheckerPlatform] that uses method channels.
class MethodChannelConnectivityChecker extends ConnectivityCheckerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('connectivity_checker');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
