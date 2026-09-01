import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(home: CounterScreen()));
}

class CounterController extends GetxController {
  int counter = 0;

  void increase() {
    counter++;

    update();
  }
}

class CounterScreen extends StatelessWidget {
  CounterScreen({super.key});

  final CounterController controller = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GetBuilder")),

      body: Center(
        child: GetBuilder<CounterController>(
          builder: (controller) {
            return Text(
              "${controller.counter}",
              style: const TextStyle(fontSize: 50),
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: controller.increase,
        child: const Icon(Icons.add),
      ),
    );
  }
}
