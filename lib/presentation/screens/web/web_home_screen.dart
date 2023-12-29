import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_control_app/presentation/providers/drawer_provider.dart';
import 'package:time_control_app/presentation/screens/web/web_delays_screen.dart';
import 'package:time_control_app/presentation/screens/web/web_doneTasks_screen.dart';
import 'package:time_control_app/presentation/screens/web/web_main_screen.dart';
import 'package:time_control_app/presentation/screens/web/web_transports_screen.dart';
import 'package:time_control_app/presentation/widgets/drawer_menu.dart';

class WebHomeScreen extends ConsumerWidget {
  const WebHomeScreen({super.key});

  static const views = [
    WebMainScreen(),
    WebMainScreen(),
    WebDelaysScreen(),
    WebTransportsScreen(),
    WebDoneTasksScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selection = ref.watch(itemSelect);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      drawer: const SideMenu(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: views[selection],
      ),
    );
  }
}
