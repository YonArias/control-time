import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:time_control_app/domain/services/auth_service.dart';
import 'package:time_control_app/domain/services/firebase_service.dart';
import 'package:time_control_app/presentation/providers/user_provider.dart';

// TODO: MEJORAR EL LLAMADO A LOS PROVIDER

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            ref.read(idUser.notifier).state = await getId();

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
