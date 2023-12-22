import 'package:time_control_app/domain/entities/delay.dart';

abstract class DelayRepository {
  Stream<List<Delay>> getDelays();

  Future<Delay> getDelay(String idDelay);
  Future<void> addDelay(Delay delay);
  Future<void> deleteDelay(String idDelay);
}
