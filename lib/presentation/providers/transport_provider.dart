import 'package:flutter/foundation.dart';
import 'package:time_control_app/data/models/transport_model.dart';

class TransportProvider extends ChangeNotifier {

  bool initialLoading = true;
  List<Transport> tranports = [];

  // Future<void> loadTransport() async {
  //   final newTransports = Transport(name: 'name', type: 'type', placa: 'placa', ntank: 3, capacityTank: 3, fuel: 'fuel', available: true);

  //   tranports.addAll(newTransports as Iterable<Transport>);
  //   initialLoading = false;

  //   notifyListeners();
  // }

  Future<void> uploadTransport() async {

  }
}
