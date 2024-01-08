import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_control_app/data/datasources/grafic_remote_datasource_impl.dart';
import 'package:time_control_app/data/repository/grafic_repository_impl.dart';
import 'package:time_control_app/domain/usecases/grafic_usecases.dart';

final graficDatasourceProvider =
    Provider<GraficRemoteDatasourceImpl>((ref) => GraficRemoteDatasourceImpl());

final graficRepositoryProvider =
    Provider<GraficRepositoryImpl>((ref) => GraficRepositoryImpl(
          remoteDatasource: ref.read(graficDatasourceProvider),
        ));

// Obtengo los datos de operario con time
final getOperarioTimeProvider = Provider<GetOperarioTimeUseCase>((ref) => GetOperarioTimeUseCase(
      graficRepository: ref.read(graficRepositoryProvider),
    ));

// Obtengo los datos de las demoras
final getDelayTimeProvider = Provider<GetDelayTimeUseCase>((ref) => GetDelayTimeUseCase(
      graficRepository: ref.read(graficRepositoryProvider),
    ));

// Obtengo los datos de las demoras
final getTransportTimeProvider = Provider<GetTransportTimeUseCase>((ref) => GetTransportTimeUseCase(
      graficRepository: ref.read(graficRepositoryProvider),
    ));