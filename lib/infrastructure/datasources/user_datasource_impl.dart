import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_control_app/domain/datasources/user_datasource.dart';
import 'package:time_control_app/domain/entities/user.dart';
import 'package:time_control_app/infrastructure/models/user_model.dart';

class UserDatasourceImpl implements UserDatasource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<List<User>> getUser() async {
    final List<User> newUser =
        await firestore.collection('user').get().then((snapshot) {
      return snapshot.docs
          .map((doc) => UserModel.fromJsonMap(doc.data()).toTranportEntity())
          .toList();
    });
    return newUser;
  }
}
