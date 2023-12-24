import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_control_app/domain/entities/task.dart';
import 'package:time_control_app/domain/entities/transport.dart';
import 'package:time_control_app/domain/entities/user.dart';

final userTimeProvider = StateProvider<User?>((ref) => null);
final transportTimeProvider = StateProvider<Transport?>((ref) => null);
final taskTimeProvider = StateProvider<Task?>((ref) => null);


// class ChronometerProvider extends ChangeNotifier {
//   int _time = 0;
//   bool isRunning = false;
//   List<String> laps = [];

//   // Inicializamos la instancia del registro
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   late CollectionReference registertimes = firestore.collection('times');

//   // TODO: APRENDER MAS SOBRE SHARED PREFERENCES
//   // Future<void> cargarDatos() async {
//   //   final SharedPreferences prefs = await SharedPreferences.getInstance();;
//   //   final List<String>? newlaps = prefs.getStringList('laps');
//   //   laps = newlaps ?? [];
//   //   print('Se cargaron los datos $laps');
//   //   notifyListeners();
//   // }

//   // Future<void> guardarDatos() async {
//   //   final SharedPreferences prefs = await SharedPreferences.getInstance();;
//   //   prefs.setStringList('laps', laps);
//   //   print('Guardando el array ${prefs.getStringList('laps')}');
//   // }

//   StreamSubscription<int>? _timeSucription;

//   void startStopTimer() {
//     if (!isRunning) {
//       // ! Iniciar el cronometro
//       _startTimer();
//     } else {
//       // ! Parar el cronometro
//       _timeSucription?.pause();
//     }
//     isRunning = !isRunning;
//     notifyListeners();
//   }

//   // Realizamos el conteo de los segundos
//   void _startTimer() {
//     // cancelamos la suscripcion
//     _timeSucription?.cancel();
//     // obtenemos suscripcion
//     _timeSucription =
//         Stream<int>.periodic(const Duration(seconds: 1), (value) => 1)
//             .listen((timeSeconds) {
//       _time += timeSeconds;
//       notifyListeners();
//     });
//   }

//   // Retornamos la hora en formato STRING
//   String get time {
//     final hours = ((_time / 3600) % 24).floor().toString().padLeft(2, '0');
//     final minutes = ((_time / 60) % 60).floor().toString().padLeft(2, '0');
//     final seconds = (_time % 60).floor().toString().padLeft(2, '0');

//     return '$hours:$minutes:$seconds';
//   }

//   // Finaliza el cronometro
//   void restart() {
//     laps.add(_time.toString());
//     // guardarDatos();
//     agregarTime(_time);
//     _time = 0;
//     _timeSucription?.pause();
//     _timeSucription?.cancel();
//     isRunning = false;

//     notifyListeners();
//   }

//   Future<void> agregarTime(int time) async {
//     await registertimes.add({'time': time});
//   }
// }
