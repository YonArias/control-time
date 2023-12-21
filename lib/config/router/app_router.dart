import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:time_control_app/presentation/screens/authentication/register_screen.dart';
import 'package:time_control_app/presentation/screens/home/operador/control_time_screen.dart';
import 'package:time_control_app/presentation/screens/home/operador/operador_home_screen.dart';
import 'package:time_control_app/presentation/screens/home/supervisor_home_screen.dart';
import 'package:time_control_app/presentation/screens/mobility/select_mobility_screen.dart';
import 'package:time_control_app/presentation/screens/profile/profile_user_screen.dart';
import 'package:time_control_app/presentation/screens/screens.dart';
import 'package:time_control_app/presentation/screens/web/web_home_screen.dart';
import 'package:time_control_app/presentation/views/supervisor/task/add_task_view.dart';
import 'package:time_control_app/presentation/views/supervisor/transport/add_transport_view.dart';

User? user = FirebaseAuth.instance.currentUser;

final appRouter = GoRouter(
  // Para que no vuelva a pedir que se loguee si esque ya esta logueado
  initialLocation: user == null ? '/' : '/home',
  routes: [
    GoRoute(
      name: 'main',
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: 'register',
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: 'operadorHome',
      path: '/operador',
      builder: (context, state) => const OperadorHomeScreen(),
    ),
    GoRoute(
      name: 'controlTime',
      path: '/operador/controlTime',
      builder: (context, state) => const ControlTimeScreen(),
    ),
    GoRoute(
      name: 'profile',
      path: '/home/profile',
      builder: (context, state) => const ProfileUserScreen(),
    ),
    GoRoute(
      name: 'selectVehicle',
      path: '/home/selectVehicle',
      builder: (context, state) => const SelectMobilityScreen(),
    ),
    // Agregar recursos
    GoRoute(
      name: 'supervisorHome',
      path: '/supervisor',
      builder: (context, state) => const SupervisorHomeScreen(),
    ),
    GoRoute(
      name: 'addTransport',
      path: '/supervisor/addTransport',
      builder: (context, state) => const AddTransportView(),
    ),
    GoRoute(
      name: 'addTask',
      path: '/supervisor/addTask',
      builder: (context, state) => const AddTaskView(),
    ),

    // SCREEN PARA WEB
    GoRoute(
      name: 'admin',
      path: '/admin',
      builder: (context, state) => const WebHomeScreen(),
    ),
  ],
);
