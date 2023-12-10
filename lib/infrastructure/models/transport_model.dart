import 'package:time_control_app/domain/entities/transport.dart';

class TransportModel {
  TransportModel(
      {required this.name,
      required this.type,
      required this.placa,
      this.ntank = 1,
      required this.capacityTank,
      required this.fuel,
      required this.available});

  final String name;
  final String type;
  final String placa;
  final int ntank;
  final double capacityTank;
  final String fuel;
  final bool available;

  factory TransportModel.fromJsonMap(Map<String, dynamic> json) =>
      TransportModel(
          name: json['name'] ?? 'No name',
          type: json['type'],
          placa: json['placa'],
          ntank: json['ntank'],
          capacityTank: json['capacityTank'],
          fuel: json['fuel'],
          available: json['available']);

  Transport toTranportEntity() => Transport(
      name: name,
      type: type,
      placa: placa,
      ntank: ntank,
      capacityTank: capacityTank,
      fuel: fuel,
      available: available,
    );
}
