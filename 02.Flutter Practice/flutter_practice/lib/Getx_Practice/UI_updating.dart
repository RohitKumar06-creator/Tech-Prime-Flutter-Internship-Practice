import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      home: HomePage(),
    ),
  );
}

// Controller
class CounterController extends GetxController {
  var count = 0.obs;

  void increment() {
    count++;
  }
}

// UI
class HomePage extends StatelessWidget {
  HomePage({super.key});

  final CounterController controller = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reactive UI"),
      ),

      body: Center(
        child: Obx(
          () => Text(
            "Count: ${controller.count}",
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