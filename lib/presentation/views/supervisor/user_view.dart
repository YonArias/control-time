import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('user');

  int totalTasks = 5;
  int completedTasks = 0;

  void updateProgress() {
    setState(() {
      completedTasks += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return StreamBuilder(
    //   stream: _collection.snapshots(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const CircularProgressIndicator();
    //     }

    //     if (snapshot.hasError) {
    //       return Text('Error: ${snapshot.error}');
    //     }

    //     var documentos = snapshot.data!.docs;
    //     List<Widget> items = [];

    //     for (var documento in documentos) {
    //       var datos = documento.data() as Map<String, dynamic>;
    //       items.add(ListTile(
    //         title: Text(datos['name']),
    //         subtitle: Text(datos['gmail']),
    //       ));
    //     }

    //     return ListView(
    //       children: items,
    //     );
    //   },
    // );
    double progressPercentage = (completedTasks / totalTasks);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Progreso: ${progressPercentage * 100}%',
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 20),
        LinearProgressIndicator(
          value: progressPercentage,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Simula la finalización de una tarea
            updateProgress();
          },
          child: Text('Completar Tarea'),
        ),
      ],
    );
  }
}
