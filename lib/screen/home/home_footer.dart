import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeFooter extends StatelessWidget {
  const HomeFooter({super.key});

  Future _openJetdevLink() async {
    final url = Uri.parse('https://www.jetdev.fr/');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(
        bottom: context.bottomSafeArea + kSpacer,
        top: kSpacer,
        left: kSafeArea,
        right: kSafeArea,
      ),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            Text(
              context.t.homeFooterCopyright,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: kSpacer),
            TextButton(
              onPressed: () => _openJetdevLink(),
              child: Text(
                context.t.homeFooterLink,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.secondaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
