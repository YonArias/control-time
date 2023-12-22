import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_control_app/domain/entities/transport.dart';

class TransportModel {
  final String id;
  final String name; // nombre del vehiculo
  final String placa;
  final int carga;
  final String state;
  final String type;
  final String photoUrl;
  final String description;
  final Timestamp createDate;

  TransportModel({
    required this.id,
    required this.name,
    required this.placa,
    required this.carga,
    required this.state,
    required this.type,
    required this.photoUrl,
    required this.description,
    required this.createDate,
  });

  factory TransportModel.fromJasonMap(Map<String, dynamic> json) => TransportModel(
        id: json['id'],
        name: json['name'],
        placa: json['placa'],
        carga: json['carga'],
        state: json['state'],
        type: json['type'],
        photoUrl: json['photoUrl'],
        description: json['description'],
        createDate: json['createDate'],
      );

  Transport toTransportEntity() => Transport(
        id: id,
        name: name,
        placa: placa,
        carga: carga,
        state: state,
        type: type,
        photoUrl: photoUrl,
        description: description,
        createDate: createDate,
      );
  Map<String, dynamic> toTransportJson() => {
        'id': id,
        'name': name,
        'placa': placa,
        'carga': carga,
        'state': state,
        'type': type,
        'photoUrl': photoUrl,
        'description': description,
        'createDate': createDate
      };
}
