import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';

import 'home_countries.dart';
import 'home_featured_beer.dart';
import 'home_footer.dart';
import 'home_header.dart';
import 'home_hook.dart';
import 'home_last_added_beer.dart';
import 'home_store.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeStore(
        beerService: getIt(),
      )..init(),
      child: BlocSelector<HomeStore, HomeState, bool>(
        selector: (state) => state.loading,
        builder: (context, loading) {
          if (loading) {
            return Scaffold(
              backgroundColor: const Color(0xFFFFE914),
              body: Center(
                child: Image.asset(
                  'assets/images/loader.gif',
                  width: 300,
                ),
              ),
            );
          }

          return const Scaffold(
            body: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                HomeHeader(),
                HomeCountriesList(),
                HomeHook(),
                HomeFeaturedBeer(),
                HomeLastAddedBeers(),
                HomeFooter(),
              ],
            ),
          );
        },
      ),
    );
  }
}
