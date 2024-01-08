import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_control_app/domain/entities/delay.dart';
import 'package:time_control_app/domain/entities/task.dart';
import 'package:time_control_app/domain/entities/transport.dart';
import 'package:time_control_app/domain/entities/user.dart';

final userTimeProvider = StateProvider<User?>((ref) => null);
final transportTimeProvider = StateProvider<Transport?>((ref) => null);
final taskTimeProvider = StateProvider<Task?>((ref) => null);
final delayTimeProvider = StateProvider<Delay?>((ref) => null);
final taskDoneIdProvider = StateProvider<String>((ref) => '');
final delayTimeIdProvider = StateProvider<String>((ref) => '');
// final timerProvider = Provider((ref) => TimerUseCase());