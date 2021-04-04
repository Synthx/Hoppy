import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/generated/l10n.dart';
import 'package:hoppy/store/store.dart';

import 'beer_filter_country_selector.dart';

class BeerFilterCountryDialog extends StatelessWidget {
  static MaterialPageRoute route() => MaterialPageRoute(
        builder: (_) => BeerFilterCountryDialog(),
      );

  void _closeDialog(BuildContext context) {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Localization.of(context).beer_filter_countries,
        ),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => _closeDialog(context),
        ),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        buildWhen: (prev, curr) =>
            prev.filter.countries.length != curr.filter.countries.length,
        builder: (context, state) {
          final selectedCountries = state.filter.countries;
          final countries = BeerCountry.values
              .map((e) => Selectable(
                    value: e,
                    selected: selectedCountries.contains(e),
                  ))
              .toList();
          return ListView.builder(
            padding: const EdgeInsets.all(kDefaultPadding),
            physics: const BouncingScrollPhysics(),
            itemCount: countries.length,
            itemBuilder: (context, index) {
              final country = countries[index];
              return BeerFilterCountrySelector(
                country: country,
              );
            },
          );
        },
      ),
    );
  }
}
