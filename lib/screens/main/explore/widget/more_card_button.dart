import 'package:flutter/material.dart';

class MoreCardButton extends StatelessWidget {
  final VoidCallback onTap;
  final Icon icon;

  const MoreCardButton({
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: 65,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: IconButton(
        onPressed: onTap,
        icon: icon,
      ),
    );
  }
}
