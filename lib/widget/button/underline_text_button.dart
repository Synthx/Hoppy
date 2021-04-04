import 'package:flutter/material.dart';

class UnderlineTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const UnderlineTextButton({
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        primary: Theme.of(context).textTheme.bodyText1!.color,
        textStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
              decoration: TextDecoration.underline,
            ),
      ),
      child: Text(text),
    );
  }
}
