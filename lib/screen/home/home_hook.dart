import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/theme/theme.dart';

import 'home_store.dart';

class HomeHook extends StatelessWidget {
  const HomeHook({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final textWidth = screenWidth * 0.6;

    const pictureWidth = 230.0;
    final picturePosition = pictureWidth - (screenWidth - textWidth);

    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Container(
            width: textWidth,
            padding: const EdgeInsets.symmetric(
              vertical: kSpacer,
              horizontal: kSafeArea,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.t.homeHookTitle,
                  style: context.textTheme.titleLarge?.copyWith(),
                ),
                const SizedBox(height: kSpacer),
                Text(
                  context.t.homeHookContent,
                  style: context.textTheme.bodySmall?.copyWith(),
                ),
                const SizedBox(height: kSpacer),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Découvrir'),
                ),
              ],
            ),
          ),
          Positioned(
            top: 60,
            right: -picturePosition,
            child: Image.asset(
              'assets/images/backgrounds/home-hook.jpg',
              fit: BoxFit.cover,
              height: 280,
              width: pictureWidth,
            ),
          ),
          Positioned(
            bottom: kSpacer,
            right: kSpacer,
            child: Column(
              children: [
                BlocSelector<HomeStore, HomeState, int>(
                  selector: (state) => state.totalBeers,
                  builder: (context, count) {
                    return Text(
                      '$count',
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontSize: 50,
                        height: 1,
                      ),
                    );
                  },
                ),
                Text(
                  context.t.homeHookStatistic,
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.secondaryColor,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
