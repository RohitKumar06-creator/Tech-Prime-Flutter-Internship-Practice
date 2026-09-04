import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  // Dependency Injection
  Get.put(ApiService());

  runApp(GetMaterialApp(home: const HomePage()));
}

// Service
class ApiService {
  String getData() {
    return "Data received from API";
  }
}

// Controller
class HomeController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();

  String getData() {
    return apiService.getData();
  }
}

// UI
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(title: const Text("Dependency Injection")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.snackbar("API Response", controller.getData());
          },
          child: const Text("Get Data"),
        ),
      ),
    );
  }
}
