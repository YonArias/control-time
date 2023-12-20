import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:time_control_app/domain/services/select_image.dart';
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
          height: 900,
          width: MediaQuery.of(context).size.width,
          child: const _FormAddTransport(),
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

  // Para capturar la imagen
  File? imagen_to_upload;

  @override
  void initState() {
    // TODO: implement initState
    placaController = TextEditingController(text: '');
    nameController = TextEditingController(text: '');
    typeController = TextEditingController(text: '');
    descriptionController = TextEditingController(text: '');
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
            child: Form(
          key: _formkey,
          child: Column(
            children: [
              // Title
              const SizedBox(
                height: 10,
              ),
              const Center(
                  child: Text(
                'CREAR TRANSPORTE',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
              const SizedBox(
                height: 10,
              ),

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
              TextInput(
                label: 'Placa',
                icon: Icons.call_to_action_outlined,
                controller: placaController,
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

              ElevatedButton(
                onPressed: () {
                  // Crear el transporte
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Crear Transporte'),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class _ListTransport extends StatefulWidget {
  const _ListTransport({super.key});

  @override
  State<_ListTransport> createState() => __ListTransportState();
}

class __ListTransportState extends State<_ListTransport> {
  @override
  Widget build(BuildContext context) {
    final CollectionReference _collection =
        FirebaseFirestore.instance.collection('transport');
    return StreamBuilder(
      stream: _collection.snapshots(),
      builder: (context, snapshot) {
        // Verificamos la coneccion de data
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        var documentos = snapshot.data!.docs;
        List<Widget> items = [];

        for (var documento in documentos) {
          var datos = documento.data() as Map<String, dynamic>;

          // Agregamos items
          items.add(
            InkWell(
              onTap: () {
                print('APretando tiles');
              },
              child: ListTile(
                title: Text(
                  '${datos['name']}',
                ),
                subtitle: Text(
                  '${datos['placa']}', // provider
                ),
                trailing: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.red,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.delete_forever_outlined,
                            color: Colors.white),
                        onPressed: () {
                          print('Delete');
                        },
                      )),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                tileColor: Colors.grey[200],
              ),
            ),
          );
        }

        // Visualizaremos los items
        return ListView(
          children: items,
        );
      },
    );
  }
}
