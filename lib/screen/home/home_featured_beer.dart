import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/data/data.dart';

import 'home_store.dart';

class HomeFeaturedBeer extends StatelessWidget {
  const HomeFeaturedBeer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeStore, HomeState, Beer?>(
      selector: (state) => state.featuredBeer,
      builder: (context, featuredBeer) {
        if (featuredBeer == null) {
          return const SliverToBoxAdapter();
        }

        return const SliverToBoxAdapter(
          child: Placeholder(),
        );
      },
    );
  }
}
