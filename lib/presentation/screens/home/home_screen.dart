import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:time_control_app/presentation/views/views.dart';

// TODO: MEJORAR EL LLAMADO A LOS PROVIDER

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = [
    HistoryView(),
    RecordatorioView(),
  ];

  // Funcion para cambiar de index
  void _onItemTapped(int index) {
    print('$index');
    setState(() {
      _selectedIndex = index;
    });
  }

  // Acceso al usuario registrado
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // BottomNavigation
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
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
      
      // APPBAR
      appBar: AppBar(
        title: const Text('Probando el AppBar'),
        actions: [
          InkWell(
            child: CircleAvatar(
              backgroundImage: NetworkImage(user?.photoURL ?? ''),
            ),
            borderRadius: BorderRadius.circular(20),
            onTap: ()=>context.goNamed('profile'),
          ),
          SizedBox(width: 20,),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}