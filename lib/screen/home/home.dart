import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';

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
            body: Center(
              child: Text('Hello Front(end | &) Beers'),
            ),
          );
        },
      ),
    );
  }
}
