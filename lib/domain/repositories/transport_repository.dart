import 'package:time_control_app/domain/entities/transport.dart';

abstract class TransportRepository {

  Future<List<Transport>> getTransportByPage(int page);

}