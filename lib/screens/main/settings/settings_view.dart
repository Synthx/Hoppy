import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import 'settings.dart';

class SettingsView extends StatefulWidget {
  @override
  State createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView>
    with AutomaticKeepAliveClientMixin {
  void _goToHelpScreen() {
    Navigator.push(
      context,
      TermsView.route(),
    );
  }

  void _goToAboutScreen() {
    Navigator.push(
      context,
      AboutView.route(),
    );
  }

  Future<void> _openGithub() async {
    final githubUri = 'https://github.com/Synthx/Hoppy';
    if (await canLaunch(githubUri)) {
      await launch(
        githubUri,
        forceWebView: true,
        enableJavaScript: true,
      );
    }
  }

  Future<void> _sendMailTo() async {
    final mailUri = Uri(
      scheme: 'mailto',
      path: 'taniel.remi@gmail.com',
      queryParameters: {
        'subject': '[Hoppy]',
      },
    ).toString();
    if (await canLaunch(mailUri)) {
      await launch(mailUri);
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      backgroundColor: Theme.of(context).cardColor,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 48),
          NameInputTile(),
          const Divider(height: 0),
          DarkModeTile(),
          const SizedBox(height: 48),
          LinkTile(
            label: AppLocalizations.of(context)!.settings_about,
            onTap: () => _goToAboutScreen(),
          ),
          const Divider(height: 0),
          LinkTile(
            label: AppLocalizations.of(context)!.settings_terms,
            onTap: () => _goToHelpScreen(),
          ),
          const Divider(height: 0),
          LinkTile(
            label: AppLocalizations.of(context)!.settings_github,
            onTap: () => _openGithub(),
          ),
          const Divider(height: 0),
          LinkTile(
            label: AppLocalizations.of(context)!.settings_contact,
            onTap: () => _sendMailTo(),
          ),
          const SizedBox(height: 48),
          VersionContainer(),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}
