import 'package:flutter/material.dart';
import 'package:time_control_app/config/router/app_router.dart';
import 'package:time_control_app/config/theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: AppTheme(selectedColor: 3).getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
