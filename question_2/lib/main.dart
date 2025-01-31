import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'state/actions/counter_action.dart';
import 'state/app_state.dart';
import 'state/reducers/counter_reducer.dart';

void main() {
  final store = Store<AppState>(
    counterReducer,
    initialState: AppState.initial(),
  );

  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Flutter Redux Counter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Redux Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StoreConnector<AppState, int>(
              converter: (store) => store.state.count,
              builder: (context, count) {
                return Text(
                  '$count',
                  style: const TextStyle(fontSize: 48),
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    StoreProvider.of<AppState>(context)
                        .dispatch(CounterAction.decrement);
                  },
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: () {
                    StoreProvider.of<AppState>(context)
                        .dispatch(CounterAction.increment);
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}