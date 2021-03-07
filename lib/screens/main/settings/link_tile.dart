import 'package:flutter/material.dart';

class LinkTile extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const LinkTile({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      color: Theme.of(context).cardColor,
      child: Center(
        child: ListTile(
          title: Text(label),
          onTap: () => onTap(),
          trailing: Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
