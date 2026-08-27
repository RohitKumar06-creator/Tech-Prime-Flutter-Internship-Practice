import 'package:flutter/material.dart';

class ToggleStateWidget extends StatefulWidget {
  const ToggleStateWidget({super.key});

  @override
  State<ToggleStateWidget> createState() => _ToggleStateWidgetState();
}

class _ToggleStateWidgetState extends State<ToggleStateWidget> {
  bool _isSwitchedOn = false;

  void _toggleSwitch(bool value) {
    setState(() {
      _isSwitchedOn = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isSwitchedOn ? Colors.yellow[100] : Colors.grey[200],
      appBar: AppBar(title: const Text('Toggle State')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isSwitchedOn ? Icons.lightbulb : Icons.lightbulb_outline,
              size: 100,
              color: _isSwitchedOn ? Colors.orange : Colors.grey,
            ),
            const SizedBox(height: 20),
            Switch(value: _isSwitchedOn, onChanged: _toggleSwitch),
            Text(_isSwitchedOn ? 'Light is ON' : 'Light is OFF'),
          ],
        ),
      ),
    );
  }
}
