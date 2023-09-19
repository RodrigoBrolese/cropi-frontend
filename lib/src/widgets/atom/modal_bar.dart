import 'package:flutter/material.dart';

class ModalBar extends StatelessWidget {
  const ModalBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 5,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
      ),
    );
  }
}
