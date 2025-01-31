import 'package:flutter_test/flutter_test.dart';
import 'package:mylittlefish_connectivity_question_4/mylittlefish_connectivity_question_4.dart';
import 'package:mylittlefish_connectivity_question_4/mylittlefish_connectivity_question_4_platform_interface.dart';
import 'package:mylittlefish_connectivity_question_4/mylittlefish_connectivity_question_4_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMylittlefishConnectivityQuestion_4Platform
    with MockPlatformInterfaceMixin
    implements MylittlefishConnectivityQuestion_4Platform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MylittlefishConnectivityQuestion_4Platform initialPlatform = MylittlefishConnectivityQuestion_4Platform.instance;

  test('$MethodChannelMylittlefishConnectivityQuestion_4 is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMylittlefishConnectivityQuestion_4>());
  });

  test('getPlatformVersion', () async {
    MylittlefishConnectivityQuestion_4 mylittlefishConnectivityQuestion_4Plugin = MylittlefishConnectivityQuestion_4();
    MockMylittlefishConnectivityQuestion_4Platform fakePlatform = MockMylittlefishConnectivityQuestion_4Platform();
    MylittlefishConnectivityQuestion_4Platform.instance = fakePlatform;

    expect(await mylittlefishConnectivityQuestion_4Plugin.getPlatformVersion(), '42');
  });
}
