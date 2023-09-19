import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SimpleLayout extends StatelessWidget {
  const SimpleLayout(
      {required this.body,
      required this.title,
      this.smallAppBar = false,
      super.key});

  final String title;
  final Widget body;
  final bool smallAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !smallAppBar
          ? AppBar(
              title: Text(title),
              scrolledUnderElevation: 4,
              shadowColor: Theme.of(context).colorScheme.shadow,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.pop();
                },
              ),
            )
          : AppBar(
              toolbarHeight: 0,
              elevation: 0,
            ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
        child: body,
      ),
    );
  }
}
