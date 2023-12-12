import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_control_app/presentation/providers/user_provider.dart';
import 'package:time_control_app/presentation/screens/home/operador_home_screen.dart';
import 'package:time_control_app/presentation/screens/home/supervisor_home_screen.dart';

// TODO: MEJORAR EL LLAMADO A LOS PROVIDER

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final userProvider = context.watch<UserProvider>();

    if (userProvider.isOperador(auth.currentUser!.email)) {
      return OperadorHomeScreen();
    }
    return SupervisorHomeScreen();
  }
}
