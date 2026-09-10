import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void showDialogBox() {
    Get.defaultDialog(
      title: 'Delete Item',
      middleText: 'Are you sure you want to delete this item?',

      textCancel: 'Cancel',
      textConfirm: 'Delete',

      onCancel: () {
        Get.snackbar(
          'Cancelled',
          'Item was not deleted',
          snackPosition: SnackPosition.BOTTOM,
        );
      },

      onConfirm: () {
        Get.back();

        Get.snackbar(
          'Deleted',
          'Item has been deleted',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dialog Example')),

      body: Center(
        child: ElevatedButton(
          onPressed: showDialogBox,
          child: const Text('Delete Item'),
        ),
      ),
    );
  }
}
