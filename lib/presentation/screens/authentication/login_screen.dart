import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:time_control_app/presentation/providers/user_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<String> opciones = ['ADMIN', 'OPERARIO', 'JEFE'];
  late String opcion;
  @override
  void initState() {
    opcion = 'OPERARIO';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              // Image Logo
              Image.asset(
                'assets/image/logo-pormientras.png',
                height: 350,
              ),
              const Text(
                'Inicia session',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Conectate con tu cuenta google unica vez',
              ),
              const SizedBox(
                height: 20,
              ),

              // SELECCIONAR ROL
              DropdownButtonFormField(
                items: opciones
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    opcion = value.toString();
                  });
                },
                decoration: const InputDecoration(label: Text('Tipo de ROL')),
              ),

              const SizedBox(
                height: 30,
              ),

              SocialLoginButton(
                buttonType: SocialLoginButtonType.google,
                onPressed: () async {
                  final firestore = FirebaseFirestore.instance;
                  FirebaseAuth auth = FirebaseAuth.instance;
                  // TODO: AUTHENTIFICAR PARA GOOGLE FIREBASE
                  UserCredential credentialUser = await signInWithGoogle();

                  // Creamos el usuario
                  if (credentialUser.additionalUserInfo!.isNewUser) {
                    firestore.collection('user').add({
                      'name': credentialUser.user!.displayName,
                      'rol': opcion,
                      'gmail': credentialUser.user!.email,
                      'phone': credentialUser.user!.phoneNumber ?? 0,
                      'isValidate': false,
                    });
                  } else {
                     if (await userProvider.ValidarIngreso(
                      credentialUser.user!.email)) {
                      context.goNamed('home');
                    } else {
                      auth.signOut();
                  }
                  }

                 
                  // await signInWithGoogle();
                  // context.goNamed('home');
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
                    textAlign: TextAlign.center),
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
