import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/screens/screens.dart';
import 'package:hoppy/store/store.dart';
import 'package:hoppy/widget/widget.dart';

class SearchView extends StatefulWidget {
  @override
  State createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController(
    initialScrollOffset: 0,
  );

  void _openBeerDetailDialog(Beer beer) {
    Navigator.push<bool?>(
      context,
      BeerDetailDialog.route(beer),
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final position = _scrollController.position.userScrollDirection;

    final cubit = context.read<SearchCubit>();

    if (maxScroll - currentScroll <= kInfiniteScrollDifference &&
        position == ScrollDirection.reverse &&
        !cubit.state.loading &&
        cubit.state.totalElements != null &&
        cubit.state.beers.length < cubit.state.totalElements!) {
      cubit.nextPage();
    }
  }

  Future<void> _onRefresh() async {
    await context.read<SearchCubit>().search();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<SearchCubit>().search();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rechercher'),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          final beers = state.beers;
          return RefreshIndicator(
            onRefresh: () => _onRefresh(),
            backgroundColor: Theme.of(context).cardColor,
            color: Theme.of(context).primaryColor,
            child: Scrollbar(
              controller: _scrollController,
              child: ListView(
                controller: _scrollController,
                padding: EdgeInsets.only(
                  top: kDefaultPadding,
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  bottom: max(
                    MediaQuery.of(context).padding.bottom,
                    kDefaultPadding,
                  ),
                ),
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: kBeerCardAspectRatio,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: beers.length,
                    itemBuilder: (context, index) {
                      final beer = beers[index];
                      return BeerCard(
                        onTap: () => _openBeerDetailDialog(beer),
                        beer: beer,
                      );
                    },
                  ),
                  if (state.loading)
                    Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
