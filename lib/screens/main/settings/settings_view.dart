import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/generated/l10n.dart';
import 'package:hoppy/screens/screens.dart';
import 'package:hoppy/store/store.dart';
import 'package:url_launcher/url_launcher.dart';

import 'settings.dart';

class SettingsView extends StatefulWidget {
  @override
  State createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView>
    with AutomaticKeepAliveClientMixin {
  void _openOnBoardDialog() {
    Navigator.push(
      context,
      OnBoardScreen.route(),
    );
  }

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

  void _onLoadingChanged(bool loading) {
    if (loading) {
      context.showLoadingDialog();
    } else {
      context.pop();
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<SettingsCubit, SettingsState>(
          listenWhen: (prev, curr) => prev.loading != curr.loading,
          listener: (_, state) => _onLoadingChanged(state.loading),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            Localization.of(context).settings,
          ),
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
              label: Localization.of(context).settings_about,
              onTap: () => _goToAboutScreen(),
            ),
            const Divider(height: 0),
            LinkTile(
              label: Localization.of(context).on_board,
              onTap: () => _openOnBoardDialog(),
            ),
            const Divider(height: 0),
            LinkTile(
              label: Localization.of(context).settings_terms,
              onTap: () => _goToHelpScreen(),
            ),
            const Divider(height: 0),
            LinkTile(
              label: Localization.of(context).settings_github,
              onTap: () => _openGithub(),
            ),
            const Divider(height: 0),
            LinkTile(
              label: Localization.of(context).settings_contact,
              onTap: () => _sendMailTo(),
            ),
            const SizedBox(height: 48),
            DeleteDataButton(),
            const SizedBox(height: 48),
            VersionContainer(),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
