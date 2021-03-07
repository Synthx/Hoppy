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
          child: const Text('Annuler'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoButton(
          child: const Text(
            'Confirmer',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }
}
