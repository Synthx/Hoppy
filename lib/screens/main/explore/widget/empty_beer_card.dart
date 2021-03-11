import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/store/store.dart';

class EmptyBeerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticCubit, StatisticState>(
      buildWhen: (prev, curr) =>
          prev.beerStatistic.count != curr.beerStatistic.count,
      builder: (context, state) {
        if (state.beerStatistic.count > 0) {
          return Container();
        }

        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
          ),
          height: kCardHeight - 30,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.85),
            borderRadius: BorderRadius.circular(kDefaultRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  children: [
                    Text(
                      'N\'attendez plus !',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Ajouter des bières dès maintenant et découvrez Hoppy',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Colors.white.withOpacity(0.8),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Ajouter une bière'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(kDefaultRadius),
                    bottomRight: Radius.circular(kDefaultRadius),
                  ),
                  child: Image.asset(
                    'assets/images/empty-beer.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
