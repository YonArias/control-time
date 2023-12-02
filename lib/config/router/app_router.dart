import 'package:go_router/go_router.dart';
import 'package:time_control_app/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
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

  ],

);
