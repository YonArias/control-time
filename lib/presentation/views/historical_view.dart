import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HistoricalView extends StatelessWidget {
  const HistoricalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          color: Colors.black,
          child: Row(
            children: [
              Image.asset('assets/image/logo-pormientras.png'), // TODO: cambiar la imagen segun lo escogido

              InkWell(
                child: const Text('ZOT-576', style: TextStyle(color: Colors.white),),
                onTap: ()=>context.goNamed('selectVehicle'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}