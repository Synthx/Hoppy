import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/screens/screens.dart';
import 'package:hoppy/store/cubit/cubit.dart';
import 'package:hoppy/store/store.dart';
import 'package:hoppy/widget/widget.dart';

import 'favorite.dart';

class FavoriteView extends StatefulWidget {
  @override
  State createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  void _openBeerDetailDialog(Beer beer) {
    Navigator.push(
      context,
      BeerDetailDialog.route(beer),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoris'),
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        buildWhen: (prev, curr) => prev.beers != curr.beers,
        builder: (context, state) {
          final beers = state.beers;
          if (beers.isEmpty) {
            return EmptyFavorite();
          }

          return GridView.builder(
            padding: EdgeInsets.only(
              top: kDefaultPadding,
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: max(
                MediaQuery.of(context).padding.bottom,
                kDefaultPadding,
              ),
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: kBeerCardAspectRatio,
            ),
            physics: const BouncingScrollPhysics(),
            itemCount: beers.length,
            itemBuilder: (context, index) {
              final beer = beers[index];
              return BeerCard(
                onTap: () => _openBeerDetailDialog(beer),
                beer: beer,
              );
            },
          );
        },
      ),
    );
  }
}
