import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';

class MaxFavoriteNumberDialog extends StatelessWidget {
  void _closeDialog(BuildContext context) {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        width: MediaQuery.of(context).size.width * 0.75,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Nombre maximum atteint',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 10),
            Text(
              'Avant d\'ajouter une nouvelle bière en favoris, retirez-en une.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(height: 20),
            Container(
              height: 48,
              child: ElevatedButton(
                onPressed: () => _closeDialog(context),
                child: Text('Fermer'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
