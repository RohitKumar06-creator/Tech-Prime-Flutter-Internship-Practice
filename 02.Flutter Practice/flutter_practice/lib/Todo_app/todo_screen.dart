import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// 1. Task Model
class Task {
  String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  // 2. Controller & Task State List
  final TextEditingController _taskController = TextEditingController();

  final List<Task> _tasks = [
    Task(title: 'Set up project environment', isCompleted: true),
    Task(title: 'Design initial wireframe', isCompleted: false),
    Task(title: 'Implement Flutter UI screens', isCompleted: false),
  ];

  // Add Task
  void _addTask() {
    final text = _taskController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _tasks.add(Task(title: text));
      _taskController.clear();
    });
    FocusScope.of(context).unfocus();
  }

  // Toggle Completion
  void _toggleTask(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    });
  }

  // Delete Task
  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pendingCount = _tasks.where((t) => !t.isCompleted).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'My Tasks',
          style: GoogleFonts.montserrat(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF202020),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pending Tasks Counter
              Text(
                '$pendingCount pending ${pendingCount == 1 ? 'task' : 'tasks'}',
                style: GoogleFonts.montserrat(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF888888),
                ),
              ),
              SizedBox(height: 14.h),

              // Input Field & Add Button
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _taskController,
                      style: GoogleFonts.montserrat(
                        fontSize: 14.sp,
                        color: const Color(0xFF202020),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Add a new task...',
                        hintStyle: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          color: const Color(0xFFB0B0B0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 14.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSubmitted: (_) => _addTask(),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  SizedBox(
                    height: 48.h,
                    width: 48.w,
                    child: ElevatedButton(
                      onPressed: _addTask,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF5A5F),
                        padding: EdgeInsets.zero,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 24.sp),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              // Task List View
              Expanded(
                child: _tasks.isEmpty
                    ? Center(
                        child: Text(
                          'No tasks yet. Create one above!',
                          style: GoogleFonts.montserrat(
                            fontSize: 14.sp,
                            color: const Color(0xFF888888),
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _tasks.length,
                        itemBuilder: (context, index) {
                          final task = _tasks[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: 10.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 2.h,
                              ),
                              leading: Checkbox(
                                value: task.isCompleted,
                                onChanged: (_) => _toggleTask(index),
                                activeColor: const Color(0xFFFF5A5F),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                              ),
                              title: Text(
                                task.title,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: task.isCompleted
                                      ? const Color(0xFFB0B0B0)
                                      : const Color(0xFF202020),
                                  decoration: task.isCompleted
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: const Color(0xFF888888),
                                  size: 20.sp,
                                ),
                                onPressed: () => _deleteTask(index),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
