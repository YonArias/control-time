import 'package:time_control_app/domain/entities/user.dart';

abstract class UserDatasource {
  Stream<List<User>> getUsers();
  Future<void> updateUserActivity(String userId, bool isActive);
}
