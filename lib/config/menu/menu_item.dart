import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  const MenuItem(
      {required this.title,
      required this.subTitle,
      required this.link,
      required this.icon});
}

// WEB
const appMenuItems = <MenuItem>[
  MenuItem(
    title: 'Operadores',
    subTitle: 'Lista de operadores',
    link: '/listOperadores',
    icon: Icons.people,
  ),
  MenuItem(
    title: 'Operadores',
    subTitle: 'Estadistica de operadores',
    link: '/webOperadores',
    icon: Icons.people,
  ),

  MenuItem(
    title: 'Demoras',
    subTitle: 'Estadistica de demoras',
    link: '/webDemoras',
    icon: Icons.alarm_add,
  ),

  MenuItem(
    title: 'Transportes',
    subTitle: 'Estadistica de transportes',
    link: '/webTransportes',
    icon: Icons.airport_shuttle,
  ),

  MenuItem(
    title: 'Tareas hechas',
    subTitle: 'Estadistica de tareas hechas',
    link: '/webTareasHechas',
    icon: Icons.view_agenda,
  ),
];
