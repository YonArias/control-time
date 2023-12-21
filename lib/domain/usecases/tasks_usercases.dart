import 'package:time_control_app/domain/entities/task.dart';
import 'package:time_control_app/domain/repository/task_repository.dart';

class GetTasksUseCase {
  final TaskRepository taskRepository;

  GetTasksUseCase({required this.taskRepository});

  Stream<List<Task>> getTask() {
    return taskRepository.getTasks();
  }
}

class GetTaskDoneUseCase {
  final TaskRepository taskRepository;

  GetTaskDoneUseCase({required this.taskRepository});

  Stream<List<TaskDone>> getTaskDone() {
    return taskRepository.getTasksDone();
  }
}

class GetTaskUseCase {
  final TaskRepository taskRepository;

  GetTaskUseCase({required this.taskRepository});

  Future<Task> getTask(String idTask) {
    return taskRepository.getTask(idTask);
  }
}