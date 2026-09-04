import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(home: HomePage()));
}

// Service
class UserService {
  UserService() {
    print("UserService Created");
  }

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

  @override
  Widget build(BuildContext context) {
    // Lazy Dependency Injection
    Get.lazyPut<UserService>(() => UserService());

    Get.lazyPut<UserController>(() => UserController());

    return Scaffold(
      appBar: AppBar(title: const Text("Get.lazyPut Example")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final controller = Get.find<UserController>();

            Get.snackbar("User", controller.getName());
          },
          child: const Text("Get User"),
        ),
      ),
    );
  }
}
