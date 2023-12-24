import 'package:time_control_app/domain/entities/task.dart';

abstract class TaskDatasource {
  Stream<List<Task>> getTasks();

  Future<Task> getTask(String idTask);
  Future<void> addTask(Task task);
  Future<void> deleteTask(String idTask);

  // TODO: TASK DONE
  Stream<List<TaskDone>> getTasksDone();
  Stream<List<TaskDone>> getTasksDoneUser(String idUser);
  Future<void> addTaskDone(TaskDone taskDone);
}
