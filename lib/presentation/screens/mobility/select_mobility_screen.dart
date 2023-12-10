import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:time_control_app/presentation/providers/transport_provider.dart';

class SelectMobilityScreen extends StatefulWidget {
  const SelectMobilityScreen({super.key});

  @override
  State<SelectMobilityScreen> createState() => _SelectMobilityScreenState();
}

class _SelectMobilityScreenState extends State<SelectMobilityScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () => context.goNamed('home'),
          ),
          title: const Text('Selecciona un vehiculo'),
          actions: [
            IconButton(onPressed: (){
              setState(() {
              });
            }, icon: Icon(Icons.refresh_outlined))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView.builder(
            itemCount: context.watch<TransportProvider>().tranports.length,
             // TODO: Tener una modelo para vehiculos y cantidad de estos
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  // TODO: AGREGAR ESTE PRODUCTO AL PROVIDER

                  context.goNamed('home');
                },
                child: Row(
                  children: [
                    Image.asset('assets/image/logo-pormientras.png',
                        width: 100), // TODO: cambiar a su imagen respectivo
                    Column(
                      children: [
                        Text(context.watch<TransportProvider>().tranports[index].name),
                        Text(context.watch<TransportProvider>().tranports[index].placa)
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
