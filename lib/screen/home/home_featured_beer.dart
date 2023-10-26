import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';

import 'home_section.dart';
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

        return HomeSection(
          title: context.t.homeFeaturedBeerTitle,
          subtitle: context.t.homeFeaturedBeerSubTitle,
          child: Container(
            height: 400,
            decoration: BoxDecoration(
              color:
                  featuredBeer.backgroundColor ?? Theme.of(context).cardColor,
            ),
            padding: const EdgeInsets.all(20),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    featuredBeer.content.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleLarge?.copyWith(
                      color: featuredBeer.textColor ?? context.primaryColor,
                      fontSize: 45,
                    ),
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assets/images/beers/${featuredBeer.id}.webp',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
