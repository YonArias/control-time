import 'package:time_control_app/domain/entities/delay.dart';
import 'package:time_control_app/domain/repository/delay_repository.dart';

class GetDelaysUseCase {
  final DelayRepository delayRepository;

  GetDelaysUseCase({required this.delayRepository});

  Stream<List<Delay>> getDelays() {
    return delayRepository.getDelays();
  }
}

class AddDelayUseCase {
  final DelayRepository delayRepository;

  AddDelayUseCase({required this.delayRepository});

  Future<void> addDelay(Delay delay) async {
    await delayRepository.addDelay(delay);
  }
}

class DeleteDelayUseCase {
  final DelayRepository delayRepository;

  DeleteDelayUseCase({required this.delayRepository});

  Future<void> deleteDelay(String idDelay) async {
    await delayRepository.deleteDelay(idDelay);
  }
}