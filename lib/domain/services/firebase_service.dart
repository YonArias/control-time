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
