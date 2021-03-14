import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/store/store.dart';

class BeerFavoriteIconButton extends StatelessWidget {
  final Beer beer;
  final double size;

  const BeerFavoriteIconButton({
    required this.beer,
    this.size = 24,
  });

  void _addToFavorite(BuildContext context) {
    context.read<FavoriteCubit>().addBeer(beer);
  }

  void _removeFromFavorite(BuildContext context) {
    context.read<FavoriteCubit>().removeBeer(beer);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      buildWhen: (prev, curr) => prev.beers.length != curr.beers.length,
      builder: (context, state) {
        if (state.beers.contains(beer)) {
          return IconButton(
            icon: Icon(
              Icons.favorite,
              color: kRedColor,
            ),
            iconSize: size,
            onPressed: () => _removeFromFavorite(context),
          );
        }

        return IconButton(
          onPressed: () => _addToFavorite(context),
          icon: Icon(
            Icons.favorite_outline,
            color: Colors.white.withOpacity(0.8),
          ),
          iconSize: size,
        );
      },
    );
  }
}
