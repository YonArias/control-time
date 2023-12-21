import 'package:time_control_app/data/datasources/task_remote_datasource_impl.dart';
import 'package:time_control_app/domain/entities/task.dart';
import 'package:time_control_app/domain/repository/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDatasourceImpl remoteDatasource;

  TaskRepositoryImpl({required this.remoteDatasource});

  @override
  Stream<List<Task>> getTasks() {
    return remoteDatasource.getTasks();
  }

  @override
  Stream<List<TaskDone>> getTasksDone() {
    return remoteDatasource.getTasksDone();
  }

  @override
  Future<Task> getTask(String idTask) {
    return remoteDatasource.getTask(idTask);
  }

  @override
  Stream<List<TaskDone>> getTasksDoneUser(String idUser) {
    return remoteDatasource.getTasksDoneUser(idUser);
  }
}
