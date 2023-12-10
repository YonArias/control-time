import 'package:time_control_app/domain/entities/user.dart';

abstract class UserRepository {
  Future<List<User>> getUser();
}
