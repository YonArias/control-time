import 'package:time_control_app/domain/entities/task.dart';

abstract class TaskRepository {
  Stream<List<Task>> getTasks();
  Stream<List<TaskDone>> getTasksDone();
  Stream<List<TaskDone>> getTasksDoneUser(String idUser);

  Future<Task> getTask(String idTask);
  Future<void> addTask(Task task);
  Future<void> deleteTask(String idTask);
}
