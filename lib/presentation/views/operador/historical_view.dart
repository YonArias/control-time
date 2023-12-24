import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:time_control_app/domain/entities/task.dart';
import 'package:time_control_app/presentation/providers/chronometer_provider.dart';
import 'package:time_control_app/presentation/providers/task_provider.dart';

class HistoricalView extends StatelessWidget {
  const HistoricalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          child: Container(
            color: Theme.of(context).colorScheme.inversePrimary,
            height: 70,
            child: Consumer(
              builder: (context, ref, child) {
                final transportTime = ref.watch(transportTimeProvider);

                if (transportTime != null) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(Icons.airport_shuttle, size: 28,), // Imagen del vehiculo
                      
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${transportTime.name} ( ${transportTime.type} )' ), // Nombre del vehiculo
                          Text(transportTime.placa) // Placa del vehiculo
                        ],
                      )
                    ],
                  );
                }
                return const Center(
                  child: Text('SELECCIONE UN VEHICULO', style: TextStyle(fontWeight: FontWeight.bold),),
                );
              },
            ),
          ),
          onTap: () => context.push('/home/selectVehicle'),
        ),

        // Lista
        const Expanded(
          child: _ListTimes(),
        ),
      ],
    );
  }
}

class _ListTimes extends ConsumerWidget {
  const _ListTimes();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getTaskDone = ref.watch(getTaskDoneUserProvider);
    final user = ref.watch(userTimeProvider);

    return StreamBuilder(
      stream: getTaskDone.getTaskDoneUser(user),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Icon(Icons.auto_awesome_mosaic);
        } else {
          List<TaskDone> taskDone = snapshot.data!;
          // Build your UI using the tasks data
          return ListView.builder(
            itemCount: taskDone.length,
            itemBuilder: (context, index) {
              return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              taskDone[index].title,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                                '${taskDone[index].startTime.toDate().hour}:${taskDone[index].startTime.toDate().minute}:${taskDone[index].startTime.toDate().second}'),
                            Text(
                                '${taskDone[index].endTime.toDate().hour}:${taskDone[index].endTime.toDate().minute}:${taskDone[index].endTime.toDate().second}'),
                          ],
                        )
                      ],
                    ),
                  ));
            },
          );
        }
      },
    );
  }
}
