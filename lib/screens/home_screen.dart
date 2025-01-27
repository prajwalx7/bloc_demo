import 'package:bloc_demo/cubits/theme_cubit.dart';
import 'package:bloc_demo/cubits/to_do_cubit.dart';
import 'package:bloc_demo/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = BlocProvider.of<ThemeCubit>(context);
    final todoCubit = BlocProvider.of<ToDoCubit>(context);

    void showAddTaskDialog() {
      final TextEditingController taskController = TextEditingController();
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Add Task'),
              content: TextField(
                controller: taskController,
                decoration: InputDecoration(
                  labelText: 'Task',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (taskController.text.isNotEmpty) {
                      todoCubit.addTask(taskController.text);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
        centerTitle: true,
        actions: [
          BlocBuilder<ThemeCubit, bool>(
            builder: (context, isDarkMode) => IconButton(
              onPressed: () {
                themeCubit.toggleTheme();
              },
              icon: isDarkMode
                  ? Icon(Icons.wb_sunny_outlined)
                  : Icon(Icons.sunny),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: BlocBuilder<ToDoCubit, List<Task>>(
              builder: (context, tasks) {
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return ListTile(
                      title: Text(
                        tasks[index].text,
                        style: TextStyle(
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      leading: Checkbox(
                        value: task.isCompleted,
                        onChanged: (value) {
                          todoCubit.toggleTaskCompletion(task.id);
                        },
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          todoCubit.deleteTask(task.id);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddTaskDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
