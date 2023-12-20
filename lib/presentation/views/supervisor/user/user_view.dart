import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_control_app/domain/entities/user.dart';
import 'package:time_control_app/presentation/providers/user_provider.dart';

class UserListWidget extends ConsumerWidget {
  const UserListWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final getUsers = ref.watch(getUsersProvider);
    
    return StreamBuilder<List<User>>(
      stream: getUsers.getUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No Users available.');
        } else {
          List<User> users = snapshot.data!;
          // Build your UI using the tasks data
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(users[index].name),
                // Add more UI components as needed
                trailing: Icon(
                  Icons.brightness_1,
                  color: users[index].isActive ? Colors.green : Colors.red,
                ),
              );
            },
          );
        }
      },
    );
  }
}
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// // TODO: TIENES QUE ORDENAR LAS LISTAS QUE SALEN DE LA BASE DE DATOS PORQUE SALE DESORDANO HASTA EL CULO

// class UserView extends StatefulWidget {
//   const UserView({super.key});

//   @override
//   State<UserView> createState() => _UserViewState();
// }

// class _UserViewState extends State<UserView> {
//   int totalTasks = 5;
//   int completedTasks = 0;

//   void updateProgress() {
//     setState(() {
//       completedTasks += 1;
//     });
//   }

//   final CollectionReference _collection =
//       FirebaseFirestore.instance.collection('times');

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _collection.snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         }

//         var documentos = snapshot.data!.docs;
//         List<Widget> items = [];

//         int i = 0;
//         for (var documento in documentos) {
//           var datos = documento.data() as Map<String, dynamic>;
//           items.add(
//             ListTile(
//               title: Text(
//                 'Tiempo numero ${i++}',
//                 style: TextStyle(color: Colors.white),
//               ),
//               subtitle: Text(
//                 'Los segundo => ${datos['time']}', // provider
//                 style: TextStyle(color: Colors.white),
//               ),
//               contentPadding: const EdgeInsets.all(15),
//               tileColor: Theme.of(context).colorScheme.primary,
//             ),
//           );
//         }

//         return ListView(
//           children: items,
//         );
//       },
//     );
//     // double progressPercentage = (completedTasks / totalTasks);
//     // return Column(
//     //   mainAxisAlignment: MainAxisAlignment.center,
//     //   children: <Widget>[
//     //     // Text(
//     //     //   'Progreso: ${progressPercentage * 100}%',
//     //     //   style: const TextStyle(fontSize: 20),
//     //     // ),
//     //     // const SizedBox(height: 20),
//     //     // LinearProgressIndicator(
//     //     //   value: progressPercentage,
//     //     // ),
//     //     // const SizedBox(height: 20),
//     //     // ElevatedButton(
//     //     //   onPressed: () {
//     //     //     // Simula la finalización de una tarea
//     //     //     updateProgress();
//     //     //   },
//     //     //   child: Text('Completar Tarea'),
//     //     // ),
//     //     _ListTimes(),
//     //   ],
//     // );
//   }
// }

// class _ListTimes extends StatefulWidget {
//   const _ListTimes();

//   @override
//   State<_ListTimes> createState() => _ListTimesState();
// }

// class _ListTimesState extends State<_ListTimes> {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   late CollectionReference registertimes;

//   @override
//   void initState() {
//     // TODO: implement initState
//     registertimes = firestore.collection('times');
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: registertimes.get(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           final documentos = snapshot.data!.docs;
//           return ListView.builder(
//             itemCount: documentos.length, // cantidad
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 child: ListTile(
//                   title: Text(
//                     'Tiempo numero ${index + 1}',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   subtitle: Text(
//                     'Los segundo => ${documentos[index]['time']}', // provider
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   contentPadding: const EdgeInsets.all(15),
//                   tileColor: Theme.of(context).colorScheme.primary,
//                 ),
//               );
//             },
//           );
//         }
//         return SizedBox();
//       },
//     );
//   }
// }
