import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_control_app/data/datasources/user_remote_datasource_impl.dart';
import 'package:time_control_app/data/repository/user_repository_impl.dart';
import 'package:time_control_app/domain/usecases/users_usecases.dart';

final userDatasourceProvider =
    Provider<UserRemoteDatasourceImpl>((ref) => UserRemoteDatasourceImpl());

final userRepositoryProvider =
    Provider<UserRepositoryImpl>((ref) => UserRepositoryImpl(
          remoteDataSource: ref.read(userDatasourceProvider),
        ));

// Caso de uso
final getUsersProvider =
    Provider<GetUsersUseCase>((ref) => GetUsersUseCase(
      userRepository: ref.read(userRepositoryProvider),
    ));

// ** ACTUALIZAR USER
final updateUserActivityProvider = Provider<UpdateUsersUseCase>((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  return UpdateUsersUseCase(userRepository: userRepository);
});