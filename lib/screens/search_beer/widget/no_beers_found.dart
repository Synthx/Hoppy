import 'package:flutter/material.dart';

class NoBeersFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Oops, nous sommes à sec',
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              'Impossible de trouver des bières correspondantes, vérifiez l\'orthogrape ou ajoutez-la.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
