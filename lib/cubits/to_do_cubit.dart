import 'package:bloc_demo/model/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class ToDoCubit extends Cubit<List<Task>> {
  ToDoCubit() : super([]);

  final String id = Uuid().v4();
  void addTask(String text) {
    if (text.isNotEmpty) {
      final newTask = Task(
        id: Uuid().v4(),
        text: text,
      );
      emit([...state, newTask]);
    }
  }

  void toggleTaskCompletion(String id) {
    final updatedTask = state.map(
      (task) {
        if (task.id == id) {
          return Task(
              id: task.id, text: task.text, isCompleted: !task.isCompleted);
        }
        return task;
      },
    ).toList();
    emit(updatedTask);
  }

  void deleteTask(String id) {
    final updatedTask = state.toList();
    updatedTask.removeWhere((task) => task.id == id);
    emit(updatedTask);
  }
}
