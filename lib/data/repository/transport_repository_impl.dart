import 'package:time_control_app/data/datasources/transport_remote_datasource_impl.dart';
import 'package:time_control_app/domain/entities/transport.dart';
import 'package:time_control_app/domain/repository/transport_repository.dart';

class TransportRepositoryImpl implements TransportRepository {
  final TransportRemoteDatasourceImpl remoteDataSource;

  TransportRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<List<Transport>> getTransports() {
    return remoteDataSource.getTransports();
  }

  @override
  Stream<List<Transport>> getTransportsFree() {
    return remoteDataSource.getTransportsFree();
  }

  @override
  Future<void> setTransport(Transport transport) {
    // TODO: implement setTransport
    throw UnimplementedError();
  }
}
