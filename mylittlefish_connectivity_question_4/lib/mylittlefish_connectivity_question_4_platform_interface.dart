import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'mylittlefish_connectivity_question_4_method_channel.dart';

abstract class MylittlefishConnectivityQuestion_4Platform extends PlatformInterface {
  /// Constructs a MylittlefishConnectivityQuestion_4Platform.
  MylittlefishConnectivityQuestion_4Platform() : super(token: _token);

  static final Object _token = Object();

  static MylittlefishConnectivityQuestion_4Platform _instance = MethodChannelMylittlefishConnectivityQuestion_4();

  /// The default instance of [MylittlefishConnectivityQuestion_4Platform] to use.
  ///
  /// Defaults to [MethodChannelMylittlefishConnectivityQuestion_4].
  static MylittlefishConnectivityQuestion_4Platform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MylittlefishConnectivityQuestion_4Platform] when
  /// they register themselves.
  static set instance(MylittlefishConnectivityQuestion_4Platform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
