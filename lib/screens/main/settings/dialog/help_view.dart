import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/generated/l10n.dart';

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
        title: Text(Localization.of(context).settings_help),
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
