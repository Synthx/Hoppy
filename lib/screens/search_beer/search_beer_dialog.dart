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
    final checkIn = await Navigator.push(
      context,
      NewCheckInDialog.route(beer),
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final position = _scrollController.position.userScrollDirection;
    if (maxScroll - currentScroll <= 200 &&
        position == ScrollDirection.forward &&
        !context.read<SearchBeerCubit>().state.loading) {
      print('next page');
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
          if (state.beers != null) {
            if (state.beers!.isEmpty) {
              return NoBeersFound();
            } else {
              final beers = state.beers!;
              return Scrollbar(
                controller: _scrollController,
                isAlwaysShown: true,
                child: GridView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                    bottom: max(MediaQuery.of(context).padding.bottom, 20),
                  ),
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
              );
            }
          } else {
            return WaitingForKeyword();
          }
        },
      ),
    );
  }
}

class NoBeersFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Oops, nous sommes à sec',
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              'Impossible de trouver des bières correspondantes, vérifiez l\'orthogrape ou ajoutez-la.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class WaitingForKeyword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Alors c\'est laquelle ?',
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              'Recherchez la bière que vous venez de boire et commencer un nouveau check-in.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class SearchInput extends StatefulWidget with PreferredSizeWidget {
  final Function(String?) onValueChanged;

  const SearchInput({
    required this.onValueChanged,
  });

  @override
  Size get preferredSize => Size.fromHeight(48);

  @override
  State createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focus = FocusNode();
  bool showCancelButton = false;
  bool showResetButton = false;

  void _cancelAction() {
    _focus.unfocus();
  }

  void _resetValue() {
    _controller.text = '';
    _focus.unfocus();
    widget.onValueChanged(null);
  }

  void _onFieldSubmitted(String value) {
    widget.onValueChanged(value);
  }

  void _onFocusChanged() {
    setState(() {
      showCancelButton = _focus.hasFocus;
    });
  }

  void _onTextChanged() {
    setState(() {
      showResetButton = _controller.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChanged);
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Icon(Icons.search),
                  const SizedBox(width: 10),
                  Flexible(
                    child: TextField(
                      controller: _controller,
                      focusNode: _focus,
                      autocorrect: false,
                      enableSuggestions: false,
                      onSubmitted: (value) => _onFieldSubmitted(value),
                      decoration: const InputDecoration(
                        hintText: 'Paix Dieu, Anosteke, ...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  if (_controller.value.text.isNotEmpty)
                    IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () => _resetValue(),
                    ),
                ],
              ),
            ),
          ),
          if (showCancelButton)
            TextButton(
              onPressed: () => _cancelAction(),
              child: Text(
                'Annuler',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(),
              ),
            ),
        ],
      ),
    );
  }
}
