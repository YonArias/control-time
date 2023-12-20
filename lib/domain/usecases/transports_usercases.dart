import 'package:time_control_app/domain/entities/transport.dart';
import 'package:time_control_app/domain/repository/transport_repository.dart';

class GetTransportUseCase {
  final TransportRepository transportRepository;

  GetTransportUseCase({required this.transportRepository});

  Stream<List<Transport>> getTransports() {
    return transportRepository.getTransports();
  }
}

class GetTransportFreeUseCase {
  final TransportRepository transportRepository;

  GetTransportFreeUseCase({required this.transportRepository});

  Stream<List<Transport>> getTransportsFree() {
    return transportRepository.getTransportsFree();
  }
}