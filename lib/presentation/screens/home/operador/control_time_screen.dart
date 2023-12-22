import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:time_control_app/domain/entities/task.dart';
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
        child: const Column(
          children: [
            _TitleTask(),

            SizedBox(
              height: 100,
            ),
            // Pantalla o animacion
            Card(
              margin: EdgeInsets.symmetric(horizontal: 80),
              child: Center(
                  child: Text(
                '00:00:00',
                style: TextStyle(fontSize: 36),
              )),
            ),

            _ControllerButtons(),
          ],
        ),
      ),
    );
  }
}

class _TitleTask extends ConsumerWidget {
  const _TitleTask();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idTask = ref.watch(selectTask);
    final getTask = ref.watch(getTaskProvider).getTask(idTask);

    return FutureBuilder(
      future: getTask,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Text('No data available.');
        } else {
          Task task = snapshot.data!;
          // Ahora puedes acceder a los atributos de la tarea
          return Card(
            child: ListTile(
              title: Center(child: Text(task.title)),
            ),
          );
        }
      },
    );
  }
}

class _ControllerButtons extends StatefulWidget {
  const _ControllerButtons({super.key});

  @override
  State<_ControllerButtons> createState() => __ControllerButtonsState();
}

class __ControllerButtonsState extends State<_ControllerButtons> {
  bool isActive = false;
  bool isDelay = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        // Botones controlador

        if (!isActive && !isDelay)
          ControllerButtonWidget(
            icon: Icons.play_arrow,
            name: 'INICIAR',
            color: Colors.blue,
            dark: true,
            ontap: () {
              // TODO: CREAR LA TAREA
              // ? title, description, id, idTransport, idUser, startTime

              // TODO: INICIO DE CRONOMETRO
              setState(() {
                isActive = true;
              });
            },
          ),
        if (isActive)
          Column(
            children: [
              ControllerButtonWidget(
                icon: Icons.alarm_add,
                name: 'DEMORA',
                color: Colors.red,
                dark: true,
                ontap: () {
                  // TODO: DETENER CRONOMETRO

                  // TODO: APARECER DEMORAS

                  // TODO: AGREAGAR UNA DEMORA
                  // ? title, description, id, startTime

                  // TODO: INICIAR CRONOMETRO DE DEMORA

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

                  // TODO: ACABAR TODO

                  // TODO: REDIRECCIONAR AL MENU
                  context.go('/operador');
                },
              ),
            ],
          ),
        if (isDelay)
          ControllerButtonWidget(
            icon: Icons.alarm_off_outlined,
            name: 'ACABAR',
            color: Colors.blue,
            dark: true,
            ontap: () {
              // TODO: DETENER CRONOMETRO DEMORA

              // TODO: AGREAGAR ATRIBUTOS A DEMORAS
              // ? endTIme, duration

              // TODO: CONTINUAR CRONOMETRO PRINCIPAL

              // TODO: CAMBIAR EL BOTONES
              setState(() {
                isDelay = false;
                isActive = true;
              });
            },
          ),
      ],
    );
  }
}
