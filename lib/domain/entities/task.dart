import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_control_app/domain/entities/delay.dart';

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
  final List<DelayDone>? delays;

  TaskDone({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.idUser,
    required this.idTransport,
    this.delays,
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
