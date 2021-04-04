import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/generated/l10n.dart';
import 'package:hoppy/store/store.dart';
import 'package:hoppy/widget/widget.dart';

class BeerFilterStyleSelector extends StatelessWidget {
  final Selectable<BeerStyle> style;

  const BeerFilterStyleSelector({
    required this.style,
  });

  void _onStyleSelected(BuildContext context) {
    if (style.selected) {
      context.read<SearchCubit>().removeBeerStyleFilter(style.value);
    } else {
      context.read<SearchCubit>().addBeerStyleFilter(style.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        Localization.of(context).beer_style(style.value.key),
      ),
      contentPadding: const EdgeInsets.all(0),
      onTap: () => _onStyleSelected(context),
      trailing: CustomCheckbox(
        checked: style.selected,
        onChanged: (_) => _onStyleSelected(context),
      ),
    );
  }
}
