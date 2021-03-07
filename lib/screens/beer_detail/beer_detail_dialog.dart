import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/screens/screens.dart';
import 'package:hoppy/store/store.dart';
import 'package:hoppy/widget/widget.dart';

import 'beer_detail_cubit.dart';

class BeerDetailDialog extends StatefulWidget {
  static route(Beer beer) => MaterialPageRoute<bool?>(
        builder: (_) => BeerDetailDialog(
          beer: beer,
        ),
        fullscreenDialog: true,
      );

  final Beer beer;

  const BeerDetailDialog({
    required this.beer,
  });

  @override
  _BeerDetailDialogState createState() => _BeerDetailDialogState();
}

class _BeerDetailDialogState extends State<BeerDetailDialog> {
  void _closeDialog() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BeerDetailCubit>(
      create: (_) => BeerDetailCubit(
        beerRepository: getIt(),
        settingsCubit: context.read(),
      ),
      child: Scaffold(
        floatingActionButton: Container(
          margin: const EdgeInsets.only(
            top: 10,
            right: 10,
          ),
          width: 44,
          height: 44,
          child: FloatingActionButton(
            onPressed: () => _closeDialog(),
            child: Icon(Icons.clear),
            backgroundColor: Colors.black.withOpacity(0.4),
            elevation: 1,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        backgroundColor: Theme.of(context).cardColor,
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 64,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Check-in'),
            ),
          ),
        ),
        body: Column(
          children: [
            BeerImage(
              beer: widget.beer,
            ),
            BeerInformation(
              beer: widget.beer,
            ),
            BeerDrinkedInformation(
              beer: widget.beer,
            ),
            BeerActions(
              beer: widget.beer,
            ),
            Text(
              'Ajoutée le ${widget.beer.creationDate}',
            ),
          ],
        ),
      ),
    );
  }
}

class BeerFavoriteButton extends StatelessWidget {
  final Beer beer;

  const BeerFavoriteButton({
    required this.beer,
  });

  void _onTap(BuildContext context, bool isInFavorite) {
    if (isInFavorite) {
      context.read<FavoriteCubit>().removeBeer(beer);
    } else {
      context.read<FavoriteCubit>().addBeer(beer);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      buildWhen: (prev, curr) => prev.beers != curr.beers,
      builder: (context, state) {
        final isInFavorite = state.beers.contains(beer);
        return IconButton(
          icon: Icon(isInFavorite ? Icons.favorite : Icons.favorite_outline),
          onPressed: () => _onTap(context, isInFavorite),
          color: isInFavorite ? Colors.red : null,
        );
      },
    );
  }
}

class BeerDrinkedInformation extends StatelessWidget {
  final Beer beer;

  const BeerDrinkedInformation({
    required this.beer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}

class BeerInformation extends StatelessWidget {
  final Beer beer;

  const BeerInformation({
    required this.beer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 40,
        left: 20,
        right: 20,
        bottom: 20,
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            beer.style.name,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 16,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            beer.name,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 26,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            '${beer.color.name} - ${beer.degree}°',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 16,
                ),
          ),
          const SizedBox(height: 5),
          Text(
            beer.country.name,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 16,
                ),
          ),
        ],
      ),
    );
  }
}

class BeerImage extends StatelessWidget {
  final Beer beer;

  const BeerImage({
    required this.beer,
  });

  void _openNewCheckInDialog(BuildContext context) {
    Navigator.push(
      context,
      NewCheckInDialog.route(beer),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final containerHeight = MediaQuery.of(context).size.height / 2;
    return Container(
      height: containerHeight,
      width: screenWidth,
      child: Stack(
        children: [
          BeerImagePreview(
            height: containerHeight,
            imagePath: beer.picturePath,
            radius: 0,
          ),
        ],
      ),
    );
  }
}

class BeerActions extends StatelessWidget {
  final Beer beer;

  const BeerActions({
    required this.beer,
  });

  void _askDeleteConfirmationPopup(BuildContext context) {
    context.read<BeerDetailCubit>().delete(beer);
  }

  void _openEditBeerDialog(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        children: [
          Flexible(
            child: OutlinedButton(
              onPressed: () => _openEditBeerDialog(context),
              child: Icon(
                Icons.edit_outlined,
                color: Theme.of(context).textTheme.bodyText2!.color,
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(60),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: OutlinedButton(
              onPressed: () => _askDeleteConfirmationPopup(context),
              child: const Icon(
                Icons.delete_outlined,
                color: Colors.red,
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(60),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
