import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  // Start the service
  Get.put(UserService());

  runApp(const MyApp());
}

// ========================
// GETX SERVICE
// ========================

class UserService extends GetxService {
  String username = 'Rohit';

  void changeUsername(String name) {
    username = name;
  }
}

// ========================
// APP
// ========================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

// ========================
// VIEW
// ========================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserService service = Get.find<UserService>();

    return Scaffold(
      appBar: AppBar(title: const Text('GetX Service')),

      body: Center(
        child: Text(
          'Welcome ${service.username}',
          style: const TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
