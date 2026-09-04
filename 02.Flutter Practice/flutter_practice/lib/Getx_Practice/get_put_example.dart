import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(home: HomePage()));
}

// Service / Dependency
class UserService {
  String getUserName() {
    return "Rohit";
  }
}

// Controller
class UserController extends GetxController {
  final UserService userService = Get.find<UserService>();

  String getName() {
    return userService.getUserName();
  }
}

// Home Page
class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Dependency Injection
  final UserService userService = Get.put(UserService());

  // Controller Injection
  final UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Get.put Example")),
      body: Center(
        child: Text(controller.getName(), style: const TextStyle(fontSize: 30)),
      ),
    );
  }
}
