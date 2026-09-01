import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(home: HomeScreen()));
}

// Controller
class UserController extends GetxController {
  String name = "Ali";

  void changeName() {
    name = "Ahmed";
  }
}

// UI
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GetX Controller")),

      body: Center(
        child: Text(controller.name, style: const TextStyle(fontSize: 30)),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.changeName();
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
