import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GesturePractice(),
    ),
  );
}

class GesturePractice extends StatefulWidget {
  const GesturePractice({super.key});

  @override
  State<GesturePractice> createState() =>
      _GesturePracticeState();
}

class _GesturePracticeState
    extends State<GesturePractice> {

  String message = "Tap the card";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gesture Practice"),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            // GESTURE DETECTOR
            GestureDetector(
              onTap: () {
                setState(() {
                  message = "You tapped the card!";
                });
              },

              onDoubleTap: () {
                setState(() {
                  message = "Double tap detected!";
                });
              },

              onLongPress: () {
                setState(() {
                  message = "Long press detected!";
                });
              },

              child: Container(
                width: 250,
                height: 180,

                alignment: Alignment.center,

                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius:
                      BorderRadius.circular(20),
                ),

                child: const Icon(
                  Icons.touch_app,
                  color: Colors.white,
                  size: 70,
                ),
              ),
            ),

            const SizedBox(height: 30),

            Text(
              message,

              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "Tap • Double Tap • Long Press",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}