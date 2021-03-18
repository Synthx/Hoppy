import 'package:flutter/material.dart';

class MiniFabButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback? onTap;

  const MiniFabButton({
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 15,
        right: 15,
      ),
      width: 44,
      height: 44,
      child: FloatingActionButton(
        onPressed: onTap,
        backgroundColor: Colors.black.withOpacity(0.35),
        foregroundColor: Colors.white,
        elevation: 1,
        child: icon,
      ),
    );
  }
}
