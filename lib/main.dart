import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_control_app/config/router/app_router.dart';
import 'package:time_control_app/config/theme/app_theme.dart';
import 'package:time_control_app/presentation/providers/chronometer_provider.dart';
import 'package:time_control_app/presentation/providers/counter_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterProvider(),),
        ChangeNotifierProvider(create: (_) => ChronometerProvider(),),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        theme: AppTheme(selectedColor: 3).getTheme(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
