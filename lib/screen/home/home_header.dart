import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/theme/theme.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      snap: false,
      pinned: false,
      floating: false,
      stretch: true,
      collapsedHeight: 400 + context.topSafeArea,
      expandedHeight: 400 + context.topSafeArea,
      flexibleSpace: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 50,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/backgrounds/home.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: kSpacer + context.topSafeArea,
            left: kSafeArea,
            right: kSafeArea,
            bottom: 120,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 240,
                ),
                const Spacer(),
                Text(
                  context.t.homeHeaderHello('Pinpin'.toUpperCase()),
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
                Text(
                  context.t.homeHeaderHelloIntro,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 15,
            right: 15,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: context.primaryColor,
              ),
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          context.t.homeHeaderActionTitle,
                          style: context.textTheme.titleSmall?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          context.t.homeHeaderActionContent,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: kSpacer),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 38,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
