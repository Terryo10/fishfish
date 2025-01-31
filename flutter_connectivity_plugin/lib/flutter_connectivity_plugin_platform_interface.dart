import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_connectivity_plugin_method_channel.dart';

abstract class FlutterConnectivityPluginPlatform extends PlatformInterface {
  /// Constructs a FlutterConnectivityPluginPlatform.
  FlutterConnectivityPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterConnectivityPluginPlatform _instance = MethodChannelFlutterConnectivityPlugin();

  /// The default instance of [FlutterConnectivityPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterConnectivityPlugin].
  static FlutterConnectivityPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterConnectivityPluginPlatform] when
  /// they register themselves.
  static set instance(FlutterConnectivityPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
