import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:time_control_app/domain/entities/transport.dart';
import 'package:time_control_app/domain/services/select_image.dart';
import 'package:time_control_app/presentation/providers/transport_provider.dart';
import 'package:time_control_app/presentation/widgets/custom_inputs/text_input.dart';
import 'package:time_control_app/presentation/widgets/custom_inputs/upload_image.dart';

class AddTransportView extends StatelessWidget {
  const AddTransportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transportes'),
        centerTitle: true,
      ),
      body: const _ListTransport(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _mySheet(context);
        },
      ),
    );
  }

  _mySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 800,
          width: MediaQuery.of(context).size.width,
          child: const Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                'Ingresa Transporte',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Expanded(child: _FormAddTransport()),
            ],
          ),
        );
      },
    );
  }
}

class _FormAddTransport extends StatefulWidget {
  const _FormAddTransport({super.key});

  @override
  State<_FormAddTransport> createState() => __FormAddTransportState();
}

class __FormAddTransportState extends State<_FormAddTransport> {
  final _formkey = GlobalKey<FormState>();

  // Controladores
  late TextEditingController nameController;
  late TextEditingController placaController;
  late TextEditingController descriptionController;
  late TextEditingController typeController;
  late TextEditingController cargaController;

  // Para capturar la imagen
  File? imagen_to_upload;

  @override
  void initState() {
    // TODO: implement initState
    placaController = TextEditingController(text: '');
    nameController = TextEditingController(text: '');
    typeController = TextEditingController(text: '');
    descriptionController = TextEditingController(text: '');
    cargaController = TextEditingController(text: '');
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    placaController.dispose();
    nameController.dispose();
    descriptionController.dispose();
    typeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Nombre
            TextInput(
              label: 'Nombre del transporte',
              icon: Icons.airport_shuttle_outlined,
              controller: nameController,
            ),
            const SizedBox(
              height: 10,
            ),
            TextInput(
              label: 'Tipo de transporte',
              icon: Icons.call_to_action_outlined,
              controller: typeController,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: TextInput(
                    label: 'Placa',
                    icon: Icons.call_to_action_outlined,
                    controller: placaController,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextInput(
                    label: 'Carga',
                    icon: Icons.local_shipping,
                    controller: cargaController,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextInput(
              label: 'Descripcion',
              icon: Icons.call_to_action_outlined,
              controller: descriptionController,
            ),
            const SizedBox(
              height: 10,
            ),
            // Subir imagen
            // ! No se esta guardando exactamente
            UploadImage(
              ontap: () async {
                final image = await getImage();

                setState(() {
                  imagen_to_upload = File(image!.path);
                });
                // TODO: Subir imagen al proyecto
              },
            ),
            const SizedBox(
              height: 10,
            ),

            _TransportButton(
              name: nameController,
              type: typeController,
              placa: placaController,
              carga: cargaController,
              description: descriptionController,
            ),
          ],
        ),
      ),
    );
  }
}

class _TransportButton extends ConsumerWidget {
  const _TransportButton({
    required this.name,
    required this.type,
    required this.placa,
    required this.carga,
    required this.description
  });

  final TextEditingController name;
  final TextEditingController type;
  final TextEditingController placa;
  final TextEditingController carga;
  final TextEditingController description;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addTransport = ref.read(addTransportProvider);

    return ElevatedButton(
      onPressed: () async {
        await addTransport.addTransport(Transport(
          id: '',
          name: name.text,
          type: type.text,
          placa: placa.text,
          carga: int.parse(carga.text),
          description: description.text,
          photoUrl: '',
          state: 'StateTransport.AVAILABLE',
          createDate: Timestamp.now(),
        ));
        context.pop();
      },
      child: const Text('Crear transporte'),
    );
  }
}

class _ListTransport extends ConsumerWidget {
  const _ListTransport({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Traer provider
    final getTransports = ref.watch(getTransportsProvider);
    return StreamBuilder(
      stream: getTransports.getTransports(),
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
              return Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                color:
                    Colors.red[100], // Theme.of(context).colorScheme.secondary,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    title: Text(transports[index].name),
                    // Add more UI components as needed
                    subtitle: Text(transports[index].placa),
                    onTap: () {
                      // ref.read(selectTask.notifier).state = tasks[index].id;
                    },
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete_forever,
                        size: 36,
                        color: Colors.red,
                      ),
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content:
                                Text('Seguro que desea eliminar este transporte?'),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  child: const Text('No')),
                              ElevatedButton(
                                  onPressed: () {
                                    ref
                                        .read(deleteTransportProvider)
                                        .deleteTransport(transports[index].id);
                                    context.pop();
                                  },
                                  child: const Text('Si'))
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
