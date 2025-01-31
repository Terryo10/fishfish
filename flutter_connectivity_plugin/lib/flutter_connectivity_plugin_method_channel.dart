import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_connectivity_plugin_platform_interface.dart';

/// An implementation of [FlutterConnectivityPluginPlatform] that uses method channels.
class MethodChannelFlutterConnectivityPlugin extends FlutterConnectivityPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_connectivity_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
