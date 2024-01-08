import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_control_app/domain/entities/task.dart';
import 'package:time_control_app/domain/entities/user.dart';
import 'package:time_control_app/presentation/providers/task_provider.dart';
import 'package:time_control_app/presentation/providers/user_provider.dart';

class HistoricalSupervisorView extends ConsumerWidget {
  const HistoricalSupervisorView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(getUsersOperarioProvider).getUsersOperario();
    final taskDone = ref.watch(getTasksDoneProvider);
    // Obtenemos los usuarios
    return StreamBuilder(
      stream: users,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No Users available.');
        } else {
          List<User> usersOperario = snapshot.data!;

          return ListView.builder(
            itemCount: usersOperario.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                       Text(usersOperario[index].name, style: const  TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),),
                      const SizedBox(height: 10,),
                      // Obtenemos las tareas hechas por usuario
                      StreamBuilder(
                          stream: taskDone.getTasksDone(DateTime.now()),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }else {
                              List<TaskDone> tasksDone = snapshot.data ?? [];
                              int count = 0;
                              
                              for (var task in tasksDone) {
                                if (usersOperario[index].id == task.user!.id) {
                                  count++;
                                }
                              }
                              // Obtenemos el total de tareas creadas
                              return StreamBuilder(
                                  stream: ref.watch(getTasksProvider).getTasks(),
                                  builder: (context, snapshot) {
                                    int? valor = snapshot.data?.length;
                                    double sized = MediaQuery.of(context).size.width;
                                    return Stack(
                                      children: [
                                        SizedBox(
                                          height: 30,
                                          width: sized-100,
                                          child: LinearProgressIndicator(
                                            borderRadius: BorderRadius.circular(10),
                                            value: count / (valor ?? 1),
                                          ),
                                        ),
                                        Positioned(
                                            top: 2,
                                            left: (sized-120)/2,
                                            child: Text('$count / ${(valor ?? 1)}',
                                                style: TextStyle(
                                                    color: (valor ?? 1) / count < 2
                                                        ? Colors.white
                                                        : Colors.black))),
                                      ],
                                    );
                                  });
                            }
                          }),
                    ],
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
