import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmActionDialog extends StatelessWidget {
  final String content;

  const ConfirmActionDialog({
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Attention'),
      content: Text(content),
      actions: [
        CupertinoButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Annuler'),
        ),
        CupertinoButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: const Text(
            'Confirmer',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
