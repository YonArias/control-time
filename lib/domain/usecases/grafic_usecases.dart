import 'package:time_control_app/domain/repository/grafic_repository.dart';

class GetOperarioTimeUseCase {
  final GraficRepository graficRepository;

  GetOperarioTimeUseCase({required this.graficRepository});

  Stream<List<Map<String, dynamic>>> getOperarioTime(DateTime? time) {
    return graficRepository.getOperarioTime(time);
  }
}