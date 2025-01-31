// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:web/web.dart' as web;

import 'mylittlefish_connectivity_question_4_platform_interface.dart';

/// A web implementation of the MylittlefishConnectivityQuestion_4Platform of the MylittlefishConnectivityQuestion_4 plugin.
class MylittlefishConnectivityQuestion_4Web extends MylittlefishConnectivityQuestion_4Platform {
  /// Constructs a MylittlefishConnectivityQuestion_4Web
  MylittlefishConnectivityQuestion_4Web();

  static void registerWith(Registrar registrar) {
    MylittlefishConnectivityQuestion_4Platform.instance = MylittlefishConnectivityQuestion_4Web();
  }

  /// Returns a [String] containing the version of the platform.
  @override
  Future<String?> getPlatformVersion() async {
    final version = web.window.navigator.userAgent;
    return version;
  }
}
