import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(home: UserScreen()));
}

class UserController extends GetxController {
  var username = "Ali".obs;

  void changeUsername() {
    username.value = "Ahmed";
  }
}

class UserScreen extends StatelessWidget {
  UserScreen({super.key});

  final UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Username")),

      body: Center(
        child: Obx(() {
          return Text(
            controller.username.value,
            style: const TextStyle(fontSize: 30),
          );
        }),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: controller.changeUsername,
        child: const Icon(Icons.edit),
      ),
    );
  }
}
