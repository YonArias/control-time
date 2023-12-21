import 'package:flutter/material.dart';

class CircleButtonWidget extends StatelessWidget {
  const CircleButtonWidget({super.key, required this.icon, required this.color, this.ontap});

  final IconData icon;
  final Color color;
  final GestureTapCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(20.0),
          color: color,
          child: Icon(icon, color: Colors.white, size: 40,)
        ),
        onTap: ontap,
      ),
    );
  }
}
