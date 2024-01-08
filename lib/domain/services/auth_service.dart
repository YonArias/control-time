import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final firebase = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

Future<String?> loguearEmailAndPassword(String email, String password) async {
  String? id;
  try {
    // Ya me logueo con esta linea
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firebase
        .collection('user')
        .where('gmail', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Itera sobre los documentos resultantes (puede haber más de uno si hay varios usuarios con el mismo correo)
      for (QueryDocumentSnapshot<Map<String, dynamic>> document
          in querySnapshot.docs) {
        if (document.data()['isValidate']) {
          id = document.id;
        } else {
          logoutUser();
        }
      }
    }

    return id;
  } catch (e) {
    print("Error al iniciar sesión con correo y contraseña: $e");
    return null;
  }
}

Future<String?> logoutUser() async {
  String id = "";
  try {
    String? email = auth.currentUser!.email;

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firebase
        .collection('user')
        .where('gmail', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Itera sobre los documentos resultantes (puede haber más de uno si hay varios usuarios con el mismo correo)
      for (QueryDocumentSnapshot<Map<String, dynamic>> document
          in querySnapshot.docs) {
        id = document.id;
      }
    }
    auth.signOut();
    return id;
  } catch (e) {
    print("Error al iniciar sesión con correo y contraseña: $e");
    return null;
  }
}
