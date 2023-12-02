import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_control_app/presentation/providers/chronometer_provider.dart';

// TODO: MEJORAR EL LLAMADO A LOS PROVIDER

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView.builder(
          itemCount: context.watch<ChronometerProvider>().laps.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Tiempo ${index+1}'),
              subtitle: Text('Segundos: ${context.watch<ChronometerProvider>().laps[index]}'),
            );
          },
        ),
      ),
      appBar: AppBar(
        title: const Text('Control TIME'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Muestra la hora que transcurre
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Text(
              context.select(
                  (ChronometerProvider chronometer) => chronometer.time),
              style: const TextStyle(fontSize: 42, color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 30,
          ),

          // Button de accion
          _ControlTime()
        ],
      ),
    );
  }
}

class _ControlTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // TODO: PROBABLEMENTE SE UNA A UN SOLO BOTON EL START Y STOP
        IconButton(
          icon: const Icon(
            Icons.play_circle_outlined,
            size: 42,
          ),
          onPressed: () {
            // Inicia el tiempo
            context.read<ChronometerProvider>().startStopTimer();
          },
        ),
        const SizedBox(
          width: 20,
        ),
        IconButton(
          icon: const Icon(
            Icons.alarm_add_outlined,
            size: 42,
          ),
          onPressed: () {
            // Para el tiempo
            context.read<ChronometerProvider>().startStopTimer();
          },
        ),
        const SizedBox(
          width: 20,
        ),
        IconButton(
          icon: const Icon(
            Icons.stop_circle_outlined,
            size: 42,
          ),
          onPressed: () {
            context.read<ChronometerProvider>().restart();
          },
        ),
      ],
    );
  }
}

// Center(
          //   // Haciendo uso del provider
          //   child: Text('${context.watch<CounterProvider>().counter}')
          // ),

          // ElevatedButton(
          //   onPressed: ()=>context.read<CounterProvider>().increment(),
          //   child: const Text('Aumentar contador'),
          // ),

          // ElevatedButton(
          //   onPressed: ()=>context.read<CounterProvider>().disminuye(),
          //   child: const Text('Reducir contador'))