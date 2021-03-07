import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class VersionContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Column(
            children: [
              const Text("Copyright 2021 Hoppy"),
              const Text("Tous droits réservées"),
            ],
          );
        }

        var packageInfo = snapshot.data!;
        return Column(
          children: [
            Text("Version ${packageInfo.version}"),
            Text("Build ${packageInfo.buildNumber}"),
            const SizedBox(height: 20),
            const Text("Copyright 2021 Hoppy"),
            const Text("Tous droits réservées"),
          ],
        );
      },
    );
  }
}
