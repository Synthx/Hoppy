import 'package:flutter/material.dart';

class WaitingForKeyword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Alors c\'est laquelle ?',
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              'Recherchez la bière que vous venez de boire et commencer un nouveau check-in.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
