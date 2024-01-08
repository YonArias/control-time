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

          if (user!.rol == ROL[0]) {
            context.go('/operador');
          } else if (user.rol == ROL[1]) {
            context.go('/supervisor');
          } else if ( user.rol == ROL[2]){
            context.go('/admin');
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            boxShadow: List.filled(10, const BoxShadow(color: Colors.white)),
            color: Theme.of(context).colorScheme.background
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Icon(Icons.privacy_tip_outlined, size: 60),
            SizedBox(height: 10,),
            Text('¡Importante mensaje de seguridad!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10,),
            Text('La seguridad vial es nuestra prioridad. Por favor, evita usar tu teléfono mientras conduces. Mantén tu atención en el camino y sé un conductor responsable.', textAlign: TextAlign.center,),
            ]
          ),
        ),
      ),
    );
  }
}
