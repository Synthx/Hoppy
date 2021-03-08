import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/screens/main/search/search_state.dart';
import 'package:hoppy/screens/screens.dart';
import 'package:hoppy/widget/widget.dart';

import 'search_cubit.dart';

class SearchView extends StatefulWidget {
  @override
  State createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final ScrollController _scrollController = ScrollController(
    initialScrollOffset: 0,
  );

  Future<void> _openBeerDetailDialog(Beer beer) async {
    final needChanges = await Navigator.push<bool?>(
      context,
      BeerDetailDialog.route(beer),
    );

    if (needChanges != null) {
      context.read<SearchCubit>().search();
    }
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final position = _scrollController.position.userScrollDirection;
    if (maxScroll - currentScroll <= 200 &&
        position == ScrollDirection.forward &&
        !context.read<SearchCubit>().state.loading) {
      print('next page');
    }
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
    return BlocProvider<SearchCubit>(
      create: (_) => SearchCubit(
        beerRepository: getIt(),
      )..search(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Rechercher'),
        ),
        body: Scrollbar(
          isAlwaysShown: true,
          controller: _scrollController,
          child: BlocBuilder<SearchCubit, SearchState>(
            buildWhen: (prev, curr) => prev.loading != curr.loading,
            builder: (context, state) {
              final beers = state.beers;
              return ListView(
                controller: _scrollController,
                children: [
                  TextButton(
                    onPressed: null,
                    child: Text('Classement par ordre d\'ajout'),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 20,
                      bottom: max(MediaQuery.of(context).padding.bottom, 20),
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                        onTap: () => _openBeerDetailDialog(beer),
                        beer: beer,
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
