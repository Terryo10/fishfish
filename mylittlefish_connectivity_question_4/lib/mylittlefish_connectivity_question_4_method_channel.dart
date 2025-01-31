import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mylittlefish_connectivity_question_4_platform_interface.dart';

/// An implementation of [MylittlefishConnectivityQuestion_4Platform] that uses method channels.
class MethodChannelMylittlefishConnectivityQuestion_4 extends MylittlefishConnectivityQuestion_4Platform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('mylittlefish_connectivity_question_4');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
