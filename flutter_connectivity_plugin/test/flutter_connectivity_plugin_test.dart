import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_connectivity_plugin/flutter_connectivity_plugin.dart';
import 'package:flutter_connectivity_plugin/flutter_connectivity_plugin_platform_interface.dart';
import 'package:flutter_connectivity_plugin/flutter_connectivity_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterConnectivityPluginPlatform
    with MockPlatformInterfaceMixin
    implements FlutterConnectivityPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterConnectivityPluginPlatform initialPlatform = FlutterConnectivityPluginPlatform.instance;

  test('$MethodChannelFlutterConnectivityPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterConnectivityPlugin>());
  });

  test('getPlatformVersion', () async {
    FlutterConnectivityPlugin flutterConnectivityPlugin = FlutterConnectivityPlugin();
    MockFlutterConnectivityPluginPlatform fakePlatform = MockFlutterConnectivityPluginPlatform();
    FlutterConnectivityPluginPlatform.instance = fakePlatform;

    expect(await flutterConnectivityPlugin.getPlatformVersion(), '42');
  });
}
