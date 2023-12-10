import 'package:flutter/foundation.dart';
import 'package:time_control_app/domain/entities/transport.dart';
import 'package:time_control_app/domain/repositories/transport_repository.dart';

class TransportProvider extends ChangeNotifier {
  final TransportRepository transportRepository;

  bool initialLoading = true;
  List<Transport> tranports = [];

  TransportProvider({required this.transportRepository});

  Future<void> loadTransport() async {
    final newTransports = await transportRepository.getTransportByPage(1);

    tranports.addAll(newTransports);
    initialLoading = false;

    notifyListeners();
  }

  Future<void> uploadTransport() async {

  }
}
