import 'package:cloud_firestore/cloud_firestore.dart';

class Delay {
  final String id;
  final String title;
  final String description;
  final Timestamp createDate;

  Delay({
    required this.id,
    required this.title,
    required this.description,
    required this.createDate,
  });
}

class DelayDone {
  final String id;
  final String title;
  final String description;
  final int duration;
  final Timestamp startTime;
  final Timestamp endTime;

  DelayDone({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.startTime,
    required this.endTime,
  });
}
