import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_control_app/data/models/task_model.dart';
import 'package:time_control_app/data/models/user_model.dart';
import 'package:time_control_app/domain/datasources/task_datasource.dart';
import 'package:time_control_app/domain/entities/task.dart';
import 'package:time_control_app/domain/entities/user.dart';

class TaskRemoteDatasourceImpl implements TaskDatasource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Stream<List<Task>> getTasks() {
    return firestore.collection('tasks').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return TaskModel.fromJsonMap(doc.data()).toTaskEntity();
      }).toList();
    });
  }

  @override
  Future<Task> getTask(String idTask) async {
    DocumentSnapshot<Map<String, dynamic>> taskSnapshot =
        await firestore.collection('tasks').doc(idTask).get();

    if (taskSnapshot.exists) {
      // El documento existe, puedes acceder a los datos y crear un objeto Task
      Map<String, dynamic> data = taskSnapshot.data()!;
      Task task = TaskModel.fromJsonMap(data)
          .toTaskEntity(); // Asumiendo que tienes un constructor fromMap en la clase Task
      return task;
    } else {
      // El documento no existe
      throw Exception('La tarea con ID $idTask no existe.');
    }
  }

  @override
  Future<void> addTask(Task task) async {
    // Obtén la colección en la que deseas añadir el documento
    CollectionReference collection =
        FirebaseFirestore.instance.collection('tasks');
    // Añade un nuevo documento y obtén su referencia
    DocumentReference docRef = await collection.add(TaskModel(
            id: task.id,
            title: task.title,
            description: task.description,
            createDate: task.createDate)
        .toTaskJson());
    // Accede al ID del nuevo documento
    String docId = docRef.id;
    // Actualiza el documento con su propio ID en un campo específico
    await docRef.update({
      'id': docId,
    });
  }

  @override
  Future<void> deleteTask(String idTask) async {
    // Obtén la referencia al documento que deseas eliminar
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('tasks').doc(idTask);

    // Elimina el documento
    await docRef.delete();
  }

  // TODO: TASKS DONE
  @override
  Stream<List<TaskDone>> getTasksDone(DateTime? time) {
    if (time != null){
      Timestamp inicioDelDia =
        Timestamp.fromDate(DateTime(time.year, time.month, time.day));
    Timestamp finDelDia = Timestamp.fromDate(
        DateTime(time.year, time.month, time.day, 23, 59, 59, 999));
      return firestore.collection('doneTasks')
        .where('startTime', isGreaterThanOrEqualTo: inicioDelDia)
        .where('startTime', isLessThanOrEqualTo: finDelDia)
        .snapshots().map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return TaskDoneModel.fromJsonMap(doc.data()).toTaskEntity();
        }).toList();
      });
    } else {
      return firestore.collection('doneTasks').snapshots().map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return TaskDoneModel.fromJsonMap(doc.data()).toTaskEntity();
        }).toList();
      });
    }
  }

  @override
  Stream<List<TaskDone>> getTasksDoneUser(User? user) {
    final userMap = UserModel(
            id: user?.id ?? '',
            name: user?.name ?? '',
            lastname: user?.lastname ?? '',
            rol: user?.rol ?? '',
            gmail: user?.gmail ?? '',
            isActive: user?.isActive ?? true,
            isValidate: user?.isValidate ?? true)
        .toUserJson();
    DateTime today = DateTime.now();
    Timestamp inicioDelDia =
        Timestamp.fromDate(DateTime(today.year, today.month, today.day));
    Timestamp finDelDia = Timestamp.fromDate(
        DateTime(today.year, today.month, today.day, 23, 59, 59, 999));

    return firestore
        .collection('doneTasks')
        .where('user', isEqualTo: userMap)
        .where('startTime', isGreaterThanOrEqualTo: inicioDelDia)
        .where('startTime', isLessThanOrEqualTo: finDelDia)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return TaskDoneModel.fromJsonMap(doc.data()).toTaskEntity();
      }).toList();
    });
  }

  @override
  Future<String> addTaskDone(TaskDone taskDone) async {
    // Obtén la colección en la que deseas añadir el documento
    CollectionReference collection = FirebaseFirestore.instance
        .collection('doneTasks'); // ! Corregir por plural
    // Añade un nuevo documento y obtén su referencia
    DocumentReference docRef = await collection.add(TaskDoneModel(
      id: taskDone.id,
      title: taskDone.title,
      description: taskDone.description,
      startTime: taskDone.startTime,
      endTime: taskDone.endTime,
      duration: taskDone.duration,
      user: taskDone.user,
      transport: taskDone.transport,
      delays: taskDone.delays,
    ).toTaskDoneJson());
    // Accede al ID del nuevo documento
    String docId = docRef.id;
    // Actualiza el documento con su propio ID en un campo específico
    await docRef.update({
      'id': docId,
    });

    return docId;
  }

  @override
  Future<void> updateTaskDone(String idTaskDone, Timestamp endTime) async {
    final collection =
        FirebaseFirestore.instance.collection('doneTasks').doc(idTaskDone);
    // Añade un nuevo documento y obtén su referencia
    DocumentSnapshot taskDoneSnapshot = await collection.get();

    if (taskDoneSnapshot.exists) {
      final Timestamp startTime = taskDoneSnapshot['startTime'];
      final duration = endTime.seconds - startTime.seconds;
      await collection.update({'duration': duration, 'endTime': endTime});
    }
  }
}
