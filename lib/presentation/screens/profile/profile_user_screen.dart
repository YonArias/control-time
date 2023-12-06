import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileUserScreen extends StatefulWidget {
  const ProfileUserScreen({super.key});

  @override
  State<ProfileUserScreen> createState() => _ProfileUserScreenState();
}

class _ProfileUserScreenState extends State<ProfileUserScreen> {
  // Acceso al usuario registrado
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back_ios_new_outlined),
      //     onPressed: ()=>"",
      //   ),
      // ),
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
              onPressed: () => context.goNamed('home'),
            ),
          ),
          // Perfil
          ProfileUser(user: user),

          // Button para logout
          ElevatedButton(
            onPressed: () {
              auth.signOut();

              context.goNamed('main');
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}

class ProfileUser extends StatelessWidget {
  const ProfileUser({
    super.key,
    required this.user,
  });

  final User? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background, // TODO: Cambiar color
      height: 120,
      padding: const EdgeInsets.fromLTRB(30, 0, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Avatar del usuario
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              user?.photoURL ?? '',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          // Datos de usuarios
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user?.displayName ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(user?.email ?? '', style: TextStyle(fontSize: 12)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
