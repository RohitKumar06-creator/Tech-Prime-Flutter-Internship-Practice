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
// VIEWMODEL
// ====================

class CounterViewModel extends GetxController {
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
      appBar: AppBar(title: const Text('MVVM Example')),

      body: Center(
        child: GetBuilder<CounterViewModel>(
          builder: (viewModel) {
            return Text(
              'Count: ${viewModel.model.count}',
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
              Get.find<CounterViewModel>().decrement();
            },
            child: const Icon(Icons.remove),
          ),

          const SizedBox(width: 10),

          FloatingActionButton(
            onPressed: () {
              Get.find<CounterViewModel>().increment();
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
    Get.put(CounterViewModel());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
