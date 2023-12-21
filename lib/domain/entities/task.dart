import 'package:cloud_firestore/cloud_firestore.dart';

// Tareas hechas
class TaskDone {
  final String id;
  final String title;
  final String description;
  final Timestamp startTime;
  final Timestamp endTime;
  final int duration;
  final String idUser;
  final String idTransport;

  TaskDone({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.idUser,
    required this.idTransport,
  });
}

// Tareas
class Task {
  final String id;
  final String title;
  final String description;
  final Timestamp createDate;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.createDate,
  });
}
