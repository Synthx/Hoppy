import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';

class BeerServingStyleRepartition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
          ),
          child: Text(
            'Derniers check-ins',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 16,
                ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
