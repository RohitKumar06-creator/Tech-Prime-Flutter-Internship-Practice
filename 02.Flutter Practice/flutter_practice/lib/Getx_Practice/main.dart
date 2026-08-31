import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounterController extends GetxController {
  var counter = 0.obs;

  void increment() {
    counter++;
  }
}

class CounterScreen extends StatelessWidget {
  CounterScreen({super.key});

  final CounterController controller = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GetX Counter")),

      body: Center(
        child: Obx(
          () => Text(
            "${controller.counter}",
            style: const TextStyle(fontSize: 40),
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
