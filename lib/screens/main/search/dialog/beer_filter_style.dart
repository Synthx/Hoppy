import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/screens/main/search/dialog/beer_filter_style_dialog.dart';
import 'package:hoppy/store/store.dart';
import 'package:hoppy/widget/widget.dart';

class BeerFilterStyle extends StatelessWidget {
  void _onStyleSelected(BuildContext context, Selectable<BeerStyle> style) {
    if (style.selected) {
      context.read<SearchCubit>().removeBeerStyleFilter(style.value);
    } else {
      context.read<SearchCubit>().addBeerStyleFilter(style.value);
    }
  }

  void _openBeerFilterStyleDialog(BuildContext context) {
    Navigator.push(
      context,
      BeerFilterStyleDialog.route(),
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
            'Style de bière',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontSize: 18,
                ),
          ),
          const SizedBox(height: 20),
          BlocBuilder<SearchCubit, SearchState>(
            buildWhen: (prev, curr) =>
                prev.filter.styles.length != curr.filter.styles.length,
            builder: (context, state) {
              final selectedStyles = state.filter.styles;
              final styles = BeerStyle.values.take(3).map((e) => Selectable(
                    value: e,
                    selected: selectedStyles.contains(e),
                  ));
              return Column(
                children: styles
                    .map((e) => ListTile(
                          title: Text(e.value.name),
                          contentPadding: const EdgeInsets.all(0),
                          onTap: () => _onStyleSelected(context, e),
                          trailing: CustomCheckbox(
                            checked: e.selected,
                            onChanged: (_) => _onStyleSelected(context, e),
                          ),
                        ))
                    .toList(),
              );
            },
          ),
          const SizedBox(height: 10),
          UnderlineTextButton(
            text: 'Afficher tous les styles',
            onTap: () => _openBeerFilterStyleDialog(context),
          ),
        ],
      ),
    );
  }
}
