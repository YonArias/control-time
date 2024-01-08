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

// ** Agregar
class AddTransportUseCase {
  final TransportRepository transportRepository;

  AddTransportUseCase({required this.transportRepository});

  Future<void> addTransport(Transport transport) async {
    await transportRepository.addTransport(transport);
  }
}
// ** Eliminar
class DeleteTransportUseCase {
  final TransportRepository transportRepository;

  DeleteTransportUseCase({required this.transportRepository});

  Future<void> deleteTransport(String idTransport) async {
    await transportRepository.deleteTransport(idTransport);
  }
}