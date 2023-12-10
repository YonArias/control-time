import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_control_app/config/router/app_router.dart';
import 'package:time_control_app/config/theme/app_theme.dart';
import 'package:time_control_app/infrastructure/datasources/transport_datasource_impl.dart';
import 'package:time_control_app/infrastructure/datasources/user_datasource_impl.dart';
import 'package:time_control_app/infrastructure/repositories/transport_repository_impl.dart';
import 'package:time_control_app/infrastructure/repositories/user_repository_impl.dart';
import 'package:time_control_app/presentation/providers/chronometer_provider.dart';
import 'package:time_control_app/presentation/providers/counter_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:time_control_app/presentation/providers/transport_provider.dart';
import 'package:time_control_app/presentation/providers/user_provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final transportRepository =
        TransportRepositoryImpl(transportDatasource: TransportDatasourceImpl());
    final userRepository =
        UserRepositoryImpl(userDatasource: UserDatasourceImpl());

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CounterProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChronometerProvider(),
        ),
        ChangeNotifierProvider(
          create: (_)=> TransportProvider(transportRepository: transportRepository)..loadTransport()
        ),
        ChangeNotifierProvider(
          create: (_)=> UserProvider(userRepository: userRepository)..loadUser(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        theme: AppTheme(selectedColor: 3).getTheme(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
