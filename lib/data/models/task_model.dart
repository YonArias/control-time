import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String task;
  final Timestamp startTime;
  final Timestamp endTime;
  final int duration;
  final String transportId;

  Task({
    required this.id, 
    required this.task, 
    required this.startTime, 
    required this.endTime, 
    required this.duration, 
    required this.transportId, 
  });
}
