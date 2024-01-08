import 'package:time_control_app/domain/entities/transport.dart';

abstract class TransportDatasource {
  Stream<List<Transport>> getTransports();
  Stream<List<Transport>> getTransportsFree();
  Future<void> setTransport(Transport transport);

  Future<void> addTransport(Transport transport);
  Future<void> deleteTransport(String idTransport);
}
