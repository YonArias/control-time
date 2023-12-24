import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:time_control_app/domain/entities/transport.dart';
import 'package:time_control_app/presentation/providers/chronometer_provider.dart';
import 'package:time_control_app/presentation/providers/transport_provider.dart';

class SelectMobilityScreen extends StatelessWidget {
  const SelectMobilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        // APPBAR
        appBar: AppBar(
          title: const Text('Selecciona un vehiculo'),
        ),
        // BODY DE LA APLICACION
        body: const _ListTransportFree(),
      ),
    );
  }
}

class _ListTransportFree extends ConsumerWidget {
  const _ListTransportFree();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getTransportFree = ref.watch(getTransportsFreeProvider);

    return StreamBuilder(
      stream: getTransportFree.getTransportsFree(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No Users available.');
        } else {
          List<Transport> transports = snapshot.data!;
          // Build your UI using the tasks data
          return ListView.builder(
            itemCount: transports.length,
            itemBuilder: (context, index) {
              return InkWell(
                child: Card(
                  color: Colors.red[400],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    child: ListTile(
                      title: Text(
                        transports[index].name,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        transports[index].placa, // provider
                        style: const TextStyle(color: Colors.white),
                      ),
                      leading: const Icon(
                        Icons.airport_shuttle,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  // TODO: Seleccione el vehiculo al usuario
                  ref.read(transportTimeProvider.notifier).state =
                      transports[index];
                  // Redireccionamos a la pantalla OperarioHome
                  context.go('/operador');
                },
              );
            },
          );
        }
      },
    );
  }
}
