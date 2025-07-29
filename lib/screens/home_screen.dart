import 'package:flutter/material.dart';
import '../models/todo_model.dart';
import 'signup_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ToDo> todos = [];
  TextEditingController taskController = TextEditingController();

  void addTask(String taskTitle) {
    if (taskTitle.isNotEmpty) {
      setState(() {
        todos.add(ToDo(id: DateTime.now().toString(), title: taskTitle));
        taskController.clear();
      });
    }
  }

  void toggleDone(String id) {
    setState(() {
      var task = todos.firstWhere((todo) => todo.id == id);
      task.isDone = !task.isDone;
    });
  }

  void deleteTask(String id) {
    setState(() {
      todos.removeWhere((todo) => todo.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do App'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => SignupScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: taskController,
              decoration: InputDecoration(
                hintText: 'Enter task',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => addTask(taskController.text),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return ListTile(
                    leading: Checkbox(
                      value: todo.isDone,
                      onChanged: (_) => toggleDone(todo.id),
                    ),
                    title: Text(
                      todo.title,
                      style: TextStyle(
                        decoration:
                            todo.isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => deleteTask(todo.id),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
