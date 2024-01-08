import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_control_app/data/datasources/user_remote_datasource_impl.dart';
import 'package:time_control_app/data/repository/user_repository_impl.dart';
import 'package:time_control_app/domain/usecases/users_usecases.dart';

final idUser = StateProvider<String?>(
  (ref) => '',
);

final userDatasourceProvider =
    Provider<UserRemoteDatasourceImpl>((ref) => UserRemoteDatasourceImpl());

final userRepositoryProvider =
    Provider<UserRepositoryImpl>((ref) => UserRepositoryImpl(
          remoteDataSource: ref.read(userDatasourceProvider),
        ));

// ** OBTENER USUARIO ACTUAL
final getUserProvider = Provider<GetUserUseCase>((ref) => GetUserUseCase(
      userRepository: ref.read(userRepositoryProvider),
    ));

// ** MUESTRA TODOS LOS USUARIOS
final getUsersProvider = Provider<GetUsersUseCase>((ref) => GetUsersUseCase(
      userRepository: ref.read(userRepositoryProvider),
    ));

// ** MUESTRA OPERARIO
final getUsersOperarioProvider = Provider<GetUsersOperarioUseCase>((ref) => GetUsersOperarioUseCase(
      userRepository: ref.read(userRepositoryProvider),
    ));

// ** ACTUALIZAR USER ACtividad
final updateUserActivityProvider = Provider<UpdateUsersActivityUseCase>((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  return UpdateUsersActivityUseCase(userRepository: userRepository);
});

// ** ACTUALIZAR USER
final updateUserProvider = Provider<UpdateUserUseCase>((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  return UpdateUserUseCase(userRepository: userRepository);
});

// ** CREAR USER
final addUserProvider = Provider<AddUserUseCase>((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  return AddUserUseCase(userRepository: userRepository);
});