import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/generated/l10n.dart';

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
        title: Text(Localization.of(context).settings_about),
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
                    Localization.of(context).settings_about_hoppy_title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    Localization.of(context).settings_about_hoppy_content,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    Localization.of(context).settings_about_good_know_title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    Localization.of(context).settings_about_good_know_content,
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
