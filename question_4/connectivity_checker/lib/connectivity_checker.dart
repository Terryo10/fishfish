import 'dart:async';
import 'package:flutter/services.dart';

class ConnectivityChecker {
  final MethodChannel _channel;

  // Stream to notify connectivity changes
  final StreamController<bool> _connectivityStreamController =
      StreamController<bool>.broadcast();
  Stream<bool> get onConnectivityChanged =>
      _connectivityStreamController.stream;

  ConnectivityChecker({BinaryMessenger? binaryMessenger})
      : _channel = MethodChannel(
          'connectivity_checker',
          const StandardMethodCodec(),
          binaryMessenger,
        ) {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  // Handle incoming method calls
  Future<void> _handleMethodCall(MethodCall call) async {
    if (call.method == 'connectivityChanged') {
      print("Received connectivityChanged: ${call.arguments}");

      final bool? isConnected = call.arguments as bool?;
      if (isConnected != null) {
        _connectivityStreamController.add(isConnected);
      } else {
        print("Warning: Received null connectivity status");
      }
    } else {
      print("Unhandled method: ${call.method}");
    }
  }

  // Check current connectivity status
  Future<bool> checkConnectivity() async {
    try {
      final bool isConnected =
          await _channel.invokeMethod<bool>('checkConnectivity') ?? false;
      print("checkConnectivity result: $isConnected");
      return isConnected;
    } catch (e) {
      print("Error checking connectivity: $e");
      return false; // Assume no connection in case of error
    }
  }

  // Dispose function to close the StreamController
  void dispose() {
    _connectivityStreamController.close();
  }
}
