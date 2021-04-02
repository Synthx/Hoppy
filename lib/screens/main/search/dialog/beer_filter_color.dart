import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/store/store.dart';
import 'package:hoppy/widget/widget.dart';

class BeerFilterColor extends StatelessWidget {
  void _onColorSelected(BuildContext context, Selectable<BeerColor> color) {
    if (color.selected) {
      context.read<SearchCubit>().removeBeerColorFilter(color.value);
    } else {
      context.read<SearchCubit>().addBeerColorFilter(color.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: kDefaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
            ),
            child: Text(
              'Couleurs',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: 18,
                  ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 100,
            child: BlocBuilder<SearchCubit, SearchState>(
              buildWhen: (prev, curr) =>
                  prev.filter.colors.length != curr.filter.colors.length,
              builder: (context, state) {
                final selectedColors = state.filter.colors;
                final colors = BeerColor.values
                    .map((e) => Selectable(
                          value: e,
                          selected: selectedColors.contains(e),
                        ))
                    .toList();
                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 15);
                  },
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: colors.length,
                  itemBuilder: (context, index) {
                    final color = colors[index];
                    return BeerColorPreview(
                      beerColor: color.value,
                      isSelected: color.selected,
                      onTap: () => _onColorSelected(context, color),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
