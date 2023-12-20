import 'package:cloud_firestore/cloud_firestore.dart';

class Transport {
  // final String id;
  final String name; // nombre del vehiculo
  final String placa;
  final int carga;
  final String state;
  final String type;
  final String photoUrl;
  final String description;
  final Timestamp createDate;

  Transport({
    // required this.id,
    required this.name,
    required this.placa,
    required this.carga,
    required this.state,
    required this.type,
    required this.photoUrl,
    required this.description,
    required this.createDate,
  });
}