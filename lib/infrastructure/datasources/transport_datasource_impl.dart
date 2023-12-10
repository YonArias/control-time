import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_control_app/domain/datasources/transport_datasource.dart';
import 'package:time_control_app/domain/entities/transport.dart';
import 'package:time_control_app/infrastructure/models/transport_model.dart';

class TransportDatasourceImpl implements TransportDatasource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<List<Transport>> getTransportByPage(int page) async {

    final List<Transport> newTransport =
        await firestore.collection('transport').get().then((snapshot) {
      return snapshot.docs
          .map((doc) => TransportModel.fromJsonMap(doc.data()).toTranportEntity())
          .toList();
    });

    return newTransport;
  }
}
