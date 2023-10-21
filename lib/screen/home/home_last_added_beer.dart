import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/data/data.dart';

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

        return Placeholder();
      },
    );
  }
}
