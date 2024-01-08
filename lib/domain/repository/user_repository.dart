import 'package:time_control_app/domain/entities/user.dart';

abstract class UserRepository {
  Future<User?> getUser();
  Stream<List<User>> getUsers();
  Stream<List<User>> getUsersOperario();

  Future<void> addUser(User user);
  Future<void> updateUser(User user);
  Future<void> updateUserActivity(String userId, bool isActive);
}
