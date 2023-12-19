import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_control_app/data/models/user_model.dart';
import 'package:time_control_app/domain/datasources/user_datasource.dart';
import 'package:time_control_app/domain/entities/user.dart';

class UserRemoteDatasourceImpl implements UserDatasource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Stream<List<User>> getUsers() {
    return firestore.collection('user').where('rol', isEqualTo: 'OPERARIO').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return UserModel.fromJasonMap(doc.data()).toUserEntity();
      }).toList();
    });
  }
  
  @override
  Future<void> updateUserActivity(String userId, bool isActive) async {
    await firestore.collection('user').doc(userId).update({
      'isActive': isActive,
    });
  }
}
