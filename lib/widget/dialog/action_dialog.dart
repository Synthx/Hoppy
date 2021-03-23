import 'package:flutter/material.dart' hide AnimatedIcon;
import 'package:hoppy/core/core.dart';
import 'package:hoppy/widget/widget.dart';

class ActionDialog extends StatelessWidget {
  final Widget icon;
  final String title;
  final String content;
  final String action;
  final VoidCallback onAction;

  const ActionDialog({
    required this.icon,
    required this.title,
    required this.content,
    required this.action,
    required this.onAction,
  });

  void _closeDialog(BuildContext context) {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 1),
              Center(
                child: AnimatedIcon(
                  icon: icon,
                  curve: Curves.easeIn,
                  duration: Duration(milliseconds: 400),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                content,
                style: Theme.of(context).textTheme.bodyText2,
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 2),
              Container(
                height: kFooterButtonHeight,
                child: ElevatedButton(
                  onPressed: () => onAction(),
                  child: Text(action),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: kFooterButtonHeight,
                child: ElevatedButton(
                  onPressed: () => _closeDialog(context),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white.withOpacity(0.6),
                    onPrimary: Colors.black,
                  ),
                  child: const Text('Pas maintenant'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
