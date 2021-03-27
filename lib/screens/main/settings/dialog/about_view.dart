import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hoppy/core/core.dart';

class AboutView extends StatelessWidget {
  static MaterialPageRoute route() => MaterialPageRoute(
        builder: (_) => AboutView(),
      );

  void _back(BuildContext context) {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings_about),
        leading: IconButton(
          onPressed: () => _back(context),
          icon: const Icon(Icons.chevron_left),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 350,
              color: Colors.red,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6),
                        BlendMode.srcOver,
                      ),
                      child: Image.asset(
                        'assets/images/empty-beer.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
                vertical: kDefaultPadding * 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.settings_about_hoppy_title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.settings_about_hoppy_content,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 16,
                        ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    AppLocalizations.of(context)!
                        .settings_about_good_know_title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!
                        .settings_about_good_know_content,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 16,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
