import 'package:flutter/material.dart';
import 'package:connectivity_checker/connectivity_checker.dart';

void main() {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the plugin
  final connectivityChecker = ConnectivityChecker();

  runApp(MyApp(connectivityChecker: connectivityChecker));
}

class MyApp extends StatefulWidget {
  final ConnectivityChecker connectivityChecker;

  const MyApp({super.key, required this.connectivityChecker});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Connectivity Checker')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<bool>(
                stream: widget.connectivityChecker.onConnectivityChanged,
                builder: (context, snapshot) {
                  final isConnected = snapshot.data ?? false;
                  print('StreamBuilder rebuilt with connectivity: $isConnected'); // Debug print
                  return Text('Connected: $isConnected');
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  final isConnected = await widget.connectivityChecker.checkConnectivity();
                  print('Is Connected: $isConnected');
                  setState(() {
                    
                  });
                },
                child: Text('Check Connectivity'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}