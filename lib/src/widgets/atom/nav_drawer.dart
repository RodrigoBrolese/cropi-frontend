import 'package:cropi/src/app/bloc/bloc.dart';
import 'package:cropi/src/app/router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationDrawerDestinationType {
  const NavigationDrawerDestinationType({
    required this.label,
    required this.icon,
    this.addDividerPreceding = false,
  });

  final Widget label;
  final Widget icon;
  final bool addDividerPreceding;
}

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  int selectedIndex = 0;

  @override
  void initState() {
    setState(() {
      selectedIndex = menuRoutes.indexWhere((element) =>
          element.path ==
          GoRouter.of(context).routeInformationProvider.value.uri.path);
    });
    super.initState();
  }

  void _onDestinationSelected(int index) {
    setState(() {
      selectedIndex = index;
    });

    try {
      context.go(menuRoutes[index].path);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      onDestinationSelected: _onDestinationSelected,
      selectedIndex: selectedIndex,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Text(
            'Cropi',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        const NavigationDrawerDestination(
          label: Text("Plantações"),
          icon: Icon(Icons.grass),
        ),
        const Divider(),
        const NavigationDrawerDestination(
          label: Text("Configurações"),
          icon: Icon(Icons.settings),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: TextButton.icon(
            style: TextButton.styleFrom(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(15),
            ),
            label: Text(
              'Sair',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            icon: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            onPressed: () {
              context.read<AppBloc>().add(const LogoutAppEvent());
              context.go('/login');
            },
          ),
        ),
      ],
    );
  }
}
