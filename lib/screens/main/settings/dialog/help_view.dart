import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hoppy/core/core.dart';

class HelpView extends StatelessWidget {
  static MaterialPageRoute route() => MaterialPageRoute(
        builder: (_) => HelpView(),
      );

  void _back(BuildContext context) {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings_help),
        leading: IconButton(
          onPressed: () => _back(context),
          icon: const Icon(Icons.chevron_left),
        ),
      ),
      backgroundColor: Theme.of(context).cardColor,
      body: Column(
        children: [
          ExpansionTile(
            title: Text('test'),
            expandedAlignment: Alignment.centerLeft,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            childrenPadding: const EdgeInsets.all(kDefaultPadding),
            children: [
              Text('panel 1'),
            ],
          ),
        ],
      ),
    );
  }
}
