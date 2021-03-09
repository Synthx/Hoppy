import 'package:flutter/material.dart' hide AnimatedIcon;
import 'package:hoppy/core/core.dart';
import 'package:hoppy/widget/widget.dart';

class WaitingForKeyword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedIcon(
              icon: const Text(
                '🍺',
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              'Alors c\'est laquelle ?',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Recherchez la bière que vous venez de boire et commencer un nouveau check-in.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}
