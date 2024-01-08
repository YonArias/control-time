
abstract class GraficDatasource {
  Stream<List<Map<String, dynamic>>> getOperarioTime(DateTime? time);
  Stream<List<Map<String, dynamic>>> getDelayTime(DateTime? time);
  Stream<List<Map<String, dynamic>>> getTransportTime(DateTime? time);
}
