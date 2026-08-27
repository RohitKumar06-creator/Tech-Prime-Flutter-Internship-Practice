import 'package:flutter/material.dart';

class CounterLifecycleWidget extends StatefulWidget {
  const CounterLifecycleWidget({super.key});

  @override
  State<CounterLifecycleWidget> createState() => _CounterLifecycleWidgetState();
}

class _CounterLifecycleWidgetState extends State<CounterLifecycleWidget> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    // Called once when the widget is inserted into the tree
    debugPrint('Counter Widget Initialized');
  }

  @override
  void dispose() {
    // Called when the widget is permanently removed from the tree
    debugPrint('Counter Widget Disposed');
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      // setState triggers a rebuild of the widget with the new value
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lifecycle & Counter')),
      body: Center(
        child: Text('Count: $_counter', style: const TextStyle(fontSize: 32)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}
