import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_control_app/domain/datasources/grafic_datasource.dart';

class GraficRemoteDatasourceImpl implements GraficDatasource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Stream<List<Map<String, dynamic>>> getOperarioTime(DateTime? time) {
    // return firestore.collection('doneTasks').snapshots().map((querySnapshot) {
    //   return querySnapshot.docs.map((doc) {
    //     final int time = doc.data()['duration'];
    //     final Map<String, dynamic> operario = doc.data()['user'];

    //     Map<String, dynamic> operarioReturn = {
    //       'name': operario['name'],
    //       'duration': time
    //     };
    //     return operarioReturn;
    //   }).toList();
    // });
    return firestore.collection('doneTasks').snapshots().map((querySnapshot) {
      // Mapa para rastrear la duración total de cada operador
      Map<String, int> totalDurationMap = {};

      querySnapshot.docs.forEach((doc) {
        final int time = doc.data()['duration'] ?? 0;
        final Map<String, dynamic> operario = doc.data()['user'];

        final String operarioName = operario['name'];

        // Verificar si el operador ya está en el mapa
        if (totalDurationMap.containsKey(operarioName)) {
          // Si ya existe, sumar la duración
          totalDurationMap[operarioName] = int.parse('${totalDurationMap[operarioName]}') + time;
        } else {
          // Si no existe, agregar al mapa con la duración actual
          totalDurationMap[operarioName] = time;
        }
      });

      // Convertir el mapa a una lista de mapas para el retorno
      List<Map<String, dynamic>> result = totalDurationMap.entries
          .map((entry) => {
                'name': entry.key,
                'duration': entry.value,
              })
          .toList();

      return result;
    });
  }
}
