import 'package:flutter/material.dart';

class AddTaskView extends StatelessWidget {
  const AddTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de tareas'),
      ),
      body: Text('data'),
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
          height: 400,
          width: MediaQuery.of(context).size.width,
          child: const Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                'Ingresa tarea',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(child: Text('adas'))
            ],
          ),
        );
      },
    );
  }
}

// class _ListTask extends StatelessWidget {
//   const _ListTask({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Traer provider
//     // final getDelays = ref.watch(getDelaysProvider);
//     return StreamBuilder(
//       stream: getDelays.getDelays(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Text('No Users available.');
//         } else {
//           List<Delay> delays = snapshot.data!;
//           // Build your UI using the tasks data
//           return ListView.builder(
//             itemCount: delays.length,
//             itemBuilder: (context, index) {
//               return Card(
//                 margin:
//                     const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                 color:
//                     Colors.red[100], // Theme.of(context).colorScheme.secondary,
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: ListTile(
//                     title: Text(delays[index].title),
//                     // Add more UI components as needed
//                     subtitle: Text(delays[index].description),
//                     onTap: () {
//                       // ref.read(selectTask.notifier).state = tasks[index].id;
//                     },
//                     trailing: IconButton(
//                       icon: const Icon(
//                         Icons.delete_forever,
//                         size: 36,
//                         color: Colors.red,
//                       ),
//                       onPressed: () async {
//                         showDialog(
//                           context: context,
//                           builder: (context) => AlertDialog(
//                             content:
//                                 Text('Seguro que desea eliminar esta demora?'),
//                             actions: [
//                               ElevatedButton(
//                                   onPressed: () {
//                                     context.pop();
//                                   },
//                                   child: const Text('No')),
//                               ElevatedButton(
//                                   onPressed: () {
//                                     ref
//                                         .read(deleteDelayProvider)
//                                         .deleteDelay(delays[index].id);
//                                     context.pop();
//                                   },
//                                   child: const Text('Si'))
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         }
//       },
//     );
//   }
// }