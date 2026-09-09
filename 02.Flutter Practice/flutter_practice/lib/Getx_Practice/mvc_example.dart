import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

// ====================
// MODEL
// ====================

class CounterModel {
  int count = 0;
}

// ====================
// CONTROLLER
// ====================

class CounterController extends GetxController {
  CounterModel model = CounterModel();

  void increment() {
    model.count++;
    update();
  }

  void decrement() {
    model.count--;
    update();
  }
}

// ====================
// VIEW
// ====================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MVC Example')),

      body: Center(
        child: GetBuilder<CounterController>(
          builder: (controller) {
            return Text(
              'Count: ${controller.model.count}',
              style: const TextStyle(fontSize: 30),
            );
          },
        ),
      ),

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Get.find<CounterController>().decrement();
            },
            child: const Icon(Icons.remove),
          ),

          const SizedBox(width: 10),

          FloatingActionButton(
            onPressed: () {
              Get.find<CounterController>().increment();
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

// ====================
// APP
// ====================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CounterController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
