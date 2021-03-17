import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart' hide BeerStatistic;
import 'package:hoppy/widget/widget.dart';

import 'beer_detail.dart';

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
    context.pop();
  }

  Future<void> _onBeerDeleted() async {
    await context.showSuccessDialog(
      title: 'Bière supprimée avec succès',
      content: 'Espérons que ce soit juste une erreur...',
      icon: Icon(Icons.check),
    );
    context.pop(true);
  }

  void _onLoadingChanged() {
    print('loading changed');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BeerDetailCubit>(
      create: (_) => BeerDetailCubit(
        beerRepository: getIt(),
        statisticCubit: context.read(),
      )..load(widget.beer.id!),
      child: MultiBlocListener(
        listeners: [
          BlocListener<BeerDetailCubit, BeerDetailState>(
            listenWhen: (prev, curr) => prev.loading != curr.loading,
            listener: (_, state) => _onLoadingChanged(),
          ),
          BlocListener<BeerDetailCubit, BeerDetailState>(
            listenWhen: (prev, curr) =>
                prev.beer != curr.beer &&
                curr.beer == null &&
                prev.beer != null,
            listener: (_, __) => _onBeerDeleted(),
          ),
        ],
        child: Scaffold(
          floatingActionButton: MiniFabButton(
            icon: Icon(Icons.clear),
            onTap: () => _closeDialog(),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          bottomNavigationBar: BeerDetailDialogFooter(),
          extendBody: true,
          body: BeerDetailDialogBody(),
        ),
      ),
    );
  }
}
