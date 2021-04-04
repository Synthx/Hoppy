import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/generated/l10n.dart';
import 'package:hoppy/store/store.dart';

import 'beer_filter_color.dart';
import 'beer_filter_country.dart';
import 'beer_filter_degree.dart';
import 'beer_filter_other.dart';
import 'beer_filter_style.dart';

class SearchBeerFilterDialog extends StatefulWidget {
  static MaterialPageRoute route() => MaterialPageRoute(
        builder: (_) => SearchBeerFilterDialog(),
        fullscreenDialog: true,
      );

  @override
  _SearchBeerFilterDialogState createState() => _SearchBeerFilterDialogState();
}

class _SearchBeerFilterDialogState extends State<SearchBeerFilterDialog> {
  void _closeDialog() {
    context.pop();
  }

  void _search() {
    context.pop(true);
  }

  void _resetFilter() {
    context.read<SearchCubit>().resetFilter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Localization.of(context).filter,
        ),
        leading: IconButton(
          onPressed: () => _closeDialog(),
          icon: const Icon(Icons.clear),
        ),
        actions: [
          TextButton(
            onPressed: () => _resetFilter(),
            style: TextButton.styleFrom(
              primary: Theme.of(context).textTheme.bodyText1!.color,
            ),
            child: Text(
              Localization.of(context).reset,
            ),
          ),
        ],
      ),
      body: Scrollbar(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            vertical: kDefaultPadding,
          ),
          children: [
            BeerFilterColor(),
            const SizedBox(height: 10),
            BeerFilterStyle(),
            const SizedBox(height: 10),
            BeerFilterDegree(),
            const SizedBox(height: 10),
            BeerFilterCountry(),
            const SizedBox(height: 10),
            BeerFilterOther(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: kFooterButtonHeight,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
            vertical: 10,
          ),
          child: ElevatedButton(
            onPressed: () => _search(),
            child: Text(
              Localization.of(context).search,
            ),
          ),
        ),
      ),
    );
  }
}
