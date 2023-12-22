import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:time_control_app/domain/services/auth_service.dart';
import 'package:time_control_app/domain/services/firebase_service.dart';
import 'package:time_control_app/presentation/providers/user_provider.dart';

class ProfileUserScreen extends StatelessWidget {
  const ProfileUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      // appBar: AppBar(),
      body: Column(
        children: [
          // Flecha para retroceder
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.bottomLeft,
            width: MediaQuery.sizeOf(context).width,
            height: 80,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
              onPressed: () async {
                if (await isOperador(user!.email)) {
                  context.push('/operador');
                } else {
                  context.go('/supervisor');
                }
              },
            ),
          ),
          
          Card(
            child: Container(
              width: MediaQuery.of(context).size.width-50,
              height: MediaQuery.of(context).size.width-50,
              padding: const EdgeInsets.all(150.0),
              child: const CircularProgressIndicator()
            ),
          ),
          const SizedBox(height: 10,),

          Text(user!.email ?? '', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),

          const SizedBox(height: 20,),

          const _LogoutButton(),
        ],
      ),
    );
  }
}

class _LogoutButton extends ConsumerWidget {
  const _LogoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Acceso al usuario registrado

    final updateUseActivity = ref.watch(updateUserActivityProvider);

    return ElevatedButton(
      onPressed: () async {
        String? id = await logoutUser();

        updateUseActivity.updateUserActivity(id!, false);
        context.goNamed('main');
      },
      child: const Text('Logout'),
    );
  }
}
