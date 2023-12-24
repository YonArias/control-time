// data/repository/task_repository.dart
import 'package:time_control_app/data/datasources/user_remote_datasource_impl.dart';
import 'package:time_control_app/domain/entities/user.dart';
import 'package:time_control_app/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasourceImpl remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<User?> getUser() async {
    return remoteDataSource.getUser();
  }

  @override
  Stream<List<User>> getUsers() {
    return remoteDataSource.getUsers();
  }

  @override
  Future<void> updateUserActivity(String userId, bool isActive) async {
    await remoteDataSource.updateUserActivity(userId, isActive);
  }

  @override
  Stream<List<User>> getUsersOperario() {
    return remoteDataSource.getUsersOperario();
  }

  @override
  Future<void> addUser(User user) async {
    await remoteDataSource.addUser(user);
  }

  @override
  Future<void> updateUser(User user) async {
    await remoteDataSource.updateUser(user);
  }
}
