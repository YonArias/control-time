import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_control_app/data/models/user_model.dart';
import 'package:time_control_app/domain/datasources/user_datasource.dart';
import 'package:time_control_app/domain/entities/user.dart';

class UserRemoteDatasourceImpl implements UserDatasource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Stream<List<User>> getUsers() {
    return firestore.collection('user').snapshots().map((querySnapshot) {
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
  
  @override
  Stream<List<User>> getUsersOperario() {
    return firestore.collection('user').where('rol', isEqualTo: 'OPERARIO').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return UserModel.fromJasonMap(doc.data()).toUserEntity();
      }).toList();
    });
  }

  @override
  Future<void> addUser(User user) async {
    // Obtén la colección en la que deseas añadir el documento
    CollectionReference collection = FirebaseFirestore.instance
        .collection('user'); // ! Corregir por plural
    // Añade un nuevo documento y obtén su referencia
    DocumentReference docRef = await collection.add(UserModel(
      id: user.id,
      name: user.name,
      lastname: user.lastname,
      rol: user.rol,
      gmail: user.gmail,
      isActive: user.isActive,
      isValidate: user.isValidate,
    ).toUserJson());
    // Accede al ID del nuevo documento
    String docId = docRef.id;
    // Actualiza el documento con su propio ID en un campo específico
    await docRef.update({
      'id': docId,
    });
  }
  
  @override
  Future<void> updateUser(User user) async {
    // Obtén la colección en la que deseas añadir el documento
    final collection = FirebaseFirestore.instance
        .collection('user').doc(user.id); // ! Corregir por plural
    // Actualiza el documento con su propio ID en un campo específico
    await collection.update({
      'isValidate': user.isValidate,
    });
  }
}
