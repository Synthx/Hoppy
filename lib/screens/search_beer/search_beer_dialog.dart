import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/screens/screens.dart';
import 'package:hoppy/widget/widget.dart';

import 'search_beer_cubit.dart';
import 'search_beer_state.dart';
import 'widget/no_beers_found.dart';
import 'widget/search_input.dart';
import 'widget/waiting_for_keyword.dart';

class SearchBeerDialog extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => BlocProvider<SearchBeerCubit>(
          create: (_) => SearchBeerCubit(
            beerRepository: getIt(),
          ),
          child: SearchBeerDialog(),
        ),
        fullscreenDialog: true,
      );

  @override
  State createState() => _SearchBeerDialogState();
}

class _SearchBeerDialogState extends State<SearchBeerDialog> {
  final ScrollController _scrollController = ScrollController(
    initialScrollOffset: 0,
  );

  void _closeDialog() {
    Navigator.pop(context);
  }

  Future<void> _openAddBeerDialog() async {
    final beer = await Navigator.push<Beer?>(
      context,
      AddBeerDialog.route(),
    );

    if (beer != null) {
      await _openNewCheckInDialog(beer);
    }
  }

  Future<void> _openNewCheckInDialog(Beer beer) async {
    final checkIn = await Navigator.push<CheckIn?>(
      context,
      NewCheckInDialog.route(beer),
    );

    if (checkIn != null) {
      Navigator.pop(context);
    }
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final position = _scrollController.position.userScrollDirection;

    final cubit = context.read<SearchBeerCubit>();

    if (maxScroll - currentScroll <= 200 &&
        position == ScrollDirection.reverse &&
        !cubit.state.loading &&
        cubit.state.beers != null &&
        cubit.state.beers!.length < cubit.state.maxSize) {
      cubit.nextPage();
    }
  }

  void _onKeywordChanged(String? value) {
    context.read<SearchBeerCubit>().keywordChanged(value);
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rechercher'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => _closeDialog(),
        ),
        bottom: SearchInput(
          onValueChanged: (value) => _onKeywordChanged(value),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddBeerDialog(),
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: BlocBuilder<SearchBeerCubit, SearchBeerState>(
        builder: (context, state) {
          if (state.beers == null) {
            return WaitingForKeyword();
          }

          if (state.beers!.isEmpty && state.loading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            );
          }

          if (state.beers!.isEmpty && !state.loading) {
            return NoBeersFound();
          }

          final beers = state.beers!;
          return Scrollbar(
            controller: _scrollController,
            isAlwaysShown: true,
            child: ListView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: max(MediaQuery.of(context).padding.bottom, 20),
              ),
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 4 / 7,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: beers.length,
                  itemBuilder: (context, index) {
                    final beer = beers[index];
                    return BeerCard(
                      onTap: () => _openNewCheckInDialog(beer),
                      beer: beer,
                    );
                  },
                ),
                if (state.loading)
                  Container(
                    padding: const EdgeInsets.only(
                      bottom: 100,
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
