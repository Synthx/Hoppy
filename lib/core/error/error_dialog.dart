import 'package:flutter/material.dart' hide AnimatedIcon;
import 'package:hoppy/core/core.dart';
import 'package:hoppy/widget/widget.dart';

class ErrorDialog extends StatelessWidget {
  final ErrorReport report;

  const ErrorDialog({
    required this.report,
  });

  void _closeDialog(BuildContext context) {
    context.pop();
  }

  void _openReportErrorScreen(BuildContext context) {
    Navigator.push(
      context,
      ErrorReportScreen.route(report),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 1),
              AnimatedIcon(
                icon: Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 50,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Oops ! Quelque chose ne s\'est pas bien passé',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 10),
              Text(
                'Veuillez réessayer plus tard, si le problème persiste, un rapport d\'erreur a été généré',
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 2),
              TextButton(
                onPressed: () => _openReportErrorScreen(context),
                style: TextButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
                child: Text('Voir le rapport'),
              ),
              const SizedBox(height: 10),
              Container(
                height: kFooterButtonHeight,
                child: ElevatedButton(
                  onPressed: () => _closeDialog(context),
                  child: const Text('Fermer'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
