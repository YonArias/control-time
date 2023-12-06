import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SelectMobilityScreen extends StatelessWidget {
  const SelectMobilityScreen({super.key});

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
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView.builder(
            itemCount:
                4, // TODO: Tener una modelo para vehiculos y cantidad de estos
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
                    Text('PLACA')
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
