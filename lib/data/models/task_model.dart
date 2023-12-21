import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_control_app/domain/entities/task.dart';

// Tareas hechas
class TaskDoneModel {
  final String id;
  final String title;
  final String description;
  final Timestamp startTime;
  final Timestamp endTime;
  final int duration;
  final String idUser;
  final String idTransport;
  // final List<Delays> delays;

  TaskDoneModel({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.idUser,
    required this.idTransport,
  });

  factory TaskDoneModel.fromJsonMap(Map<String, dynamic> json) => TaskDoneModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        duration: json['duration'],
        idUser: json['idUser'],
        idTransport: json['idTransport'],
      );

  TaskDone toUserEntity() => TaskDone(
        id: id,
        title: title,
        description: description,
        startTime: startTime,
        endTime: endTime,
        duration: duration,
        idUser: idUser,
        idTransport: idTransport,
      );
}

// Tareas
class TaskModel {
  final String id;
  final String title;
  final String description;
  final Timestamp createDate;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createDate,
  });

  factory TaskModel.fromJsonMap(Map<String, dynamic> json) => TaskModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        createDate: json['createDate'],
      );

  Task toUserEntity() => Task(
        id: id,
        title: title,
        description: description,
        createDate: createDate,
      );
}
