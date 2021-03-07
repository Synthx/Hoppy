import 'package:flutter/material.dart';

import 'dark_mode_tile.dart';
import 'link_tile.dart';
import 'name_input_tile.dart';
import 'version_container.dart';

class SettingsView extends StatefulWidget {
  @override
  State createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  void goToHelpScreen() {}

  void openExternalLink() {}

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
          DarkModeTile(),
          const SizedBox(height: 48),
          LinkTile(
            label: "A propos",
            onTap: () => goToHelpScreen(),
          ),
          LinkTile(
            label: "Aide",
            onTap: () => goToHelpScreen(),
          ),
          LinkTile(
            label: "Github",
            onTap: () => openExternalLink(),
          ),
          const SizedBox(height: 48),
          VersionContainer(),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}
