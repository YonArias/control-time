import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:time_control_app/presentation/providers/chronometer_provider.dart';
import 'package:time_control_app/presentation/widgets/custom_buttons/medium_buttons.dart';
import 'package:time_control_app/presentation/widgets/custom_inputs/text_input.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  // Llave para el formulario
  final _formkey = GlobalKey<FormState>();

  // Controladores para el formulario
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              // Imagen de LOGIN
              const Image(
                image: AssetImage('assets/image/logo-pormientras.png'),
                height: 300,
              ),
              const SizedBox(
                height: 10,
              ),

              // Formulario
              TextInput(
                // TODO: VERIFICAR QUE SEA CORREO
                label: 'Email',
                icon: Icons.email_outlined,
                controller: emailController,
                validator: 'Not email',
              ),
              const SizedBox(
                height: 20,
              ),
              TextInput(
                label: 'Password',
                icon: Icons.remove_red_eye_outlined,
                controller: passwordController,
                validator: 'Not password',
                hidden: true,
              ),
              const SizedBox(
                height: 30,
              ),
              MediumButton(
                title: 'Login',
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    // Cargar los datos
                    // ChronometerProvider().cargarDatos();

                    // TODO: Authentificar con CORREO CON firebase

                    // TODO: REDIRECCIONAR AL HOME
                    context.goNamed('home');
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),

              // Logueo de GOOGLE
              const Text(
                'o',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GoogleAuthButton(
                onPressed: () {
                  // TODO: AUTHENTIFICAR PARA GOOGLE FIREBASE
                  // ChronometerProvider().cargarDatos();

                    // TODO: Authentificar con CORREO CON firebase

                    // TODO: REDIRECCIONAR AL HOME
                  context.goNamed('home');
                },
                style: const AuthButtonStyle(
                  iconType: AuthIconType.secondary,
                ),
                themeMode: ThemeMode.light,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
