import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:time_control_app/domain/entities/task.dart';
import 'package:time_control_app/presentation/providers/chronometer_provider.dart';
import 'package:time_control_app/presentation/providers/task_provider.dart';
import 'package:time_control_app/presentation/views/views.dart';

class OperadorHomeScreen extends StatefulWidget {
  const OperadorHomeScreen({super.key});

  @override
  State<OperadorHomeScreen> createState() => _OperadorHomeScreenState();
}

class _OperadorHomeScreenState extends State<OperadorHomeScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = [
    // Principal
    HistoricalView(),
    RecordatorioView(),
  ];

  // Funcion para cambiar de index
  void _onItemTapped(int index) {
    print('$index');
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // BottomNavigation
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: 'Historical',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.all_inclusive),
            label: 'Proximamente',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).colorScheme.primary,
      ),

      // APPBAR
      appBar: AppBar(
        title: const Text('Probando el AppBar'),
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
      body: _widgetOptions.elementAt(_selectedIndex),

      // ** Boton de agregar tareas
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mySheet(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  _mySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 900,
          width: MediaQuery.of(context).size.width,
          child: Consumer(
            builder: (context, ref, child) {
              final transportTime = ref.watch(transportTimeProvider);
              if (transportTime == null) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.block_outlined, size: 92),
                      SizedBox(height: 20,),
                      Text(
                        'SELECCIONE UN VEHICULO PRIMERO',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, ),
                      ),
                    ],
                  )
                );
              }
              return const Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Tareas',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(child: _ListTaskWidget())
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class _ListTaskWidget extends ConsumerWidget {
  const _ListTaskWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getTasks = ref.watch(getTasksProvider);

    return StreamBuilder<List<Task>>(
      stream: getTasks.getTasks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No Users available.');
        } else {
          List<Task> tasks = snapshot.data!;
          // Build your UI using the tasks data
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                color:
                    Colors.red[300], // Theme.of(context).colorScheme.secondary,

                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    leading: const Icon(Icons.task),
                    title: Text(tasks[index].title, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    // Add more UI components as needed
                    subtitle: Text(tasks[index].description),
                    onTap: () async {
                      ref.read(taskTimeProvider.notifier).state = tasks[index];

                      context.push('/operador/controlTime');
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
