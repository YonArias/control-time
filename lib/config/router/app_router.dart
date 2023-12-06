import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:time_control_app/presentation/screens/profile/profile_user_screen.dart';
import 'package:time_control_app/presentation/screens/screens.dart';

User? user = FirebaseAuth.instance.currentUser;

final appRouter = GoRouter(
  // Para que no vuelva a pedir que se loguee si esque ya esta logueado
  initialLocation: user == null ? '/' : '/home',
  routes: [
    GoRoute(
      name: 'main',
      path: '/',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: 'profile',
      path: '/home/profile',
      builder: (context, state) => const ProfileUserScreen(),
    ),
  ],
);
