import 'package:time_control_app/domain/datasources/transport_datasource.dart';
import 'package:time_control_app/domain/entities/transport.dart';
import 'package:time_control_app/domain/repositories/transport_repository.dart';

class TransportRepositoryImpl implements TransportRepository {
  final TransportDatasource transportDatasource;

  TransportRepositoryImpl({
    required this.transportDatasource,
  });

  @override
  Future<List<Transport>> getTransportByPage(int page) {
    return transportDatasource.getTransportByPage(page);
  }
}
