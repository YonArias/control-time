import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:time_control_app/domain/entities/delay.dart';
import 'package:time_control_app/presentation/providers/delay_provider.dart';
import 'package:time_control_app/presentation/widgets/custom_inputs/text_input.dart';

class AddDelayView extends StatelessWidget {
  const AddDelayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demoras'),
      ),
      body: const _ListDelays(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mySheet(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  _mySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 400,
          width: MediaQuery.of(context).size.width,
          child: const Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                'Ingresa demora',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(child: _FormDelay())
            ],
          ),
        );
      },
    );
  }
}

class _FormDelay extends StatefulWidget {
  const _FormDelay({super.key});

  @override
  State<_FormDelay> createState() => __FormDelayState();
}

class __FormDelayState extends State<_FormDelay> {
  final _formkey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    nameController = TextEditingController(text: '');
    descriptionController = TextEditingController(text: '');
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextInput(
              label: 'Titulo de la demora',
              icon: Icons.schedule,
              controller: nameController,
            ),
            const SizedBox(
              height: 10,
            ),
            TextInput(
              label: 'Descripcion breve',
              icon: Icons.description,
              controller: descriptionController,
            ),
            const SizedBox(
              height: 30,
            ),
            _DelayButton(
                title: nameController, description: descriptionController),
          ],
        ),
      ),
    );
  }
}

class _DelayButton extends ConsumerWidget {
  const _DelayButton({required this.title, required this.description});

  final TextEditingController title;
  final TextEditingController description;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addDelay = ref.read(addDelayProvider);

    return ElevatedButton(
      onPressed: () async {
        await addDelay.addDelay(Delay(
          id: '',
          title: title.text,
          description: description.text,
          createDate: Timestamp.now(),
        ));
        context.pop();
      },
      child: const Text('Crear demora'),
    );
  }
}

class _ListDelays extends ConsumerWidget {
  const _ListDelays();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Traer provider
    final getDelays = ref.watch(getDelaysProvider);
    return StreamBuilder(
      stream: getDelays.getDelays(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No Users available.');
        } else {
          List<Delay> delays = snapshot.data!;
          // Build your UI using the tasks data
          return ListView.builder(
            itemCount: delays.length,
            itemBuilder: (context, index) {
              return Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                color:
                    Colors.red[100], // Theme.of(context).colorScheme.secondary,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    title: Text(delays[index].title),
                    // Add more UI components as needed
                    subtitle: Text(delays[index].description),
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
                                Text('Seguro que desea eliminar esta demora?'),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  child: const Text('No')),
                              ElevatedButton(
                                  onPressed: () {
                                    ref
                                        .read(deleteDelayProvider)
                                        .deleteDelay(delays[index].id);
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
