import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';

class ErrorNotificationDialog extends StatelessWidget {
  final String content;

  const ErrorNotificationDialog({
    required this.content,
  });

  void _closeDialog(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _closeDialog(context),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 1,
        child: const Icon(Icons.clear),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Theme.of(context).cardColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: [
              Text('Oops'),
            ],
          ),
        ),
      ),
    );
  }
}
