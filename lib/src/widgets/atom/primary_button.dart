import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.text,
    this.isLoading = false,
    this.onPressed,
    super.key,
  });

  final bool isLoading;
  final String text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: !isLoading ? onPressed : null,
        style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(15))),
        child: !isLoading
            ? Text(
                text,
                style: const TextStyle(fontSize: 18),
              )
            : SizedBox(
                height: 26,
                width: 26,
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onPrimary,
                  strokeWidth: 3,
                )),
      ),
    );
  }
}
