import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

// Controller
class CounterController extends GetxController {
  int count = 0;

  void increment() {
    count++;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put creates the controller immediately
    Get.put(CounterController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.find retrieves the injected controller
    final CounterController controller = Get.find<CounterController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dependency Injection'),
      ),
      body: Center(
        child: Obx(
          () => Text(
            'Count: ${controller.count}',
            style: const TextStyle(fontSize: 30),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}