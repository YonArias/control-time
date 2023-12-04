import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(
      //   child: ListView.builder(
      //     itemCount: context.watch<ChronometerProvider>().laps.length,
      //     itemBuilder: (context, index) {
      //       return ListTile(
      //         title: Text('Tiempo ${index+1}'),
      //         subtitle: Text('Segundos: ${context.watch<ChronometerProvider>().laps[index]}'),
      //       );
      //     },
      //   ),
      // ),
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
      appBar: AppBar(
        title: const Text('Control TIME'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}

// Center(
          //   // Haciendo uso del provider
          //   child: Text('${context.watch<CounterProvider>().counter}')
          // ),

          // ElevatedButton(
          //   onPressed: ()=>context.read<CounterProvider>().increment(),
          //   child: const Text('Aumentar contador'),
          // ),

          // ElevatedButton(
          //   onPressed: ()=>context.read<CounterProvider>().disminuye(),
          //   child: const Text('Reducir contador'))