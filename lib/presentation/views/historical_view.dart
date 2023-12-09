import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HistoricalView extends StatelessWidget {
  const HistoricalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).colorScheme.inversePrimary,
          height: 70,
          child: Row(
            children: [
              Image.asset(
                  'assets/image/logo-pormientras.png'), // TODO: cambiar la imagen segun lo escogido

              InkWell(
                child: const Text('ZOT-576'),
                onTap: () => context.goNamed('selectVehicle'),
              ),
            ],
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

class _ListTimes extends StatefulWidget {
  const _ListTimes();

  @override
  State<_ListTimes> createState() => _ListTimesState();
}

class _ListTimesState extends State<_ListTimes> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference registertimes;

  @override
  void initState() {
    // TODO: implement initState
    registertimes = firestore.collection('times');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: registertimes.get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final documentos = snapshot.data!.docs;
          return ListView.builder(
            itemCount: documentos.length, // cantidad
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ListTile(
                  title: Text(
                    'Tiempo numero ${index + 1}',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Los segundo => ${documentos[index]['time']}', // provider
                    style: TextStyle(color: Colors.white),
                  ),
                  contentPadding: const EdgeInsets.all(15),
                  tileColor: Theme.of(context).colorScheme.primary,
                ),
              );
            },
          );
        }
        return SizedBox();
      },
    );
  }
}
