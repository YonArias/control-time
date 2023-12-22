import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_control_app/data/datasources/delay_remote_datasource_impl.dart';
import 'package:time_control_app/data/repository/delay_repository_impl.dart';
import 'package:time_control_app/domain/usecases/delays_usecases.dart';

final delayDatasourceProvider =
    Provider<DelayRemoteDatasourceImpl>((ref) => DelayRemoteDatasourceImpl());

final delayRepositoryProvider =
    Provider<DelayRepositoryImpl>((ref) => DelayRepositoryImpl(
          remoteDatasource: ref.read(delayDatasourceProvider),
        ));

// Obtengo todos los vehiculos
final getDelaysProvider = Provider<GetDelaysUseCase>((ref) => GetDelaysUseCase(
      delayRepository: ref.read(delayRepositoryProvider),
    ));

// Agregar Delay
final addDelayProvider = Provider<AddDelayUseCase>((ref) => AddDelayUseCase(
      delayRepository: ref.read(delayRepositoryProvider),
    ));
// Eliminar Delay
final deleteDelayProvider = Provider<DeleteDelayUseCase>((ref) => DeleteDelayUseCase(
      delayRepository: ref.read(delayRepositoryProvider),
    ));