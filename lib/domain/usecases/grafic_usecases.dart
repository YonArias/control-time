import 'package:time_control_app/domain/repository/grafic_repository.dart';

class GetOperarioTimeUseCase {
  final GraficRepository graficRepository;

  GetOperarioTimeUseCase({required this.graficRepository});

  Stream<List<Map<String, dynamic>>> getOperarioTime(DateTime? time) {
    return graficRepository.getOperarioTime(time);
  }
}

class GetDelayTimeUseCase {
  final GraficRepository graficRepository;

  GetDelayTimeUseCase({required this.graficRepository});

  Stream<List<Map<String, dynamic>>> getDelayTime(DateTime? time) {
    return graficRepository.getDelayTime(time);
  }
}

class GetTransportTimeUseCase {
  final GraficRepository graficRepository;

  GetTransportTimeUseCase({required this.graficRepository});

  Stream<List<Map<String, dynamic>>> getTransportTime(DateTime? time) {
    return graficRepository.getTransportTime(time);
  }
}