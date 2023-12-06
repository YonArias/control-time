import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_control_app/presentation/providers/chronometer_provider.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  static const List colores = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.amber,
    Colors.pink,
    Colors.black,
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: Trata de poner un selector de vehiculo 
    return ListView.builder(
      
      itemCount: context.watch<ChronometerProvider>().laps.length, // provider
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListTile(
            title: Text('Tiempo numero ${index+1}', style: TextStyle(color: Colors.white),),
            subtitle: Text('Los segundo => ${context.watch<ChronometerProvider>().laps[index]}', // provider
            style: TextStyle(color: Colors.white),),
            contentPadding: const EdgeInsets.all(15),
            tileColor: colores[index%colores.length],
          ),
        );
      },
    );
  }
}
