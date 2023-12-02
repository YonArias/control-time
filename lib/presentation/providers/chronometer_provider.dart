import 'dart:async';
import 'package:flutter/material.dart';

class ChronometerProvider extends ChangeNotifier {
  int _time = 0;
  bool isRunning = false;
  List<int> laps = [];

  StreamSubscription<int>? _timeSucription;

  void startStopTimer() {
    if (!isRunning) {
      // ! Iniciar el cronometro
      _startTimer();
    } else {
      // ! Parar el cronometro
      _timeSucription?.pause();
    }
    isRunning = !isRunning;
    notifyListeners();
  }

  // Realizamos el conteo de los segundos
  void _startTimer() {
    // cancelamos la suscripcion
    _timeSucription?.cancel();
    // obtenemos suscripcion
    _timeSucription =
        Stream<int>.periodic(const Duration(seconds: 1), (value) => 1)
            .listen((timeSeconds) {
      _time += timeSeconds;
      notifyListeners();
    });
  }

  // Retornamos la hora en formato STRING
  String get time {
    final hours = ((_time / 3600) % 24).floor().toString().padLeft(2, '0');
    final minutes = ((_time / 60) % 60).floor().toString().padLeft(2, '0');
    final seconds = (_time % 60).floor().toString().padLeft(2, '0');

    return '$hours:$minutes:$seconds';
  }

  // Finaliza el cronometro
  void restart() {
    laps.add(_time);
    _time = 0;
    _timeSucription?.pause();
    _timeSucription?.cancel();
    isRunning = false;
    print(laps);
    notifyListeners();
  }
}
