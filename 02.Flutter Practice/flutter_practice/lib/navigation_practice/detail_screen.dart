import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {

  final String title;
  final String description;

  const DetailScreen({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Details"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            const Icon(
              Icons.flutter_dash,
              size: 80,
              color: Colors.blue,
            ),

            const SizedBox(height: 20),

            Text(
              title,

              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              description,

              textAlign: TextAlign.center,

              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            // =================================================
            // POP
            // =================================================

            ElevatedButton(
              onPressed: () {

                Navigator.pop(context);
              },

              child: const Text(
                "Go Back",
              ),
            ),
          ],
        ),
      ),
    );
  }
}