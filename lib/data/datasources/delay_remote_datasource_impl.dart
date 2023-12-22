

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_control_app/data/models/delay_model.dart';
import 'package:time_control_app/domain/datasources/delay_datasource.dart';
import 'package:time_control_app/domain/entities/delay.dart';

class DelayRemoteDatasourceImpl implements DelayDatasource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Stream<List<Delay>> getDelays() {
    return firestore.collection('delays').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return DelayModel.fromJsonMap(doc.data()).toDelayEntity();
      }).toList();
    });
  }

  @override
  Future<void> addDelay(Delay delay) async {
    // Obtén la colección en la que deseas añadir el documento
    CollectionReference collection = FirebaseFirestore.instance.collection('delays');
    // Añade un nuevo documento y obtén su referencia
    DocumentReference docRef = await collection.add(DelayModel(
      id: delay.id, 
      title: delay.title, 
      description: delay.description, 
      createDate: delay.createDate
    ).toDelayJson()
    );
    // Accede al ID del nuevo documento
    String docId = docRef.id;
    // Actualiza el documento con su propio ID en un campo específico
    await docRef.update({
      'id': docId,
    });
  }

  @override
  Future<Delay> getDelay(String idDelay) {
    // TODO: implement getDelay
    throw UnimplementedError();
  }
  
  @override
  Future<void> deleteDelay(String idDelay) async {
    // Obtén la referencia al documento que deseas eliminar
    DocumentReference docRef = FirebaseFirestore.instance.collection('delays').doc(idDelay);

    // Elimina el documento
    await docRef.delete();
  }
}
