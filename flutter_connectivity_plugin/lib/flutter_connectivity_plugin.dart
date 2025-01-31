
import 'flutter_connectivity_plugin_platform_interface.dart';

class FlutterConnectivityPlugin {
  Future<String?> getPlatformVersion() {
    return FlutterConnectivityPluginPlatform.instance.getPlatformVersion();
  }
}
