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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: InkWell(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.primary,
                boxShadow: [
                  BoxShadow(
                  color: Theme.of(context).colorScheme.primary,
                    offset: const Offset(0.0,0.1),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              height: 70,
              child: Consumer(
                builder: (context, ref, child) {
                  final transportTime = ref.watch(transportTimeProvider);
          
                  if (transportTime != null) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.airport_shuttle, size: 36, color: Theme.of(context).colorScheme.surface,), // Imagen del vehiculo
                        
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${transportTime.name} ( ${transportTime.type} )', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.surface),), // Nombre del vehiculo
                            Text(transportTime.placa, style: TextStyle(color: Theme.of(context).colorScheme.surface,),) // Placa del vehiculo
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
                        const Icon(Icons.task_alt_outlined),
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
                            Text('${taskDone[index].endTime.toDate().difference(taskDone[index].startTime.toDate())}'),
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
