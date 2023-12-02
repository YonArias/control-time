import 'package:flutter/material.dart';
import 'package:time_control_app/config/menu/menu_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter + Material 3'),
      ),
      body: ListView.builder(
        itemCount: appMenuItems.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(appMenuItems[index].title),
          subtitle: Text(appMenuItems[index].subTitle),
        ),
      ),
    );
  }
}
