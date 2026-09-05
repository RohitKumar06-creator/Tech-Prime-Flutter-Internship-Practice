import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

// Controller
class CounterController extends GetxController {
  RxInt count = 0.obs;

  void increment() {
    count++;
  }
}

// Binding
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CounterController());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      initialBinding: HomeBinding(),

      home: const HomePage(),
    );
  }
}

// Home Page
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieves the controller created by HomeBinding
    final CounterController controller = Get.find<CounterController>();

    return Scaffold(
      appBar: AppBar(title: const Text('GetX Bindings')),
      body: Center(
        child: Obx(
          () => Text(
            'Count: ${controller.count.value}',
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
