import 'package:auth_buttons/auth_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:time_control_app/presentation/providers/chronometer_provider.dart';
import 'package:time_control_app/presentation/widgets/custom_buttons/medium_buttons.dart';
import 'package:time_control_app/presentation/widgets/custom_inputs/text_input.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
                onTap: () async {
                  if (_formkey.currentState!.validate()) {
                    // Cargar los datos
                    // ChronometerProvider().cargarDatos();

                    // TODO: Authentificar con CORREO CON firebase
                    // Iniciar sesión con una dirección de correo electrónico y una contraseña
                    UserCredential userCredential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text);
                    // Mostrar un mensaje de bienvenida al usuario
                    if (userCredential.user != null) {
                      // REDIRECCIONANDO AL HOME
                      context.goNamed('home');
                    }
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
                onPressed: () async {
                  // TODO: AUTHENTIFICAR PARA GOOGLE FIREBASE
                  // ChronometerProvider().cargarDatos();
                  await signInWithGoogle();
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

  Future<UserCredential> signInWithGoogle() async {
    // Activar el flujo de autenticación
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtener los detalles de autenticación de la solicitud
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Crea una nueva credencial
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Una vez que haya iniciado sesión, devuelva la credencial de usuario
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
