import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/image/logo-pormientras.png',
                height: 350,
              ),
              const Text(
                'Registrarse',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              // Formulario
              const _FormRegister(),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormRegister extends StatefulWidget {
  const _FormRegister({super.key});

  @override
  State<_FormRegister> createState() => __FormRegisterState();
}

class __FormRegisterState extends State<_FormRegister> {
  final _formkey = GlobalKey<FormState>();

  List<String> opciones = ['ADMIN', 'OPERARIO', 'JEFE'];
  String opcion = 'OPERARIO';

  // Controladores
  late TextEditingController nameController;
  late TextEditingController lastnameController;
  late TextEditingController gmailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    nameController = TextEditingController(text: '');
    lastnameController = TextEditingController(text: '');
    gmailController = TextEditingController(text: '');
    passwordController = TextEditingController(text: '');
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    lastnameController.dispose();
    gmailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          // Nombre
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(label: Text('Nombres')),
          ),
          // Apellido
          TextFormField(
            controller: lastnameController,
            decoration: const InputDecoration(label: Text('Apellidos')),
          ),
          // Correo electronico
          TextFormField(
            controller: gmailController,
            decoration:
                const InputDecoration(label: Text('Correo electronico')),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Correo obligatorio';
              }
              return null;
            },
          ),

          // Rol
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

          // Telefono
          TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(label: Text('Password')),
          ),

          // BUTTON
          ElevatedButton(
            onPressed: () async {
              if (_formkey.currentState!.validate()) {
                FirebaseAuth auth = FirebaseAuth.instance;
                final firebase = FirebaseFirestore.instance;

                await auth.createUserWithEmailAndPassword(
                  email: gmailController.text,
                  password: passwordController.text,
                );

                firebase.collection('user').doc().set({
                  'name': nameController.text,
                  'lastname': lastnameController.text,
                  'gmail': gmailController.text,
                  'rol': opcion,
                  'active': false,
                  'isValidate': false
                });

                auth.signOut();

                context.goNamed('main');
              }
            },
            child: const Text('Registrar'),
          ),

          ElevatedButton(
            onPressed: () => context.goNamed('main'),
            child: const Text('Iniciar sesion'),
          ),
        ],
      ),
    );
  }
}
