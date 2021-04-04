import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/generated/l10n.dart';
import 'package:hoppy/store/store.dart';
import 'package:hoppy/widget/widget.dart';

import '../beer_filter_constants.dart';
import 'beer_filter_country_dialog.dart';
import 'beer_filter_country_selector.dart';

class BeerFilterCountry extends StatelessWidget {
  void _openBeerFilterCountryDialog(BuildContext context) {
    Navigator.push(
      context,
      BeerFilterCountryDialog.route(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Localization.of(context).beer_filter_countries,
            style: beerFilterTitleStyle(context),
          ),
          const SizedBox(height: 20),
          BlocBuilder<SearchCubit, SearchState>(
            buildWhen: (prev, curr) =>
                prev.filter.countries.length != curr.filter.countries.length,
            builder: (context, state) {
              final selectedCountries = state.filter.countries;
              final countries =
                  BeerCountry.values.take(3).map((e) => Selectable(
                        value: e,
                        selected: selectedCountries.contains(e),
                      ));
              return Column(
                children: countries
                    .map((e) => BeerFilterCountrySelector(
                          country: e,
                        ))
                    .toList(),
              );
            },
          ),
          const SizedBox(height: 10),
          UnderlineTextButton(
            text: Localization.of(context).beer_filter_countries_all,
            onTap: () => _openBeerFilterCountryDialog(context),
          ),
        ],
      ),
    );
  }
}
