import 'package:time_control_app/data/datasources/delay_remote_datasource_impl.dart';
import 'package:time_control_app/domain/entities/delay.dart';
import 'package:time_control_app/domain/repository/delay_repository.dart';

class DelayRepositoryImpl implements DelayRepository {
  final DelayRemoteDatasourceImpl remoteDatasource;

  DelayRepositoryImpl({required this.remoteDatasource});

  @override
  Stream<List<Delay>> getDelays() {
    return remoteDatasource.getDelays();
  }

  @override
  Future<void> addDelay(Delay delay) async {
    await remoteDatasource.addDelay(delay);
  }

  @override
  Future<Delay> getDelay(String idDelay) {
    // TODO: implement getDelay
    throw UnimplementedError();
  }

  @override
  Future<void> deleteDelay(String idDelay) async {
    await remoteDatasource.deleteDelay(idDelay);
  }
}
