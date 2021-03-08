import 'package:flutter/material.dart' hide AnimatedIcon;
import 'package:hoppy/core/core.dart';
import 'package:hoppy/widget/widget.dart';

class EmptyFavorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedIcon(
            icon: const Text(
              '🍻',
              style: TextStyle(
                fontSize: 50,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Pas encore de favoris ?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 10),
          Text(
            'Ajoutez des bières en favoris pour plus vite les retrouver (20 maximum)',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
