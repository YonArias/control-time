
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:time_control_app/presentation/views/views.dart';


class OperadorHomeScreen extends StatefulWidget {
  const OperadorHomeScreen({super.key});

  @override
  State<OperadorHomeScreen> createState() => _OperadorHomeScreenState();
}

class _OperadorHomeScreenState extends State<OperadorHomeScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = [
    HistoricalView(),
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
        selectedItemColor: Theme.of(context).colorScheme.primary,
      ),
      
      // APPBAR
      appBar: AppBar(
        title: const Text('Probando el AppBar'),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: ()=>context.goNamed('profile'),
            child: CircleAvatar(
              
            ),
          ),
          const SizedBox(width: 20,),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Probando alertas'),
                content: const Text('Todavia no hace nada este button'),
                actions: [
                  TextButton(
                    child: const Text('Aceptar'),
                    onPressed: () {
                      context.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}