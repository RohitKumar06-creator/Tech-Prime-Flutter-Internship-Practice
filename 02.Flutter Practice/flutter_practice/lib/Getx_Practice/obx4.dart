import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(home: TodoScreen()));
}

class TodoController extends GetxController {
  var tasks = <String>["Learn Dart", "Learn Flutter"].obs;

  void addTask() {
    tasks.add("Learn GetX");
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
  }
}

class TodoScreen extends StatelessWidget {
  TodoScreen({super.key});

  final TodoController controller = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Tasks")),

      body: Obx(() {
        return ListView.builder(
          itemCount: controller.tasks.length,

          itemBuilder: (context, index) {
            return ListTile(
              title: Text(controller.tasks[index]),

              trailing: IconButton(
                icon: const Icon(Icons.delete),

                onPressed: () {
                  controller.deleteTask(index);
                },
              ),
            );
          },
        );
      }),

      floatingActionButton: FloatingActionButton(
        onPressed: controller.addTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
