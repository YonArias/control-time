import 'package:flutter/material.dart';
import 'package:time_control_app/presentation/widgets/custom_tiles/tile_select.dart';

class AddResourcesView extends StatelessWidget {
  const AddResourcesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        children: const [
          TileSelected(
            icon: Icons.airport_shuttle_rounded, 
            title: 'Agregar transporte', 
            url: '/supervisor/addTransport',
            color: Colors.red,
          ),
          Divider(),
          TileSelected(
            icon: Icons.task_alt_sharp, 
            title: 'Agregar tareas', 
            url: '/supervisor/addTask',
            color: Colors.blue,
          ),
          Divider(),
        ],
      ),
    );
  }
}