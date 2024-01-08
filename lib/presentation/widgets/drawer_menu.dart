import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:time_control_app/config/menu/menu_item.dart';
import 'package:time_control_app/domain/services/auth_service.dart';
import 'package:time_control_app/presentation/providers/drawer_provider.dart';

class SideMenu extends ConsumerWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationDrawer(
        selectedIndex: ref.watch(itemSelect),
        onDestinationSelected: (value) {
          ref.read(itemSelect.notifier).state = value;
        },
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 20, 16, 10),
            child: Text('Main'),
          ),
          ...appMenuItems
              .sublist(0, 1)
              .map((item) => NavigationDrawerDestination(
                    icon: Icon(item.icon),
                    label: Text(item.title),
                  )),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Divider(),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 20, 16, 10),
            child: Text('Estadisticas'),
          ),
          ...appMenuItems.sublist(1).map((item) => NavigationDrawerDestination(
                icon: Icon(item.icon),
                label: Text(item.title),
              )),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Divider(),
          ),
          // const SizedBox(height: 30,),
          Container(
            margin:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 50,
            child: ElevatedButton(
                onPressed: () async {
                  await logoutUser();
                  context.goNamed('main');
                },
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back),
                    Text('Cerrar cession')
                  ],
                ),
              ),
          ),
        ]);
  }
}
