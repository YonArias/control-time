import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              // Image Logo
              Image.asset('assets/image/logo-pormientras.png', height: 350,),
              const Text(
                'Inicia session',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              const Text(
                'Conectate con tu cuenta google unica vez',
              ),
      
              const SizedBox(
                height: 30,
              ),
      
              SocialLoginButton(
                buttonType: SocialLoginButtonType.google,
                onPressed: () async {
                  // TODO: AUTHENTIFICAR PARA GOOGLE FIREBASE
                  // ChronometerProvider().cargarDatos();
                  await signInWithGoogle();
                  // TODO: REDIRECCIONAR AL HOME
                  context.goNamed('home');
                },
                borderRadius: 50,
              ),
      
              const SizedBox(
                height: 50,
              ),
      
              const Padding(
                padding: EdgeInsets.all(50.0),
                child: Text(
                  'Controla tus tiempos, no pierdas ningun segundo bro', 
                  textAlign: TextAlign.center
                ),
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
