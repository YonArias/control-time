import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_control_app/domain/entities/task.dart';
import 'package:time_control_app/domain/entities/user.dart';
import 'package:time_control_app/domain/repository/task_repository.dart';

class GetTasksUseCase {
  final TaskRepository taskRepository;

  GetTasksUseCase({required this.taskRepository});

  Stream<List<Task>> getTasks() {
    return taskRepository.getTasks();
  }
}

class GetTaskUseCase {
  final TaskRepository taskRepository;

  GetTaskUseCase({required this.taskRepository});

  Future<Task> getTask(String idTask) {
    return taskRepository.getTask(idTask);
  }
}

class AddTaskUseCase {
  final TaskRepository taskRepository;

  AddTaskUseCase({required this.taskRepository});

  Future<void> addTask(Task task) async {
    await taskRepository.addTask(task);
  }
}

class DeleteTaskUseCase {
  final TaskRepository taskRepository;

  DeleteTaskUseCase({required this.taskRepository});

  Future<void> deleteDelay(String idTask) async {
    await taskRepository.deleteTask(idTask);
  }
}

// TODO: TASK DONE
class GetTaskDoneUseCase {
  final TaskRepository taskRepository;

  GetTaskDoneUseCase({required this.taskRepository});

  Stream<List<TaskDone>> getTasksDone(DateTime? time) {
    return taskRepository.getTasksDone(time);
  }
}

class GetTaskDoneUserUseCase {
  final TaskRepository taskRepository;

  GetTaskDoneUserUseCase({required this.taskRepository});

  Stream<List<TaskDone>> getTaskDoneUser(User? user) {
    return taskRepository.getTasksDoneUser(user);
  }
}

class AddTaskDoneUseCase {
  final TaskRepository taskRepository;

  AddTaskDoneUseCase({required this.taskRepository});

  Future<String> addTaskDone(TaskDone taskDone) async {
    return taskRepository.addTaskDone(taskDone);
  }
}

class UpdateTaskDoneUseCase {
  final TaskRepository taskRepository;

  UpdateTaskDoneUseCase({required this.taskRepository});

  Future<void> updateTaskDone(String idTaskDone, Timestamp endTime) async {
    return taskRepository.updateTaskDone(idTaskDone, endTime);
  }
}