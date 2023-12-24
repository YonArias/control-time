import 'package:time_control_app/data/datasources/task_remote_datasource_impl.dart';
import 'package:time_control_app/domain/entities/task.dart';
import 'package:time_control_app/domain/entities/user.dart';
import 'package:time_control_app/domain/repository/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDatasourceImpl remoteDatasource;

  TaskRepositoryImpl({required this.remoteDatasource});

  @override
  Stream<List<Task>> getTasks() {
    return remoteDatasource.getTasks();
  }

  @override
  Future<Task> getTask(String idTask) {
    return remoteDatasource.getTask(idTask);
  }

  @override
  Future<void> addTask(Task task) async {
    await remoteDatasource.addTask(task);
  }

  @override
  Future<void> deleteTask(String idTask) async {
    await remoteDatasource.deleteTask(idTask);
  }

  // TODO: TASKS DONE
  @override
  Stream<List<TaskDone>> getTasksDone() {
    return remoteDatasource.getTasksDone();
  }

  @override
  Stream<List<TaskDone>> getTasksDoneUser(User? user) {
    return remoteDatasource.getTasksDoneUser(user);
  }

  @override
  Future<void> addTaskDone(TaskDone taskDone) async {
    await remoteDatasource.addTaskDone(taskDone);
  }
}
