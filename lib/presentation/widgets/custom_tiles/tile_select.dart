import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TileSelected extends StatelessWidget {
  const TileSelected(
      {super.key, required this.icon, required this.title, required this.url, required this.color});

  final IconData icon;
  final String title;
  final String url;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        leading: Icon(
          icon,
          size: 36,
          color: color,
        ),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios_outlined),
        contentPadding: const EdgeInsets.all(15.0),
      ),
      onTap: () => context.go(url),
    );
  }
}
