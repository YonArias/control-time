import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:time_control_app/domain/services/firebase_service.dart';

// TODO: MEJORAR EL LLAMADO A LOS PROVIDER

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Comprobamos si esque es operador o no
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          boxShadow: List.filled(10, const BoxShadow(color: Colors.black)),
        ),
        child: GestureDetector(
          onTap: () async {
            final user = FirebaseAuth.instance.currentUser;

            if (await isOperador(user!.email)) {
              context.go('/operador');
            } else {
              context.go('/supervisor');
            }
          },
        ),
      ),
    );
  }
}
