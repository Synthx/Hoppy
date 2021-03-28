import 'package:flutter/material.dart' hide AnimatedIcon;
import 'package:hoppy/core/core.dart';
import 'package:hoppy/generated/l10n.dart';
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
                Localization.of(context).error_title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 10),
              Text(
                Localization.of(context).error_content,
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 1),
              TextButton(
                onPressed: () => _openReportErrorScreen(context),
                style: TextButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
                child: Text(
                  Localization.of(context).error_see_report,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: kFooterButtonHeight,
                child: ElevatedButton(
                  onPressed: () => _closeDialog(context),
                  child: Text(
                    Localization.of(context).close,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
