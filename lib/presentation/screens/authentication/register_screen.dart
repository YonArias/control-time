import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:time_control_app/data/models/user_model.dart';
import 'package:time_control_app/presentation/providers/user_provider.dart';
import 'package:time_control_app/presentation/widgets/custom_inputs/dropdown_custom.dart';
import 'package:time_control_app/presentation/widgets/custom_inputs/text_input.dart';

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
                height: 300,
              ),
              const Text(
                'Registrarse',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15,),
              // Formulario
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: _FormRegister(),
              ),
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
          TextInput(
            label: 'Nombres',
            controller: nameController,
            icon: Icons.person,
            // validator: 'Ingresa tu nombre',
          ),
          const SizedBox(height: 10,),
          // Apellido
          TextInput(
            label: 'Apellidos',
            controller: lastnameController,
            icon: Icons.person_2_outlined,
            // validator: 'Ingresa tu apellido',
          ),
          const SizedBox(height: 10,),
          // Correo electronico
          TextInput(
            label: 'Correo electronico',
            controller: gmailController,
            icon: Icons.email,
            // validator: 'example@example.com',
          ),
          const SizedBox(height: 10,),
          // Rol
          DropdownCustom(
            label: 'Rol de usuario',
            opciones: opciones,
            icon: Icons.badge,
          ),
          const SizedBox(height: 10,),
          // Password
          TextInput(
            label: 'Contraseña',
            controller: passwordController,
            icon: Icons.remove_red_eye_sharp,
          ),
          const SizedBox(height: 20,),
          // BUTTON
          _UserButton(
            validado: _formkey.currentState?.validate(),
            name: nameController,
            lastname: lastnameController,
            rol: opcion,
            gmail: gmailController,
            password: passwordController,
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

class _UserButton extends ConsumerWidget {
  const _UserButton({super.key,
  required this.validado,
  required this.name,
  required this.lastname,
  required this.rol,
  required this.gmail,
  required this.password
  });

  final bool? validado;
  final TextEditingController name;
  final TextEditingController lastname;
  final String rol;
  final TextEditingController gmail;
  final TextEditingController password;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        if (validado != null && validado == true) {
          FirebaseAuth auth = FirebaseAuth.instance;

          await auth.createUserWithEmailAndPassword(
            email: gmail.text,
            password: password.text,
          );

          ref.read(addUserProvider).addUser(UserModel(
                id: '',
                name: name.text,
                lastname: lastname.text,
                rol: rol,
                gmail: gmail.text,
                isActive: false,
                isValidate: false,
              ).toUserEntity()
              );

          auth.signOut();

          context.goNamed('main');
        }
      },
      child: const Text('Registrar'),
    );
  }
}
