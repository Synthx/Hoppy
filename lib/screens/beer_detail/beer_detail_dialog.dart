import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart' hide BeerStatistic;
import 'package:hoppy/screens/screens.dart';
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

  void _openNewCheckInDialog() {
    Navigator.push(
      context,
      NewCheckInDialog.route(widget.beer),
    );
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
          floatingActionButton: MiniFabButton(
            icon: Icon(Icons.clear),
            onTap: () => _closeDialog(),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          bottomNavigationBar: BottomAppBar(
            elevation: 0,
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
              ),
              child: Container(
                height: kFooterButtonHeight,
                child: ElevatedButton(
                  onPressed: () => _openNewCheckInDialog(),
                  child: const Text('Check-in'),
                ),
              ),
            ),
          ),
          extendBody: true,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: kFooterButtonHeight + 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BeerImage(
                    beer: widget.beer,
                  ),
                  const SizedBox(height: 40),
                  BeerInformation(
                    beer: widget.beer,
                  ),
                  const SizedBox(height: 20),
                  BeerStatistic(
                    beer: widget.beer,
                  ),
                  const SizedBox(height: 20),
                  BeerActions(
                    beer: widget.beer,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!
                              .creation_date(widget.beer.creationDate),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          AppLocalizations.of(context)!
                              .last_modified_date(widget.beer.lastModifiedDate),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
