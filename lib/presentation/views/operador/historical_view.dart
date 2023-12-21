import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:time_control_app/domain/entities/task.dart';
import 'package:time_control_app/presentation/providers/task_provider.dart';
import 'package:time_control_app/presentation/providers/user_provider.dart';

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
            child: Row(
              children: [
                Image.asset(
                    'assets/image/logo-pormientras.png'), // TODO: cambiar la imagen segun lo escogido

                Text('ZOT-576'),
              ],
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
    final userId = ref.watch(idUser);

    return StreamBuilder(
        stream: getTaskDone.getTaskDoneUser(userId!), builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No Users available.');
        } else {
          List<TaskDone> taskDone = snapshot.data!;
          // Build your UI using the tasks data
          return ListView.builder(
            itemCount: taskDone.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(taskDone[index].title, style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                      Column(
                        children: [
                          Text('${taskDone[index].startTime.toDate().hour}:${taskDone[index].startTime.toDate().minute}:${taskDone[index].startTime.toDate().second}'),
                          Text('${taskDone[index].endTime.toDate().hour}:${taskDone[index].endTime.toDate().minute}:${taskDone[index].endTime.toDate().second}'),
                          
                        ],
                      )
                    ],
                  ),
                )
              );
            },
          );
        }
        },);
  }
}