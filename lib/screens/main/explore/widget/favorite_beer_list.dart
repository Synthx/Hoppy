import 'package:flutter/material.dart' hide AnimatedIcon;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/screens/main/main.dart';
import 'package:hoppy/screens/screens.dart';
import 'package:hoppy/store/store.dart';
import 'package:hoppy/widget/widget.dart';

class FavoriteBeerList extends StatelessWidget {
  void _openBeerDetailDialog(BuildContext context, Beer beer) {
    Navigator.push(
      context,
      BeerDetailDialog.route(beer),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
          ),
          child: Text(
            'On se refait une valeure sûre ?',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        const SizedBox(height: 20),
        BlocBuilder<FavoriteCubit, FavoriteState>(
          buildWhen: (prev, curr) => prev.beers.length != curr.beers.length,
          builder: (context, state) {
            if (state.beers.isEmpty) {
              return _EmptyFavoriteCard();
            }

            var beers = state.beers;
            beers.shuffle();
            beers = beers.take(4).toList();
            return Container(
              height: 280,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                ),
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, _) => const SizedBox(width: 20),
                itemCount: beers.length,
                itemBuilder: (context, index) {
                  final beer = beers[index];

                  return Container(
                    width: 180,
                    child: BeerCard(
                      beer: beer,
                      onTap: () => _openBeerDetailDialog(context, beer),
                    ),
                  );
                },
              ),
            );
          },
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class _EmptyFavoriteCard extends StatelessWidget {
  void _goToSearchView(BuildContext context) {
    context.read<MainScreenCubit>().changePage(1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
      ),
      width: double.infinity,
      child: Column(
        children: [
          AnimatedIcon(
            icon: Text(
              '💡',
              style: TextStyle(fontSize: 50, color: Colors.black),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Pas encore de favoris ?',
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            'Ajoutez dès maintenant des bières en favoris pour les retrouver plus facilement',
            style: Theme.of(context).textTheme.bodyText2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Container(
            height: 40,
            child: ElevatedButton(
              onPressed: () => _goToSearchView(context),
              child: Text('Rechercher des bières'),
            ),
          ),
        ],
      ),
    );
  }
}
