import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/theme/theme.dart';
import 'package:hoppy/widget/widget.dart';

import 'home_section.dart';
import 'home_store.dart';

class HomeLastAddedBeers extends StatelessWidget {
  const HomeLastAddedBeers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeStore, HomeState, List<Beer>>(
      selector: (state) => state.lastAddedBeers,
      builder: (context, lastAddedBeers) {
        if (lastAddedBeers.isEmpty) {
          return const SliverToBoxAdapter();
        }

        return HomeSection(
          title: context.t.homeLastAddedBeersTitle,
          subtitle: context.t.homeLastAddedBeersSubtitle,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: kSafeArea,
            ),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: lastAddedBeers.length,
            itemBuilder: (context, index) {
              return BeerCard(
                beer: lastAddedBeers[index],
              );
            },
          ),
        );
      },
    );
  }
}
