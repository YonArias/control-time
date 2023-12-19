import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    this.label = '',
    this.icon,
    this.controller,
    this.validator,
    this.type = TextInputType.text,
    this.hive = false
  });

  final String label;
  final IconData? icon;
  final TextEditingController? controller;
  final String? validator;
  final TextInputType type;
  final bool hive;

  @override
  Widget build(BuildContext context) {
    // Obtenemos el color del thema
    final theme = Theme.of(context).colorScheme;

    // Configuracion de borde
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: theme.primary));

    return SizedBox(
      height: 60,
      child: TextFormField(
        // Logica
        controller: controller,
        // Validamos si hay contenido en el INPUT
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validator;
          }
          return null;
        },
        // Decoracion del input
        decoration: InputDecoration(
          label: Text(
            label,
          ),
          fillColor: Colors.grey[200],
          filled: true,
          prefixIcon: Icon(
            icon,
          ),
          border: border,
          focusedBorder: border,
        ),
        keyboardType: type,
        obscureText: hive,
      ),
    );
  }
}
