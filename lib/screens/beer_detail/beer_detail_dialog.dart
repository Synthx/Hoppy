import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';

import 'beer_detail_cubit.dart';
import 'beer_detail_state.dart';
import 'widget/beer_actions.dart';
import 'widget/beer_image.dart';
import 'widget/beer_information.dart';

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

  void _onLoadingChanged(bool loading) {
    if (loading) {
      context.showLoadingDialog();
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BeerDetailCubit>(
      create: (_) => BeerDetailCubit(
        beerRepository: getIt(),
        statisticCubit: context.read(),
      ),
      child: MultiBlocListener(
        listeners: [
          BlocListener<BeerDetailCubit, BeerDetailState>(
            listenWhen: (prev, curr) => prev.loading != curr.loading,
            listener: (_, state) => _onLoadingChanged(state.loading),
          ),
          BlocListener<BeerDetailCubit, BeerDetailState>(
            listenWhen: (prev, curr) =>
                prev.deleted != curr.deleted &&
                curr.deleted != null &&
                curr.deleted!,
            listener: (_, __) => _onBeerDeleted(),
          ),
        ],
        child: Scaffold(
          floatingActionButton: Container(
            margin: const EdgeInsets.only(
              top: 15,
              right: 15,
            ),
            width: 44,
            height: 44,
            child: FloatingActionButton(
              onPressed: () => _closeDialog(),
              child: Icon(Icons.clear),
              backgroundColor: Colors.black.withOpacity(0.35),
              elevation: 1,
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          bottomNavigationBar: BottomAppBar(
            elevation: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
              ),
              child: Container(
                height: kFooterButtonHeight,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Check-in'),
                ),
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
      ),
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
