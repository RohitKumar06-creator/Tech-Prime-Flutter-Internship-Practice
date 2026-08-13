import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LayoutPractice(),
    ),
  );
}

class LayoutPractice extends StatelessWidget {
  const LayoutPractice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layout Practice'),
        centerTitle: true,
      ),

      body: Container(
        // ALIGNMENT
        alignment: Alignment.center,

        // PADDING
        padding: const EdgeInsets.all(20),

        child: Container(
          // MARGIN
          margin: const EdgeInsets.all(20),

          padding: const EdgeInsets.all(20),

          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(15),
          ),

          child: const Text(
            'Hello Flutter!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}