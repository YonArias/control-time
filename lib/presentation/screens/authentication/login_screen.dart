import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:time_control_app/domain/services/auth_service.dart';
import 'package:time_control_app/presentation/providers/user_provider.dart';
import 'package:time_control_app/presentation/widgets/custom_inputs/text_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    //! COREGIR ESTO
    final pantalla = MediaQuery.of(context).size.width;

      return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  width: pantalla <= 450 ? pantalla : 450,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
          ),
      );
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
  final _formkey = GlobalKey<FormState>();

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
      key: _formkey,
        child: Column(
      children: [
        // Relleno de formulario

        TextInput(
          controller: emailController,
          label: 'Correo',
          icon: Icons.person,
          validator: 'Ingrese su correo',
        ),
        const SizedBox(
          height: 10,
        ),
        TextInput(
          controller: passwordController,
          label: 'Contraseña',
          icon: Icons.lock_clock_rounded,
          hive: true,
          validator: 'Ingrese su contraseña',
        ),

        const SizedBox(
          height: 20,
        ),

        Consumer(
          builder: (context, ref, child) {
            final updateUseActivity = ref.watch(updateUserActivityProvider);
            return ElevatedButton(
              onPressed: () async {
                if (_formkey.currentState!.validate()) {
                  final String? id = await loguearEmailAndPassword(emailController.text, passwordController.text);

                  if (id != null) {
                    updateUseActivity.updateUserActivity(id, true);

                    context.go('/home');
                  }
                }
              },
              child: const Text('ACCEDER'),
            );
          },
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
