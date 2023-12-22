import 'package:flutter/material.dart';

class DropdownCustom extends StatefulWidget {
  const DropdownCustom(
      {super.key, required this.opciones, required this.label, required this.icon});

  final List<String> opciones;
  final String label;
  final IconData icon;

  @override
  State<DropdownCustom> createState() => _DropdownCustomState();
}

class _DropdownCustomState extends State<DropdownCustom> {
  String opcion = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: theme.primary));

    return SizedBox(
      height: 60,
      child: DropdownButtonFormField(
        items: widget.opciones
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (value) {
          setState(() {
            opcion = value.toString();
          });
        },
        decoration: InputDecoration(
            label: Text(
              widget.label,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            border: border,
            fillColor: Colors.grey[200],
            filled: true,
            prefixIcon: Icon(
              widget.icon,
            ),
        )
      ),
    );
  }
}
