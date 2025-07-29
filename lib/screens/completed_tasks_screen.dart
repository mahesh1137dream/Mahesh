import 'package:api_course/models/todo_model.dart';
import 'package:flutter/material.dart';
import '../todo_model.dart'; 

class CompletedTasksScreen extends StatelessWidget {
  final List<ToDo> completedTasks;

  const CompletedTasksScreen({super.key, required this.completedTasks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Completed Tasks")),
      body: completedTasks.isEmpty
          ? Center(child: Text("No completed tasks yet."))
          : ListView.builder(
              itemCount: completedTasks.length,
              itemBuilder: (context, index) {
                final task = completedTasks[index];
                return ListTile(
                  title: Text(task.title),
                  trailing: Icon(Icons.check_circle, color: Colors.green),
                );
              },
            ),
    );
  }
}
