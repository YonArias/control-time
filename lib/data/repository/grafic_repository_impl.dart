import 'package:time_control_app/data/datasources/grafic_remote_datasource_impl.dart';
import 'package:time_control_app/domain/repository/grafic_repository.dart';

class GraficRepositoryImpl implements GraficRepository {
  final GraficRemoteDatasourceImpl remoteDatasource;

  GraficRepositoryImpl({required this.remoteDatasource});

  @override
  Stream<List<Map<String, dynamic>>> getOperarioTime(DateTime? time) {
    return remoteDatasource.getOperarioTime(time);
  }

  @override
  Stream<List<Map<String, dynamic>>> getDelayTime(DateTime? time) {
    return remoteDatasource.getDelayTime(time);
  }

  @override
  Stream<List<Map<String, dynamic>>> getTransportTime(DateTime? time) {
    return remoteDatasource.getTransportTime(time);
  }
}
