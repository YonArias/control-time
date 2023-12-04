import 'dart:async';
import 'package:flutter/material.dart';
//? import 'package:shared_preferences/shared_preferences.dart';

class ChronometerProvider extends ChangeNotifier {
  int _time = 0;
  bool isRunning = false;
  List<String> laps = [];

  // TODO: APRENDER MAS SOBRE SHARED PREFERENCES
  // Future<void> cargarDatos() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();;
  //   final List<String>? newlaps = prefs.getStringList('laps');
  //   laps = newlaps ?? [];
  //   print('Se cargaron los datos $laps');
  //   notifyListeners();
  // }

  // Future<void> guardarDatos() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();;
  //   prefs.setStringList('laps', laps);
  //   print('Guardando el array ${prefs.getStringList('laps')}');
  // }

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
    laps.add(_time.toString());
    print(laps);
    // guardarDatos();
    _time = 0;
    _timeSucription?.pause();
    _timeSucription?.cancel();
    isRunning = false;
    notifyListeners();
  }
}
