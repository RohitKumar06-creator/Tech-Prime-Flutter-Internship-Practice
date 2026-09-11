import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

// ============================================================
// MODEL
// ============================================================

class Task {
  String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});
}

// ============================================================
// GETX SERVICE
// ============================================================

class AppService extends GetxService {
  String appName = 'My Task Manager';

  void logout() {
    Get.snackbar(
      'Logout',
      'You have been logged out',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

// ============================================================
// CONTROLLER
// ============================================================

class TaskController extends GetxController {
  // Reactive variable
  var tasks = <Task>[].obs;

  // Normal variable for GetBuilder
  int totalDeleted = 0;

  // ----------------------------------------------------------
  // ADD TASK
  // ----------------------------------------------------------

  void addTask(String title) {
    if (title.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a task',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    tasks.add(Task(title: title.trim()));

    Get.back();

    Get.snackbar(
      'Success',
      'Task added successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // ----------------------------------------------------------
  // TOGGLE TASK
  // ----------------------------------------------------------

  void toggleTask(int index) {
    tasks[index].isCompleted = !tasks[index].isCompleted;

    // Because tasks is an RxList, refresh the UI
    tasks.refresh();
  }

  // ----------------------------------------------------------
  // DELETE TASK
  // ----------------------------------------------------------

  void deleteTask(int index) {
    tasks.removeAt(index);

    totalDeleted++;

    // GetBuilder needs update()
    update();
  }

  // ----------------------------------------------------------
  // CLEAR ALL TASKS
  // ----------------------------------------------------------

  void clearTasks() {
    tasks.clear();

    Get.snackbar(
      'Cleared',
      'All tasks have been removed',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

// ============================================================
// BINDING
// ============================================================

class TaskBinding extends Bindings {
  @override
  void dependencies() {
    // Service
    Get.put(AppService());

    // Controller is created only when first requested
    Get.lazyPut<TaskController>(() => TaskController());
  }
}

// ============================================================
// APP
// ============================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'GetX Task Manager',

      // Binding
      initialBinding: TaskBinding(),

      // Named routes
      initialRoute: '/',

      getPages: [
        GetPage(name: '/', page: () => const HomePage()),

        GetPage(name: '/about', page: () => const AboutPage()),
      ],
    );
  }
}

// ============================================================
// HOME PAGE
// ============================================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.find() retrieves the controller
    final TaskController controller = Get.find<TaskController>();

    // Get.find() retrieves the service
    final AppService service = Get.find<AppService>();

    return Scaffold(
      // --------------------------------------------------------
      // APP BAR
      // --------------------------------------------------------

      appBar: AppBar(
        title: Text(service.appName),

        actions: [
          // Navigate using named route
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              Get.toNamed('/about');
            },
          ),

          // Bottom sheet
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              showOptions();
            },
          ),
        ],
      ),

      // --------------------------------------------------------
      // BODY
      // --------------------------------------------------------
      body: Obx(() {
        // If there are no tasks
        if (controller.tasks.isEmpty) {
          return const Center(
            child: Text(
              'No tasks yet.\nAdd your first task!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          );
        }

        // List of tasks
        return ListView.builder(
          itemCount: controller.tasks.length,

          itemBuilder: (context, index) {
            final task = controller.tasks[index];

            return ListTile(
              // Checkbox
              leading: Checkbox(
                value: task.isCompleted,

                onChanged: (_) {
                  controller.toggleTask(index);
                },
              ),

              // Task title
              title: Text(
                task.title,

                style: TextStyle(
                  decoration: task.isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),

              // Delete
              trailing: IconButton(
                icon: const Icon(Icons.delete),

                onPressed: () {
                  // Dialog
                  showDeleteDialog(controller, index);
                },
              ),
            );
          },
        );
      }),

      // --------------------------------------------------------
      // FLOATING BUTTON
      // --------------------------------------------------------
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Get.to() navigation
          Get.to(() => const AddTaskPage());
        },

        child: const Icon(Icons.add),
      ),

      // --------------------------------------------------------
      // GETBUILDER
      // --------------------------------------------------------
      bottomNavigationBar: GetBuilder<TaskController>(
        builder: (controller) {
          return Container(
            padding: const EdgeInsets.all(15),

            child: Text(
              'Tasks: ${controller.tasks.length} | '
              'Deleted: ${controller.totalDeleted}',

              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }

  // ==========================================================
  // BOTTOM SHEET
  // ==========================================================

  void showOptions() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),

        decoration: const BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),

        child: Wrap(
          children: [
            const Center(
              child: Text(
                'Options',

                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 20),

            // Clear tasks
            ListTile(
              leading: const Icon(Icons.delete_sweep),

              title: const Text('Clear All Tasks'),

              onTap: () {
                Get.back();

                Get.find<TaskController>().clearTasks();
              },
            ),

            // About
            ListTile(
              leading: const Icon(Icons.info),

              title: const Text('About'),

              onTap: () {
                Get.back();

                Get.toNamed('/about');
              },
            ),

            // Logout
            ListTile(
              leading: const Icon(Icons.logout),

              title: const Text('Logout'),

              onTap: () {
                Get.back();

                Get.find<AppService>().logout();
              },
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // DELETE DIALOG
  // ==========================================================

  void showDeleteDialog(TaskController controller, int index) {
    Get.defaultDialog(
      title: 'Delete Task',

      middleText: 'Are you sure you want to delete this task?',

      textCancel: 'Cancel',

      textConfirm: 'Delete',

      onConfirm: () {
        controller.deleteTask(index);

        Get.back();

        Get.snackbar(
          'Deleted',
          'Task has been deleted',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }
}

// ============================================================
// ADD TASK PAGE
// ============================================================

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();

    final TaskController controller = Get.find<TaskController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: textController,

              decoration: const InputDecoration(
                labelText: 'Task name',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: () {
                  controller.addTask(textController.text);
                },

                child: const Text('Add Task'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// ABOUT PAGE
// ============================================================

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppService service = Get.find<AppService>();

    return Scaffold(
      appBar: AppBar(title: const Text('About')),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            const Icon(Icons.task_alt, size: 80),

            const SizedBox(height: 20),

            Text(
              service.appName,

              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text('A simple Flutter + GetX project'),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Get.back();
              },

              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
