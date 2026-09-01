import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(home: ToggleScreen()));
}

class ToggleController extends GetxController {
  var isOn = false.obs;

  void toggle() {
    isOn.value = !isOn.value;
  }
}

class ToggleScreen extends StatelessWidget {
  ToggleScreen({super.key});

  final ToggleController controller = Get.put(ToggleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Toggle Example")),

      body: Center(
        child: Obx(() {
          return Switch(
            value: controller.isOn.value,
            onChanged: (value) {
              controller.isOn.value = value;
            },
          );
        }),
      ),
    );
  }
}
