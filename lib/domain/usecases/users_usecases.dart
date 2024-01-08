// domain/usecases/get_tasks_usecase.dart
import 'package:time_control_app/domain/entities/user.dart';
import 'package:time_control_app/domain/repository/user_repository.dart';

// ** OBTENER UN USUARIO
class GetUserUseCase {
  final UserRepository userRepository;

  GetUserUseCase({required this.userRepository});

  Future<User?> getUser() async {
    return userRepository.getUser();
  }
}

// ** MUESTRA TODOS LOS USUARIOS
class GetUsersUseCase {
  final UserRepository userRepository;

  GetUsersUseCase({required this.userRepository});

  Stream<List<User>> getUsers() {
    return userRepository.getUsers();
  }
}
// ** ACTUALIZA LA ACTIVIDAD DE USUARIO
class UpdateUsersActivityUseCase {
  final UserRepository userRepository;

  UpdateUsersActivityUseCase({required this.userRepository});

  Future<void> updateUserActivity(String userId, bool isActive) async {
    await userRepository.updateUserActivity(userId, isActive);
  }
}
// ** MUESTRA OPERARIOS
class GetUsersOperarioUseCase {
  final UserRepository userRepository;

  GetUsersOperarioUseCase({required this.userRepository});

  Stream<List<User>> getUsersOperario() {
    return userRepository.getUsersOperario();
  }
}
// ** ACTUALIZAR USUARIO
class UpdateUserUseCase {
  final UserRepository userRepository;

  UpdateUserUseCase({required this.userRepository});

  Future<void> updateUser( User user ) async {
    await userRepository.updateUser(user);
  }
}
// ** AGREGAR USUARIO
class AddUserUseCase {
  final UserRepository userRepository;

  AddUserUseCase({required this.userRepository});

  Future<void> addUser(User user) async {
    await userRepository.addUser(user);
  }
}
