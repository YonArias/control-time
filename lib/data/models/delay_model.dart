import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_control_app/domain/entities/delay.dart';

class DelayModel {
  final String id;
  final String title;
  final String description;
  final Timestamp createDate;

  DelayModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createDate,
  });

  factory DelayModel.fromJsonMap(Map<String, dynamic> json) => DelayModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        createDate: json['createDate'],
      );

  Delay toDelayEntity() => Delay(
        id: id,
        title: title,
        description: description,
        createDate: createDate,
      );
  Map<String, dynamic> toDelayJson() => {
        'id': id,
        'title': title,
        'description': description,
        'createDate': createDate,
      };
}

class DelayDoneModel {
  final String id;
  final String title;
  final String description;
  final int duration;
  final Timestamp startTime;
  final Timestamp endTime;

  DelayDoneModel({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.startTime,
    required this.endTime,
  });

  factory DelayDoneModel.fromJsonMap(Map<String, dynamic> json) =>
      DelayDoneModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        duration: json['duration'],
      );

  DelayDone toUserEntity() => DelayDone(
        id: id,
        title: title,
        description: description,
        startTime: startTime,
        endTime: endTime,
        duration: duration,
      );

  Map<String, dynamic> toDelayDoneJson() => {
        'id': id,
        'title': title,
        'description': description,
        'duration': duration,
        'startTime': startTime,
        'endTime': endTime,
      };
}
