import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_control_app/domain/datasources/grafic_datasource.dart';

class GraficRemoteDatasourceImpl implements GraficDatasource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Stream<List<Map<String, dynamic>>> getOperarioTime(DateTime? time) {
    return firestore.collection('doneTasks').snapshots().map((querySnapshot) {
      // Mapa para rastrear la duración total de cada operador
      Map<String, int> totalDurationMap = {};

      querySnapshot.docs.forEach((doc) {
        final int times = doc.data()['duration'] ?? 0;
        final Map<String, dynamic> operario = doc.data()['user'];

        final String operarioName = operario['name'];

        // Verificar si el operador ya está en el mapa
        if (totalDurationMap.containsKey(operarioName)) {
          // Si ya existe, sumar la duración
          totalDurationMap[operarioName] =
              int.parse('${totalDurationMap[operarioName]}') + times;
        } else {
          // Si no existe, agregar al mapa con la duración actual
          totalDurationMap[operarioName] = times;
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

  @override
  Stream<List<Map<String, dynamic>>> getDelayTime(DateTime? time) {
    return firestore.collection('doneTasks').snapshots().map((querySnapshot) {
      // Mapa para rastrear la duración total de cada operador
      Map<String, int> totalDurationMap = {};

      querySnapshot.docs.forEach((doc) {
        final List<dynamic> delays = doc.data()['delays'];

        for (var delay in delays) {
          final int times = delay['duration'] ?? 0;
          final String operarioName = delay['title'] ?? '';

          if (operarioName != '') {
            // Verificar si el operador ya está en el mapa
            if (totalDurationMap.containsKey(operarioName)) {
              // Si ya existe, sumar la duración
              totalDurationMap[operarioName] =
                  int.parse('${totalDurationMap[operarioName]}') + times;
            } else {
              // Si no existe, agregar al mapa con la duración actual
              totalDurationMap[operarioName] = times;
            }
          }
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

  @override
  Stream<List<Map<String, dynamic>>> getTransportTime(DateTime? time) {
    return firestore.collection('doneTasks').snapshots().map((querySnapshot) {
      // Mapa para rastrear la duración total de cada operador
      Map<String, int> totalDurationMap = {};

      querySnapshot.docs.forEach((doc) {
        final transport = doc.data()['transport'];
        // final Timestamp endTime = doc.data()['endTime'];
        // final Timestamp startTime = doc.data()['startTime'];

        // final int times = (endTime.toDate().difference(startTime.toDate())).inSeconds;
        final int times = doc.data()['duration'] ?? 0;
        print(times);
        final String transportName = transport['name'] ?? '';

        if (transportName != '') {
          // Verificar si el operador ya está en el mapa
          if (totalDurationMap.containsKey(transportName)) {
            // Si ya existe, sumar la duración
            totalDurationMap[transportName] =
                int.parse('${totalDurationMap[transportName]}') + times;
          } else {
            // Si no existe, agregar al mapa con la duración actual
            totalDurationMap[transportName] = times;
          }
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
