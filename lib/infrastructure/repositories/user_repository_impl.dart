import 'package:time_control_app/domain/datasources/user_datasource.dart';
import 'package:time_control_app/domain/entities/user.dart';
import 'package:time_control_app/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDatasource userDatasource;

  UserRepositoryImpl({required this.userDatasource});

  @override
  Future<List<User>> getUser() {
    return userDatasource.getUser();
  }
}
