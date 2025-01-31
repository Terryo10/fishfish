
import 'package:flutter/material.dart';
import 'package:mylittlefish_connectivity_question_4/mylittlefish_connectivity_question_4.dart';

class ConnectivityPage extends StatefulWidget {
  const ConnectivityPage({super.key});

  @override
  State<ConnectivityPage> createState() => _ConnectivityPageState();
}

class _ConnectivityPageState extends State<ConnectivityPage> {
  final _connectivityPlugin = MylittlefishConnectivityQuestion_4();
  bool _isConnected = false;
  String _platformVersion = 'Unknown';
  late Stream<bool> _connectivityStream;

  @override
  void initState() {
    super.initState();
    _initPlatformState();
    _checkConnectivity();
    _connectivityStream = _connectivityPlugin.onConnectivityChanged;
    _connectivityStream.listen((isConnected) {
      setState(() {
        _isConnected = isConnected;
      });
    });
  }

  Future<void> _initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await _connectivityPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } catch (e) {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> _checkConnectivity() async {
    final isConnected = await _connectivityPlugin.hasConnectivity();
    if (!mounted) return;
    setState(() {
      _isConnected = isConnected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Connectivity Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Platform: $_platformVersion',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Text(
              'Connection Status: ${_isConnected ? "Connected" : "Disconnected"}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkConnectivity,
              child: const Text('Check Connection'),
            ),
          ],
        ),
      ),
    );
  }
}