import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mylittlefish_connectivity_question_4_platform_interface.dart';


class MethodChannelMylittlefishConnectivityQuestion_4 extends MylittlefishConnectivityQuestion_4Platform {
  @visibleForTesting
  final methodChannel = const MethodChannel('mylittlefish_connectivity_question_4');

  @visibleForTesting
  final eventChannel = const EventChannel('mylittlefish_connectivity_question_4/connectivity_status');

  Stream<bool>? _onConnectivityChanged;

  // This is fine in the platform interface, but we must implement it here
  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool> hasConnectivity() async {
    try {
      final result = await methodChannel.invokeMethod<bool>('hasConnectivity');
      return result ?? false;
    } catch (e) {
      print('Error checking connectivity: $e');
      return false;
    }
  }

  @override
  Stream<bool> get onConnectivityChanged {
    _onConnectivityChanged ??= eventChannel.receiveBroadcastStream().map((dynamic event) {
      try {
        return event as bool;
      } catch (e) {
        print('Error in connectivity stream: $e');
        return false;
      }
    });
    return _onConnectivityChanged!;
  }
}

