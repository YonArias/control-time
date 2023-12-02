import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier {
  // Crear atributos
  int _counter = 0;


  // Creamos los metodos
  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }

  void disminuye() {
    _counter--;
    notifyListeners();
  }
}
