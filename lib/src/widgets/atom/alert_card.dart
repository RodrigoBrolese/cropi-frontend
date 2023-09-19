import 'package:flutter/material.dart';

class AlertCard extends StatelessWidget {
  const AlertCard({
    required this.message,
    required this.color,
    required this.textColor,
    this.margin,
    super.key,
  });

  final String message;
  final EdgeInsetsGeometry? margin;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      margin: margin,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
