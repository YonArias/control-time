import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_control_app/domain/entities/task.dart';
import 'package:time_control_app/domain/entities/user.dart';

abstract class TaskRepository {
  Stream<List<Task>> getTasks();

  Future<Task> getTask(String idTask);
  Future<void> addTask(Task task);
  Future<void> deleteTask(String idTask);

  // TODO: TASK DONE
  Stream<List<TaskDone>> getTasksDone(DateTime? time);
  Stream<List<TaskDone>> getTasksDoneUser(User? user);
  Future<String> addTaskDone(TaskDone taskDone);
  Future<void> updateTaskDone( String idTaskDone, Timestamp endTime);
}
