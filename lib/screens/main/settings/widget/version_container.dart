import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class VersionContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LegalNotice();
        }

        var packageInfo = snapshot.data!;
        return Column(
          children: [
            Text(
              'Version ${packageInfo.version}',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            Text(
              'Build ${packageInfo.buildNumber}',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(height: 20),
            LegalNotice(),
          ],
        );
      },
    );
  }
}

class LegalNotice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Copyright 2021 Hoppy',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Text(
          'Tous droits réservées',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
