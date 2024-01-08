import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_control_app/domain/entities/delay.dart';

abstract class DelayRepository {
  Stream<List<Delay>> getDelays();

  Future<Delay> getDelay(String idDelay);
  Future<void> addDelay(Delay delay);
  Future<void> deleteDelay(String idDelay);

  // TODO: DELAY DONE

  Future<String> addDelayDone(DelayDone delayDone, String idTaskDone);
  Future<void> updateDelayDone(Timestamp endTime, String idDelayDone, String idTaskDone);
}
