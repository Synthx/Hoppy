import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/generated/l10n.dart';
import 'package:hoppy/store/store.dart';
import 'package:hoppy/widget/widget.dart';

class BeerFilterCountrySelector extends StatelessWidget {
  final Selectable<BeerCountry> country;

  const BeerFilterCountrySelector({
    required this.country,
  });

  void _onCountrySelected(BuildContext context) {
    if (country.selected) {
      context.read<SearchCubit>().removeBeerCountryFilter(country.value);
    } else {
      context.read<SearchCubit>().addBeerCountryFilter(country.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        Localization.of(context).beer_country(country.value.key),
      ),
      contentPadding: const EdgeInsets.all(0),
      onTap: () => _onCountrySelected(context),
      trailing: CustomCheckbox(
        checked: country.selected,
        onChanged: (_) => _onCountrySelected(context),
      ),
    );
  }
}
