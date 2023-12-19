import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:time_control_app/domain/services/firebase_service.dart';

class SelectMobilityScreen extends StatefulWidget {
  const SelectMobilityScreen({super.key});

  @override
  State<SelectMobilityScreen> createState() => _SelectMobilityScreenState();
}

class _SelectMobilityScreenState extends State<SelectMobilityScreen> {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('transport');
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        // APPBAR
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              if (await isOperador(user!.email)) {
                context.go('/operador');
              } else {
                context.go('/supervisor');
              }
            },
          ),
          title: const Text('Selecciona un vehiculo'),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: const Icon(Icons.refresh_outlined))
          ],
        ),
        // BODY DE LA APLICACION
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: StreamBuilder(
            stream: _collection.snapshots(),
            builder: (context, snapshot) {
              // Verificar si se cargo los datos
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              // Adquirir cada documento
              var documentos = snapshot.data!.docs;
              List<Widget> items = [];

              for (var documento in documentos) {
                var datos = documento.data() as Map<String, dynamic>;
                if (!datos['active']) {
                  items.add(
                    // El widget por elemento
                    InkWell(
                      child: ListTile(
                        title: Text(
                          '${datos['name']}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          '${datos['placa']}', // provider
                          style: const TextStyle(color: Colors.white),
                        ),
                        contentPadding: const EdgeInsets.all(15),
                        tileColor: Theme.of(context).colorScheme.primary,
                      ),
                      onTap: () {
                        // TODO: Seleccione el vehiculo al usuario

                        // Redireccionamos a la pantalla OperarioHome
                        context.go('/operador');
                      },
                    ),
                  );
                }
              }
              return Center(
                child: ListView(
                  children: items,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
