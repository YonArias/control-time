import 'package:flutter/material.dart';

class MediumButton extends StatelessWidget {
  const MediumButton({super.key, this.title='', this.primaryColor = true, this.onTap});

  // Atributos de button
  final String title;
  final bool primaryColor;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Material(
        color: theme.primary,
        child: InkWell(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            width: 250,
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
