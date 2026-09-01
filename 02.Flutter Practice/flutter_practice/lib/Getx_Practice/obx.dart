import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(home: CounterScreen()));
}

class CounterController extends GetxController {
  var counter = 0.obs;

  void increase() {
    counter++;
  }
}

class CounterScreen extends StatelessWidget {
  CounterScreen({super.key});

  final CounterController controller = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reactive Counter")),

      body: Center(
        child: Obx(() {
          return Text(
            "${controller.counter}",
            style: const TextStyle(fontSize: 50),
          );
        }),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: controller.increase,
        child: const Icon(Icons.add),
      ),
    );
  }
}
