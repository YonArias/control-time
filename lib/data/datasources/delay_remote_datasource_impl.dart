import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_control_app/data/models/delay_model.dart';
import 'package:time_control_app/domain/datasources/delay_datasource.dart';
import 'package:time_control_app/domain/entities/delay.dart';

class DelayRemoteDatasourceImpl implements DelayDatasource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Stream<List<Delay>> getDelays() {
    return firestore.collection('delays').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return DelayModel.fromJsonMap(doc.data()).toDelayEntity();
      }).toList();
    });
  }

  @override
  Future<void> addDelay(Delay delay) async {
    // Obtén la colección en la que deseas añadir el documento
    CollectionReference collection =
        FirebaseFirestore.instance.collection('delays');
    // Añade un nuevo documento y obtén su referencia
    DocumentReference docRef = await collection.add(DelayModel(
            id: delay.id,
            title: delay.title,
            description: delay.description,
            createDate: delay.createDate)
        .toDelayJson());
    // Accede al ID del nuevo documento
    String docId = docRef.id;
    // Actualiza el documento con su propio ID en un campo específico
    await docRef.update({
      'id': docId,
    });
  }

  @override
  Future<Delay> getDelay(String idDelay) {
    // TODO: implement getDelay
    throw UnimplementedError();
  }

  @override
  Future<void> deleteDelay(String idDelay) async {
    // Obtén la referencia al documento que deseas eliminar
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('delays').doc(idDelay);

    // Elimina el documento
    await docRef.delete();
  }

  //TODO: DELAY DONE

  @override
  Future<String> addDelayDone(DelayDone delayDone, String idTaskDone) async {
    String id = '';
    // Obtén la colección en la que deseas añadir el documento
    final collection =
        FirebaseFirestore.instance.collection('doneTasks').doc(idTaskDone);
    // Añade un nuevo documento y obtén su referencia
    DocumentSnapshot taskDoneSnapshot = await collection.get();

    if (taskDoneSnapshot.exists) {
      List<dynamic> listDelays = taskDoneSnapshot['delays'] ?? [];

      listDelays.add(DelayDoneModel(
              id: id = listDelays.length.toString(),
              title: delayDone.title,
              description: delayDone.description,
              duration: delayDone.duration,
              startTime: delayDone.startTime,
              endTime: delayDone.endTime)
          .toDelayDoneJson());
      await collection.update({'delays': listDelays});
    }

    return id;
  }

  @override
  Future<void> updateDelayDone(
      Timestamp endTime, String idDelayDone, String idTaskDone) async {
    // Obtén la colección en la que deseas añadir el documento
    final collection =
        FirebaseFirestore.instance.collection('doneTasks').doc(idTaskDone);

    final taskDone = await collection.get();
    // Añade un nuevo documento y obtén su referencia
    if (taskDone.exists) {
      List<dynamic> listDelays = taskDone['delays'];

      for (int i = 0; i < listDelays.length; i++) {
        var elemento = listDelays[i];
        if (elemento['id'] == idDelayDone) {
          final Timestamp startTime = elemento['startTime'];
          final duration = endTime.seconds - startTime.seconds;
          elemento['endTime'] = endTime;
          elemento['duration'] = duration;

          listDelays[i] = elemento;
        }
      }

      collection.update({'delays': listDelays});
    }

    // if (taskDoneSnapshot.exists) {
    //   List<dynamic> listDelays = taskDoneSnapshot['delays'];

    //   final Timestamp startTime = taskDoneSnapshot['startTime'];
    //   final duration = endTime.seconds - startTime.seconds;
    //   // await collection.update({'duration': duration, 'endTime': endTime});

    //   for (int i = 0; i < listDelays.length; i++) {
    //     var elemento = listDelays[i];
    //     if (elemento['id'] == idDelayDone) {
    //       elemento['endTime'] = endTime;
    //       elemento['duration'] = duration;

    //       listDelays[i] = elemento;
    //     }
    //   }

    //   await collection.update({'delays': listDelays});
    // }
  }
}
