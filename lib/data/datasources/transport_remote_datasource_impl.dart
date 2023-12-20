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
        return TransportModel.fromJasonMap(doc.data()).toUserEntity();
      }).toList();
    });
  }

  @override
  Stream<List<Transport>> getTransportsFree() {
    return firestore.collection('transport').where('state', isEqualTo: '${StateTransport.AVAILABLE}').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return TransportModel.fromJasonMap(doc.data()).toUserEntity();
      }).toList();
    });
  }

  @override
  Future<void> setTransport(Transport transport) {
    // TODO: implement setTransport
    throw UnimplementedError();
  }
}