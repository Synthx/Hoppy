import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dark_mode_tile.dart';
import 'link_tile.dart';
import 'name_input_tile.dart';
import 'version_container.dart';

class SettingsView extends StatefulWidget {
  @override
  State createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  void _goToHelpScreen() {}

  void _goToAboutScreen() {}

  Future<void> _openGithub() async {
    final githubUri = 'https://github.com/Synthx/Hoppy';
    if (await canLaunch(githubUri)) {
      await launch(githubUri, forceWebView: true, enableJavaScript: true);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 48),
          NameInputTile(),
          const Divider(height: 0),
          DarkModeTile(),
          const SizedBox(height: 48),
          LinkTile(
            label: "A propos",
            onTap: () => _goToHelpScreen(),
          ),
          const Divider(height: 0),
          LinkTile(
            label: "Aide",
            onTap: () => _goToHelpScreen(),
          ),
          const Divider(height: 0),
          LinkTile(
            label: 'Github',
            onTap: () => _openGithub(),
          ),
          const Divider(height: 0),
          LinkTile(
            label: 'Nous contacter',
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
