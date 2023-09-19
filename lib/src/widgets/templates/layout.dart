import 'package:cropi/src/app/bloc/bloc.dart';
import 'package:cropi/src/widgets/atom/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Layout extends StatelessWidget {
  const Layout({
    required this.body,
    required this.title,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.showBackButton = false,
    this.noPadding = false,
    this.hideNotifications = false,
    super.key,
  });

  final String title;
  final Widget body;
  final bool showBackButton;
  final FloatingActionButton? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool noPadding;
  final bool hideNotifications;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: showBackButton ? null : const NavDrawer(),
      appBar: AppBar(
        title: Text(title),
        scrolledUnderElevation: 4,
        shadowColor: Theme.of(context).colorScheme.shadow,
        actions: [
          !hideNotifications
              ? Badge(
                  label: const SizedBox(width: 2),
                  isLabelVisible: context.watch<AppBloc>().state.user != null
                      ? context
                          .watch<AppBloc>()
                          .state
                          .user!
                          .hasUnviewedNotifications
                      : false,
                  smallSize: 10,
                  largeSize: 10,
                  offset: const Offset(-10, 10),
                  child: IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () {
                      context.read<AppBloc>().add(
                            const SetViewedNotificationAppEvent(),
                          );
                      context.push('/notifications');
                    },
                  ),
                )
              : const SizedBox()
        ],
      ),
      body: Padding(
        padding: !noPadding
            ? const EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5)
            : const EdgeInsets.all(0),
        child: body,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: floatingActionButton,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
