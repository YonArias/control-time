import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:time_control_app/presentation/providers/chronometer_provider.dart';

class HistoricalView extends StatelessWidget {
  const HistoricalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
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
        Expanded(
          child: ListView.builder(
            itemCount: context.watch<ChronometerProvider>().laps.length, // provider
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ListTile(
                  title: Text('Tiempo numero ${index+1}', style: TextStyle(color: Colors.white),),
                  subtitle: Text('Los segundo => ${context.watch<ChronometerProvider>().laps[index]}', // provider
                  style: TextStyle(color: Colors.white),),
                  contentPadding: const EdgeInsets.all(15),
                  tileColor: Theme.of(context).colorScheme.primary,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
