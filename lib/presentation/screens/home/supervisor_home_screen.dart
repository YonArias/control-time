import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:time_control_app/config/router/app_router.dart';
import 'package:time_control_app/presentation/views/supervisor/user_view.dart';

class SupervisorHomeScreen extends StatefulWidget {
  const SupervisorHomeScreen({super.key});

  @override
  State<SupervisorHomeScreen> createState() => _SupervisorHomeScreenState();
}

class _SupervisorHomeScreenState extends State<SupervisorHomeScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = [
    UserView(),
    UserView(),
  ];

  // Funcion para cambiar de index
  void _onItemTapped(int index) {
    print('$index');
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // BottomNavigation
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: 'Historical',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm_add),
            label: 'Time',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.amber,
      ),
      appBar: AppBar(
        title: const Text('Probando el AppBar'),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: ()=>context.goNamed('profile'),
            child: CircleAvatar(
              backgroundImage: NetworkImage(user?.photoURL ?? ''),
            ),
          ),
          const SizedBox(width: 20,),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}