import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';

import 'more_card_button.dart';

class MostDrunkenBeerStyleCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kCardHeight,
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        image: DecorationImage(
          image: const AssetImage('assets/images/beer-style.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.srcOver,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(flex: 2),
          Text(
            'Style de bière le plus apprecié',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 16,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            'IPA',
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Colors.white,
                ),
          ),
          const Spacer(flex: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bue 34 fois',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
              ),
              MoreCardButton(
                onTap: () {},
                icon: Icon(Icons.chevron_right),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
