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
        return TaskModel.fromJsonMap(doc.data()).toTaskEntity();
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
      Task task = TaskModel.fromJsonMap(data).toTaskEntity(); // Asumiendo que tienes un constructor fromMap en la clase Task
      return task;
    } else {
      // El documento no existe
      throw Exception('La tarea con ID $idTask no existe.');
    }
  }
  
  @override
  Stream<List<TaskDone>> getTasksDoneUser(String idUser) {
    Timestamp today = Timestamp.now();
    return firestore.collection('doneTasks')
      .where('idUser', isEqualTo: idUser)
      .where('startTime', isLessThan: today )
      .snapshots().map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return TaskDoneModel.fromJsonMap(doc.data()).toTaskEntity();
        }).toList();
      });
  }
  
  @override
  Future<void> addTask(Task task) async {
    // Obtén la colección en la que deseas añadir el documento
    CollectionReference collection = FirebaseFirestore.instance.collection('tasks');
    // Añade un nuevo documento y obtén su referencia
    DocumentReference docRef = await collection.add(TaskModel(
      id: task.id, 
      title: task.title, 
      description: task.description, 
      createDate: task.createDate
    ).toTaskJson()
    );
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
    DocumentReference docRef = FirebaseFirestore.instance.collection('tasks').doc(idTask);

    // Elimina el documento
    await docRef.delete();
  }
}
