import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/generated/l10n.dart';
import 'package:hoppy/store/store.dart';

import 'beer_filter_constants.dart';

class BeerFilterDegree extends StatelessWidget {
  void _degreeRangeChanged(BuildContext context, RangeValues degreeRange) {
    context.read<SearchCubit>().setDegreeRangeFilter(degreeRange);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Localization.of(context).beer_filter_degree,
            style: beerFilterTitleStyle(context),
          ),
          const SizedBox(height: 20),
          BlocBuilder<SearchCubit, SearchState>(
            buildWhen: (prev, curr) =>
                prev.filter.degreeRange != curr.filter.degreeRange,
            builder: (context, state) {
              final range = state.filter.degreeRange;
              return RangeSlider(
                values: range,
                min: 0,
                max: 100,
                divisions: 100,
                labels: RangeLabels(
                  range.start.round().toString(),
                  range.end.round().toString(),
                ),
                onChanged: (range) => _degreeRangeChanged(context, range),
                activeColor: Theme.of(context).primaryColor,
                inactiveColor: Theme.of(context).backgroundColor,
              );
            },
          ),
        ],
      ),
    );
  }
}
