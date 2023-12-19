// domain/usecases/get_tasks_usecase.dart
import 'package:time_control_app/domain/entities/user.dart';
import 'package:time_control_app/domain/repository/user_repository.dart';

class GetUsersUseCase {
  final UserRepository userRepository;

  GetUsersUseCase({required this.userRepository});

  Stream<List<User>> getUsers() {
    return userRepository.getUsers();
  }
}

class UpdateUsersUseCase {
  final UserRepository userRepository;

  UpdateUsersUseCase({required this.userRepository});

  Future<void> updateUserActivity(String userId, bool isActive) async {
    await userRepository.updateUserActivity(userId, isActive);
  }
}
