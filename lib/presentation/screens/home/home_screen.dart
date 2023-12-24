import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:time_control_app/presentation/parameters.dart';
import 'package:time_control_app/presentation/providers/chronometer_provider.dart';
import 'package:time_control_app/presentation/providers/user_provider.dart';

// TODO: MEJORAR EL LLAMADO A LOS PROVIDER

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Comprobamos si esque es operador o no
    return Scaffold(
      body: GestureDetector(
        onTap: () async {
          final user = await ref.read(getUserProvider).getUser();
          ref.read(userTimeProvider.notifier).state = user;

          if (user!.rol == rol[0]) {
            context.go('/operador');
          } else {
            context.go('/supervisor');
          }
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            boxShadow: List.filled(10, const BoxShadow(color: Colors.white)),
          ),
          child: const Center(child: Text('REACCIONA PARA INGRESAR')),
        ),
      ),
    );
  }
}
