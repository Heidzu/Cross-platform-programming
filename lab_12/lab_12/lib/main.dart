import 'package:flutter/material.dart';
import 'database_manager.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const TaskScreen(),
    );
  }
}

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TextEditingController _taskController = TextEditingController();
  final GlobalKey<FormState> _taskFormKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> _taskList = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final tasks = await DatabaseManager.instance.fetchTasks();
    setState(() {
      _taskList = tasks;
    });
  }

  Future<void> _addTask() async {
    if (_taskFormKey.currentState!.validate()) {
      await DatabaseManager.instance.insertTask(_taskController.text);
      _taskController.clear();
      _loadTasks();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Task Manager'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            Form(
              key: _taskFormKey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _taskController,
                      decoration: const InputDecoration(
                        labelText: 'Enter task',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Task description is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 5),
                  ElevatedButton(
                    onPressed: _addTask,
                    child: const Text('Add'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 20,
              thickness: 0.5,
              indent: 0,
              endIndent: 0,
              color: Colors.grey,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _taskList.length,
                itemBuilder: (context, index) {
                  final task = _taskList[index];
                  return Card(
                    child: ListTile(
                      title: Text(task['taskDescription']),
                      subtitle: Text(
                        DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.parse(task['dateCreated'])),
                      ),
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
