import 'package:flutter/material.dart' hide AnimatedIcon;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/store/store.dart';
import 'package:hoppy/widget/widget.dart';

class FavoriteBeerList extends StatelessWidget {
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
            return _EmptyFavoriteCard();
          },
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class _EmptyFavoriteCard extends StatelessWidget {
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
            icon: Text('💡', style: TextStyle(fontSize: 50)),
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
              onPressed: () {},
              child: Text('Rechercher des bières'),
            ),
          ),
        ],
      ),
    );
  }
}
