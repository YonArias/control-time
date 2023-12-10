import 'package:time_control_app/domain/entities/user.dart';

abstract class UserDatasource {
  Future<List<User>> getUser();
}
