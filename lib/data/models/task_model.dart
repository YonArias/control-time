import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_control_app/data/models/delay_model.dart';
import 'package:time_control_app/data/models/transport_model.dart';
import 'package:time_control_app/data/models/user_model.dart';
import 'package:time_control_app/domain/entities/delay.dart';
import 'package:time_control_app/domain/entities/task.dart';
import 'package:time_control_app/domain/entities/transport.dart';
import 'package:time_control_app/domain/entities/user.dart';

// Tareas hechas
class TaskDoneModel {
  final String id;
  final String title;
  final String description;
  final Timestamp startTime;
  final Timestamp endTime;
  final int duration;
  final User? user;
  final Transport? transport;
  final List<DelayDone>? delays;

  TaskDoneModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.startTime,
      required this.endTime,
      required this.duration,
      required this.user,
      required this.transport,
      this.delays});

  factory TaskDoneModel.fromJsonMap(Map<String, dynamic> json) {
    final List<dynamic>? delaysJson = json['delays'];
    final Map<String, dynamic>? userJson = json['user'];
    final Map<String, dynamic>? transportJson = json['transport'];
    final List<DelayDone>? delaysList = delaysJson != null
        ? delaysJson
            .map((delayMap) =>
                DelayDoneModel.fromJsonMap(delayMap).toUserEntity())
            .toList()
        : null;
    User? userEntity = userJson != null ? UserModel.fromJasonMap(userJson).toUserEntity() : null;
    Transport? transportEntity = transportJson != null ? TransportModel.fromJasonMap(transportJson).toTransportEntity() : null;;
    
    return TaskDoneModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        duration: json['duration'],
        user: userEntity,
        transport: transportEntity,
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
        user: user,
        transport: transport,
        delays: delays,
      );

  Map<String, dynamic> toTaskDoneJson() {
    final userMap = UserModel(
      id: user!.id,
      name: user!.name,
      lastname: user!.lastname,
      rol: user!.rol,
      gmail: user!.gmail,
      isActive: user!.isActive,
      isValidate: user!.isValidate,
    ).toUserJson();

    final transportMap = TransportModel(
      id: transport?.id ?? '', 
      name: transport?.name ?? '', 
      placa: transport?.placa ?? '', 
      carga: transport?.carga ?? 0, 
      state: transport?.state ?? '', 
      type: transport?.type ?? '', 
      photoUrl: transport?.photoUrl ?? '', 
      description: transport?.description ?? '', 
      createDate: transport?.createDate ?? Timestamp.now(),
    ).toTransportJson();

    List<Map<String, dynamic>> listDelay = delays?.map((delay) => DelayDoneModel(
      id: delay.id, 
      title: delay.title, 
      description: delay.description, 
      duration: delay.duration, 
      startTime: delay.startTime, 
      endTime: delay.endTime
    ).toDelayDoneJson()
    ).toList() ?? [];

    return {
        'id': id,
        'title': title,
        'description': description,
        'startTime': startTime,
        'endTime': endTime,
        'duration': duration,
        'user': userMap,
        'transport': transportMap,
        'delays': listDelay, // Lista de Mandar un mapa
      };
  }
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
