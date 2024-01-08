import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class TimerUseCase {
  Timestamp? startTime; // Tiempo inicial
  Timestamp? endTime;// Tiempo final
  bool isPaused = false; // Esta pausado el cronometro principal?
  bool isDelayActive = false; // Esta el delay activo?

  late StreamController<int> _timerController;
  late Stream<int> timerStream;

  TimerUseCase() {
    _timerController = StreamController<int>();
    timerStream = _timerController.stream;
  }

  void _startTimerUpdates() {

    Timer.periodic( const Duration(seconds: 1), (timer) {
      

      // if (!isPaused) {
      //   if (isDelayActive) {
      //     _timerController
      //         .add(-1); // Utilizamos -1 para indicar una demora en la UI
      //   } else if (startTime != null) {
      //     final elapsedSeconds =
      //         Timestamp.now().(startTime!).inSeconds;
      //     _timerController.add(elapsedSeconds);
      //   }
      // }
    });
  }

  void startTimer() {
    if (isPaused) {
      _resumeTimerUpdates();
    } else {
      startTime = Timestamp.now();
      _startTimerUpdates();
    }
  }

  void stopTimer() {
    endTime = Timestamp.now();
    _stopTimerUpdates();
  }

  void pauseTimer() {
    isPaused = true;
  }

  void resumeTimer() {
    isPaused = false;
    _resumeTimerUpdates();
  }

  void addDelay() {
    isDelayActive = true;
    _timerController.add(-1); // Utilizamos -1 para indicar una demora en la UI
    _startTimerUpdates();
  }

  void stopDelay() {
    isDelayActive = false;
    _resumeTimerUpdates();
  }

  

  void _stopTimerUpdates() {
    _timerController.close();
  }

  void _resumeTimerUpdates() {
    _timerController.close();
    _timerController = StreamController<int>();
    timerStream = _timerController.stream;
    _startTimerUpdates();
  }

  // int getTimeElapsed() {
  //   if (startTime != null && endTime != null) {
  //     final elapsedSeconds = endTime!.difference(startTime!).inSeconds;
  //     return elapsedSeconds;
  //   } else {
  //     return 0;
  //   }
  // }
}
