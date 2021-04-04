import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/generated/l10n.dart';
import 'package:hoppy/store/store.dart';
import 'package:hoppy/widget/widget.dart';

import '../beer_filter_constants.dart';
import 'beer_filter_style_dialog.dart';
import 'beer_filter_style_selector.dart';

class BeerFilterStyle extends StatelessWidget {
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
            Localization.of(context).beer_filter_styles,
            style: beerFilterTitleStyle(context),
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
                    .map((e) => BeerFilterStyleSelector(
                          style: e,
                        ))
                    .toList(),
              );
            },
          ),
          const SizedBox(height: 10),
          UnderlineTextButton(
            text: Localization.of(context).beer_filter_styles_all,
            onTap: () => _openBeerFilterStyleDialog(context),
          ),
        ],
      ),
    );
  }
}
