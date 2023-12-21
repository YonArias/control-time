import 'package:time_control_app/domain/entities/task.dart';

abstract class TaskRepository {
  Stream<List<Task>> getTasks();
  Stream<List<TaskDone>> getTasksDone();

  Future<Task> getTask(String idTask);
}
