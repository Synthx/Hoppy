import 'package:flutter/material.dart';

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
        child: const Icon(Icons.clear),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 1,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Theme.of(context).cardColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
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
