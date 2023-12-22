import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_control_app/data/datasources/task_remote_datasource_impl.dart';
import 'package:time_control_app/data/repository/task_repository_impl.dart';
import 'package:time_control_app/domain/usecases/tasks_usecases.dart';

final selectTask = StateProvider<String>(
  (ref) => '',
);

final taskDatasourceProvider =
    Provider<TaskRemoteDatasourceImpl>((ref) => TaskRemoteDatasourceImpl());

final taskRepositoryProvider =
    Provider<TaskRepositoryImpl>((ref) => TaskRepositoryImpl(
          remoteDatasource: ref.read(taskDatasourceProvider),
        ));

// Obtengo todos los vehiculos
final getTasksProvider = Provider<GetTasksUseCase>((ref) => GetTasksUseCase(
      taskRepository: ref.read(taskRepositoryProvider),
    ));

final getTasksDoneProvider =
    Provider<GetTaskDoneUseCase>((ref) => GetTaskDoneUseCase(
          taskRepository: ref.read(taskRepositoryProvider),
        ));

final getTaskProvider =
    Provider<GetTaskUseCase>((ref) => GetTaskUseCase(
          taskRepository: ref.read(taskRepositoryProvider),
        ));

final getTaskDoneUserProvider =
    Provider<GetTaskDoneUserUseCase>((ref) => GetTaskDoneUserUseCase(
          taskRepository: ref.read(taskRepositoryProvider),
        ));
