import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:time_control_app/domain/entities/delay.dart';
import 'package:time_control_app/domain/entities/task.dart';
import 'package:time_control_app/presentation/providers/chronometer_provider.dart';
import 'package:time_control_app/presentation/providers/delay_provider.dart';
import 'package:time_control_app/presentation/providers/task_provider.dart';
import 'package:time_control_app/presentation/widgets/custom_buttons/controller_buttons.dart';

class ControlTimeScreen extends StatelessWidget {
  const ControlTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control de tiempos'),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => context.push('/home/profile'),
            child: const CircleAvatar(
              child: Icon(Icons.person_2_outlined),
              // backgroundImage: NetworkImage(user?.photoURL ?? ''),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 150, left: 20, right: 20),
        child: Column(
          children: [
            Consumer(
              builder: (context, ref, child) {
                final taskTime = ref.watch(taskTimeProvider);
                return Card(
                  child: ListTile(
                    title: Center(child: Text(taskTime!.title)),
                  ),
                );
              },
            ),

            const SizedBox(
              height: 100,
            ),
            // Pantalla o animacion

            const _ControllerButtons(),
          ],
        ),
      ),
    );
  }
}

class _ControllerButtons extends StatefulWidget {
  const _ControllerButtons();

  @override
  State<_ControllerButtons> createState() => __ControllerButtonsState();
}

class __ControllerButtonsState extends State<_ControllerButtons> {
  bool isActive = false;
  bool isDelay = false;

  final StopWatchTimer _stopWatchTimerMain =
      StopWatchTimer(mode: StopWatchMode.countUp);
  final StopWatchTimer _stopWatchTimerDelay =
      StopWatchTimer(mode: StopWatchMode.countUp);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimerMain.dispose();
    await _stopWatchTimerDelay.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
          stream: _stopWatchTimerMain.rawTime,
          initialData: 0,
          builder: (context, snapshot) {
            final value = snapshot.data;
            final displayTime =
                StopWatchTimer.getDisplayTime(value!, milliSecond: false);
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 50),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                    child: Text(
                  displayTime,
                  style: const TextStyle(fontSize: 36),
                )),
              ),
            );
          },
        ),
        if (isDelay)
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              StreamBuilder(
                stream: _stopWatchTimerDelay.rawTime,
                initialData: 0,
                builder: (context, snapshot) {
                  final value = snapshot.data;
                  final displayTimeDelay =
                      StopWatchTimer.getDisplayTime(value!, milliSecond: false);
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                          child: Text(
                        displayTimeDelay,
                        style: const TextStyle(fontSize: 36),
                      )),
                    ),
                  );
                },
              ),
            ],
          ),
        const SizedBox(
          height: 100,
        ),
        // Botones controlador

        if (!isActive && !isDelay)
          Consumer(
            builder: (context, ref, child) => ControllerButtonWidget(
              icon: Icons.play_arrow,
              name: 'INICIAR',
              color: Colors.blue,
              dark: true,
              ontap: () async {
                final taskTime = ref.read(taskTimeProvider);
                final userTime = ref.read(userTimeProvider);
                final transportTime = ref.read(transportTimeProvider);

                String idTaskDone = await ref
                    .read(addTaskDoneProvider)
                    .addTaskDone(TaskDone(
                        id: '',
                        title: taskTime!.title,
                        description: taskTime.description,
                        startTime: Timestamp.now(),
                        endTime: Timestamp.now(),
                        duration: 0,
                        user: userTime,
                        transport: transportTime,
                        delays: null));

                ref.read(taskDoneIdProvider.notifier).state = idTaskDone;
                // TE FALTA CONFIGURAR LAS DEMORAS

                // TODO: INICIO DE CRONOMETRO
                _stopWatchTimerMain.onStartTimer();

                setState(() {
                  isActive = true;
                });
              },
            ),
          ),
        if (isActive)
          Consumer(
            builder: (context, ref, child) => Column(
              children: [
                ControllerButtonWidget(
                  icon: Icons.alarm_add,
                  name: 'DEMORA',
                  color: Colors.red,
                  dark: true,
                  ontap: () async {
                    // TODO: APARECER DEMORAS

                    await showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          height: 400,
                          width: MediaQuery.of(context).size.width,
                          child: const Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Ingresa tarea',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Expanded(child: _ListDelays()),
                            ],
                          ),
                        );
                      },
                    );
                    // TODO: DETENER CRONOMETRO
                    _stopWatchTimerMain.onStopTimer();

                    // TODO: AGREAGAR UNA DEMORA
                    // ? title, description, id, startTime
                    final delayTime = ref.watch(delayTimeProvider);
                    final taskDoneId = ref.watch(taskDoneIdProvider);
                    ref.read(delayTimeIdProvider.notifier).state = await ref
                        .read(addDelayDoneProvider)
                        .addDelayDone(
                            DelayDone(
                                id: '',
                                title: delayTime?.title ?? '',
                                description: delayTime?.description ?? '',
                                duration: 0,
                                startTime: Timestamp.now(),
                                endTime: Timestamp.now()),
                            taskDoneId);

                    // TODO: INICIAR CRONOMETRO DE DEMORA
                    _stopWatchTimerDelay.onStartTimer();

                    // TODO: CAMBIAR EL BOTON
                    setState(() {
                      isDelay = true;
                      isActive = false;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ControllerButtonWidget(
                  icon: Icons.check,
                  name: 'TERMINAR',
                  color: Colors.green,
                  dark: true,
                  ontap: () {
                    // TODO: ASIGNAR LA HORA DE TERMINO
                    // ? endTIme, duration
                    final idTaskDone = ref.watch(taskDoneIdProvider);
                    ref
                        .read(updateTaskDoneProvider)
                        .updateTaskDone(idTaskDone, Timestamp.now());

                    // TODO: ACABAR TODO
                    _stopWatchTimerMain.onResetTimer();

                    // TODO: REDIRECCIONAR AL MENU
                    context.go('/operador');
                  },
                ),
              ],
            ),
          ),
        if (isDelay)
          Consumer(
            builder: (context, ref, child) => ControllerButtonWidget(
              icon: Icons.alarm_off_outlined,
              name: 'ACABAR',
              color: Colors.blue,
              dark: true,
              ontap: () {
                // TODO: DETENER CRONOMETRO DEMORA
                _stopWatchTimerDelay.onStopTimer();

                // TODO: AGREAGAR ATRIBUTOS A DEMORAS
                // ? endTIme, duration
                final idDelay = ref.watch(delayTimeIdProvider);
                final idTaskDone = ref.watch(taskDoneIdProvider);
                print(idTaskDone);
                ref
                    .read(updateDelayDoneProvider)
                    .updateDelayDone(Timestamp.now(), idDelay, idTaskDone);

                // TODO: CONTINUAR CRONOMETRO PRINCIPAL
                _stopWatchTimerDelay.onResetTimer();
                _stopWatchTimerMain.onStartTimer();

                // TODO: CAMBIAR EL BOTONES
                setState(() {
                  isDelay = false;
                  isActive = true;
                });
              },
            ),
          ),
      ],
    );
  }
}

class _ListDelays extends ConsumerWidget {
  const _ListDelays({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getDelyas = ref.watch(getDelaysProvider);
    return StreamBuilder<List<Delay>>(
      stream: getDelyas.getDelays(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No Users available.');
        } else {
          List<Delay> delays = snapshot.data!;
          // Build your UI using the tasks data
          return ListView.builder(
            itemCount: delays.length,
            itemBuilder: (context, index) {
              return Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                color:
                    Colors.red[100], // Theme.of(context).colorScheme.secondary,

                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    title: Text(delays[index].title),
                    // Add more UI components as needed
                    subtitle: Text(delays[index].description),
                    onTap: () {
                      ref.read(delayTimeProvider.notifier).state =
                          delays[index];
                      context.pop();
                    },
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
