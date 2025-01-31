
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mylittlefish_connectivity_question_4/mylittlefish_connectivity_question_4.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  // final _connectivity = MylittlefishConnectivityQuestion_4();
  String _platformVersion = 'Unknown';
  bool _hasConnectivity = false;
  late StreamSubscription<bool> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    // _initPlatformState();
    // _checkConnectivity();
    // _connectivitySubscription = _connectivity.onConnectivityChanged.listen((hasConnectivity) {
    //   setState(() {
    //     _hasConnectivity = hasConnectivity;
    //   });
    // });
  }

  Future<void> _initPlatformState() async {
    String platformVersion;
    try {
      // platformVersion = await _connectivity.getPlatformVersion() ?? 'Unknown platform version';
    } catch (e) {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      // _platformVersion = platformVersion;
    });
  }

  Future<void> _checkConnectivity() async {
    // final hasConnectivity = await _connectivity.hasConnectivity();
    setState(() {
      // _hasConnectivity = hasConnectivity;
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Plugin example app')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Running on: $_platformVersion'),
              Text('Has Connectivity: $_hasConnectivity'),
              ElevatedButton(
                onPressed: _checkConnectivity,
                child: Text('Check Connectivity'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}