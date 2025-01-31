import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mylittlefish_connectivity_question_4/mylittlefish_connectivity_question_4_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelMylittlefishConnectivityQuestion_4 platform = MethodChannelMylittlefishConnectivityQuestion_4();
  const MethodChannel channel = MethodChannel('mylittlefish_connectivity_question_4');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
