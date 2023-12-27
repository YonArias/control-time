import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:time_control_app/domain/services/auth_service.dart';
import 'package:time_control_app/presentation/providers/user_provider.dart';
import 'package:time_control_app/presentation/screens/web/web_home_screen.dart';
import 'package:time_control_app/presentation/widgets/custom_inputs/text_input.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //! COREGIR ESTO
    final pantalla = MediaQuery.of(context).size.width;

    if (pantalla >= 1270.0) {
      return const WebHomeScreen();
    } else {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  // Image Logo
                  Image.asset(
                    'assets/image/logo-pormientras.png',
                    height: 300,
                  ),
                  const Text(
                    'Inicia session',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),

                  // ** Formulario **
                  const _FormLogin(),

                  const SizedBox(height: 20),

                  const Padding(
                    padding: EdgeInsets.all(50.0),
                    child: Text(
                        'Controla tus tiempos, no pierdas ningun segundo bro',
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}

class _FormLogin extends StatefulWidget {
  const _FormLogin({super.key});

  @override
  State<_FormLogin> createState() => __FormLoginState();
}

class __FormLoginState extends State<_FormLogin> {
  // Creando controladores del formulario
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController(text: '');
    passwordController = TextEditingController(text: '');
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        // Relleno de formulario

        TextInput(
          controller: emailController,
          label: 'Username',
          icon: Icons.person,
        ),
        const SizedBox(
          height: 10,
        ),
        TextInput(
          controller: passwordController,
          label: 'Password',
          icon: Icons.lock_clock_rounded,
          hive: true,
        ),

        const SizedBox(
          height: 20,
        ),

        _LoginAccess(
          email: emailController,
          password: passwordController,
        ),

        const SizedBox(
          height: 10,
        ),

        ElevatedButton(
            onPressed: () {
              context.go('/register');
            },
            child: const Text('Registrase')),
      ],
    ));
  }
}

class _LoginAccess extends ConsumerWidget {
  final TextEditingController email;
  final TextEditingController password;

  const _LoginAccess({super.key, required this.email, required this.password});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateUseActivity = ref.watch(updateUserActivityProvider);

    return ElevatedButton(
      onPressed: () async {
        final String? id = await loguearEmailAndPassword(email.text, password.text);

        if (id != null) {
          updateUseActivity.updateUserActivity(id, true);

          context.go('/home');
        }
      },
      child: const Text('ACCEDER'),
    );
  }
}
