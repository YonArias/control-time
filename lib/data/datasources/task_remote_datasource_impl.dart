import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_control_app/data/models/task_model.dart';
import 'package:time_control_app/domain/datasources/task_datasource.dart';
import 'package:time_control_app/domain/entities/task.dart';

class TaskRemoteDatasourceImpl implements TaskDatasource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Stream<List<Task>> getTasks() {
    return firestore.collection('tasks').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return TaskModel.fromJsonMap(doc.data()).toUserEntity();
      }).toList();
    });
  }

  @override
  Stream<List<TaskDone>> getTasksDone() {
    // TODO: implement getTasksDone
    throw UnimplementedError();
  }

  @override
  Future<Task> getTask(String idTask) async {
    DocumentSnapshot<Map<String, dynamic>> taskSnapshot =
      await firestore.collection('tasks').doc(idTask).get();

    if (taskSnapshot.exists) {
      // El documento existe, puedes acceder a los datos y crear un objeto Task
      Map<String, dynamic> data = taskSnapshot.data()!;
      Task task = TaskModel.fromJsonMap(data).toUserEntity(); // Asumiendo que tienes un constructor fromMap en la clase Task
      return task;
    } else {
      // El documento no existe
      throw Exception('La tarea con ID $idTask no existe.');
    }
  }
}
