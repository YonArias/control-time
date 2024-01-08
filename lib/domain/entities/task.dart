import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_control_app/domain/entities/delay.dart';
import 'package:time_control_app/domain/entities/transport.dart';
import 'package:time_control_app/domain/entities/user.dart';

// Tareas hechas
class TaskDone {
  final String id;
  final String title;
  final String description;
  final Timestamp startTime;
  final Timestamp endTime;
  final int duration;
  final User? user;
  final Transport? transport;
  final List<DelayDone>? delays;

  TaskDone({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.user,
    required this.transport,
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
