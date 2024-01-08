import 'package:flutter/material.dart';

class ControllerButtonWidget extends StatelessWidget {
  const ControllerButtonWidget(
      {super.key, this.name, this.icon, this.ontap, this.color, this.dark=false});

  final String? name;
  final IconData? icon;
  final GestureTapCallback? ontap;
  final Color? color;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: ontap,
      child: Container(
        width: 200,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            // Color secondary
            color: color),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              icon,
              size: 32,
              color: dark ? Colors.white : Colors.black,
            ),
            name == null
                ? SizedBox()
                : Text(
                    name!,
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold,
                        color: dark ? Colors.white : Colors.black),
                  ),
          ],
        ),
      ),
    );
  }
}
