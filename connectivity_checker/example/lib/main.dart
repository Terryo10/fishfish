import 'package:flutter/material.dart';
import 'package:connectivity_checker/connectivity_checker.dart';
import 'dart:async';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ConnectivityChecker _connectivityChecker = ConnectivityChecker();
  final _connectivityController = StreamController<bool>.broadcast();

  @override
  void initState() {
    super.initState();
    _checkInitialConnectivity();
    
    // Listen to connectivity changes from the checker
    _connectivityChecker.onConnectivityChanged.listen((isConnected) {
      _connectivityController.add(isConnected);
    });
  }

  Future<void> _checkInitialConnectivity() async {
    final isConnected = await _connectivityChecker.checkConnectivity();
    _connectivityController.add(isConnected);
    print('Initial Connectivity: $isConnected');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Connectivity Checker')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<bool>(
                stream: _connectivityController.stream,
                builder: (context, snapshot) {
                  print("StreamBuilder snapshot: ${snapshot.connectionState}, data: ${snapshot.data}");
                  final isConnected = snapshot.data ?? false;
                  return Text(
                    'Connected: $isConnected',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isConnected ? Colors.green : Colors.red,
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final isConnected = await _connectivityChecker.checkConnectivity();
                  _connectivityController.add(isConnected); // Add the new value to the stream
                  print('Is Connected: $isConnected');
                },
                child: const Text('Check Connectivity'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _connectivityChecker.dispose();
    _connectivityController.close();
    super.dispose();
  }
}