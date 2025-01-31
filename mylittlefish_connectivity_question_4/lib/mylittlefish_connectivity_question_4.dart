import 'mylittlefish_connectivity_question_4_platform_interface.dart';

class MylittlefishConnectivityQuestion_4 {
  Future<String?> getPlatformVersion() {
    return MylittlefishConnectivityQuestion_4Platform.instance.getPlatformVersion();
  }

  Future<bool> hasConnectivity() {
    return MylittlefishConnectivityQuestion_4Platform.instance.hasConnectivity();
  }

  Stream<bool> get onConnectivityChanged {
    return MylittlefishConnectivityQuestion_4Platform.instance.onConnectivityChanged;
  }
}