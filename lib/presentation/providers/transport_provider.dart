
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_control_app/data/datasources/transport_remote_datasource_impl.dart';
import 'package:time_control_app/data/repository/transport_repository_impl.dart';
import 'package:time_control_app/domain/usecases/transports_usecases.dart';

final transportDatasourceProvider =
    Provider<TransportRemoteDatasourceImpl>((ref) => TransportRemoteDatasourceImpl());

final transportRepositoryProvider =
    Provider<TransportRepositoryImpl>((ref) => TransportRepositoryImpl(
          remoteDataSource: ref.read(transportDatasourceProvider),
        ));

// Obtengo todos los vehiculos
final getTransportsProvider =
    Provider<GetTransportUseCase>((ref) => GetTransportUseCase(
      transportRepository: ref.read(transportRepositoryProvider),
    ));

// Obtenemos los vehiculos libres
final getTransportsFreeProvider =
    Provider<GetTransportFreeUseCase>((ref) => GetTransportFreeUseCase(
      transportRepository: ref.read(transportRepositoryProvider),
    ));