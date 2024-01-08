import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_control_app/data/models/transport_model.dart';
import 'package:time_control_app/domain/datasources/transport_datasource.dart';
import 'package:time_control_app/domain/entities/transport.dart';
import 'package:time_control_app/presentation/parameters.dart';

class TransportRemoteDatasourceImpl implements TransportDatasource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Stream<List<Transport>> getTransports() {
    return firestore.collection('transport').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return TransportModel.fromJasonMap(doc.data()).toTransportEntity();
      }).toList();
    });
  }

  @override
  Stream<List<Transport>> getTransportsFree() {
    return firestore
        .collection('transport')
        .where('state', isEqualTo: '${StateTransport.AVAILABLE}')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return TransportModel.fromJasonMap(doc.data()).toTransportEntity();
      }).toList();
    });
  }

  @override
  Future<void> setTransport(Transport transport) {
    // TODO: implement setTransport
    throw UnimplementedError();
  }

  @override
  Future<void> addTransport(Transport transport) async {
    // Obtén la colección en la que deseas añadir el documento
    CollectionReference collection = FirebaseFirestore.instance
        .collection('transport'); // ! Corregir por plural
    // Añade un nuevo documento y obtén su referencia
    DocumentReference docRef = await collection.add(TransportModel(
      id: transport.id,
      name: transport.name,
      type: transport.type,
      placa: transport.placa,
      carga: transport.carga,
      description: transport.description,
      photoUrl: transport.photoUrl,
      state: transport.state,
      createDate: transport.createDate,
    ).toTransportJson());
    // Accede al ID del nuevo documento
    String docId = docRef.id;
    // Actualiza el documento con su propio ID en un campo específico
    await docRef.update({
      'id': docId,
    });
  }

  @override
  Future<void> deleteTransport(String idTransport) async {
    // Obtén la referencia al documento que deseas eliminar
    DocumentReference docRef = FirebaseFirestore.instance.collection('transport').doc(idTransport);

    // Elimina el documento
    await docRef.delete();
  }
}
