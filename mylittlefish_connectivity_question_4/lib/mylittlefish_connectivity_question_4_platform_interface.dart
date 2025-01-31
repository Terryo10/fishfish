import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'mylittlefish_connectivity_question_4_method_channel.dart';

abstract class MylittlefishConnectivityQuestion_4Platform extends PlatformInterface {
  MylittlefishConnectivityQuestion_4Platform() : super(token: _token);

  static final Object _token = Object();
  static MylittlefishConnectivityQuestion_4Platform _instance = MethodChannelMylittlefishConnectivityQuestion_4();

  static MylittlefishConnectivityQuestion_4Platform get instance => _instance;

  static set instance(MylittlefishConnectivityQuestion_4Platform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool> hasConnectivity() {
    throw UnimplementedError('hasConnectivity() has not been implemented.');
  }

  Stream<bool> get onConnectivityChanged {
    throw UnimplementedError('onConnectivityChanged has not been implemented.');
  }
}
