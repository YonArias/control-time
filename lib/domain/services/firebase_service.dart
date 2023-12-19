import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getUsers() async {
  List users = [];

  CollectionReference collectionReferenceUsers = db.collection('Users');

  // Trata de traer los datos de la collecion anterior
  QuerySnapshot queryUsers = await collectionReferenceUsers.get();

  // Recoge los elementos
  queryUsers.docs.forEach((documento) {
    users.add(documento.data());
  });
  // Retorna los elementos
  return users;
}

Future<bool> isOperador(String? gmail) async {
  final firebase = FirebaseFirestore.instance;
  QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await firebase.collection('user').where('gmail', isEqualTo: gmail).get();

  if (querySnapshot.docs.isNotEmpty) {
    // Itera sobre los documentos resultantes (puede haber más de uno si hay varios usuarios con el mismo correo)
    for (QueryDocumentSnapshot<Map<String, dynamic>> document
        in querySnapshot.docs) {
      // Accede a los datos del usuario
      Map<String, dynamic> userData = document.data();

      // Comprobando si es OPERARIO
      if (userData['rol'] == 'OPERARIO') {
        return true;
      }
      return false;
    }
  }
  return false;
}
