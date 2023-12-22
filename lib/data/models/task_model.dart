import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_control_app/data/models/delay_model.dart';
import 'package:time_control_app/domain/entities/delay.dart';
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
  final List<DelayDone>? delays;

  TaskDoneModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.startTime,
      required this.endTime,
      required this.duration,
      required this.idUser,
      required this.idTransport,
      this.delays});

  factory TaskDoneModel.fromJsonMap(Map<String, dynamic> json) {
    List<dynamic>? delaysJson = json['delays'];
    List<DelayDone>? delaysList = delaysJson != null
        ? delaysJson
            .map((delayMap) => DelayDoneModel.fromJsonMap(delayMap).toUserEntity())
            .toList()
        : null;

    return TaskDoneModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        duration: json['duration'],
        idUser: json['idUser'],
        idTransport: json['idTransport'],
        // Pasar delays
        delays: delaysList);
  }

  TaskDone toTaskEntity() => TaskDone(
        id: id,
        title: title,
        description: description,
        startTime: startTime,
        endTime: endTime,
        duration: duration,
        idUser: idUser,
        idTransport: idTransport,
        delays: delays,
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

  Task toTaskEntity() => Task(
        id: id,
        title: title,
        description: description,
        createDate: createDate,
      );

  Map<String, dynamic> toTaskJson() => {
        'id': id,
        'title': title,
        'description': description,
        'createDate': createDate,
      };
}
