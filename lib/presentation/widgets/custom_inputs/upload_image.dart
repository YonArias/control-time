import 'package:flutter/material.dart';

class UploadImage extends StatelessWidget {
  const UploadImage({super.key, required this.ontap});

  final GestureTapCallback ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.grey[500],
          border: Border.all(style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Subir Imagen'),
            SizedBox(
              width: 50,
            ),
            Icon(Icons.archive_outlined)
          ],
        ),
      ),
      onTap: ontap,
    );
  }
}
