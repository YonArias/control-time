import 'package:time_control_app/domain/entities/transport.dart';

abstract class TransportRepository {
  Stream<List<Transport>> getTransports();
  Stream<List<Transport>> getTransportsFree();
  Future<void> setTransport( Transport transport );
}
