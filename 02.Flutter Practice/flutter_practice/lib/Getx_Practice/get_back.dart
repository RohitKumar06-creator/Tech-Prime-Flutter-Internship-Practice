import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(home: const HomePage()));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.to(() => const SecondPage());
          },
          child: const Text("Open Second Page"),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Second Page")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Go Back"),
        ),
      ),
    );
  }
}
