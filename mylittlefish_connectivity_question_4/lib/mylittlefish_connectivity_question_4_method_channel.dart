import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mylittlefish_connectivity_question_4_platform_interface.dart';

class MethodChannelMylittlefishConnectivityQuestion_4 extends MylittlefishConnectivityQuestion_4Platform {
  @visibleForTesting
  final methodChannel = const MethodChannel('mylittlefish_connectivity_question_4');

  @visibleForTesting
  final eventChannel = const EventChannel('mylittlefish_connectivity_question_4/connectivity_status');

  Stream<bool>? _onConnectivityChanged;

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool> hasConnectivity() async {
    final bool hasConnectivity = await methodChannel.invokeMethod('hasConnectivity');
    return hasConnectivity;
  }

  @override
  Stream<bool> get onConnectivityChanged {
    _onConnectivityChanged ??= eventChannel.receiveBroadcastStream().map((dynamic event) => event as bool);
    return _onConnectivityChanged!;
  }
}

