// data/repository/task_repository.dart
import 'package:time_control_app/data/datasources/user_remote_datasource_impl.dart';
import 'package:time_control_app/domain/entities/user.dart';
import 'package:time_control_app/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasourceImpl remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});
  
  @override
  Stream<List<User>> getUsers() {
    return remoteDataSource.getUsers();
  }
  
  @override
  Future<void> updateUserActivity(String userId, bool isActive) async {
    await remoteDataSource.updateUserActivity(userId, isActive);
  }
}