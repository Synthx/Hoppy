import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/screens/main/explore/widget/more_card_button.dart';

class MostDrunkenBeerCountryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kCardHeight,
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        image: DecorationImage(
          image: const AssetImage('assets/images/beer-country.jpg'),
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
          Spacer(flex: 2),
          Text(
            'Pays le plus apprecié',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'France',
            style: Theme.of(context).textTheme.headline4!.copyWith(
              color: Colors.white,
            ),
          ),
          Spacer(flex: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bue 56 fois',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
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
