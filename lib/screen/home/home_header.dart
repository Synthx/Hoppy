import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    const actionHeight = 100.0;
    const headerHeight = 400.0;
    const logoWidth = 240.0;

    return SliverAppBar(
      snap: false,
      pinned: false,
      floating: false,
      stretch: true,
    );
  }
}
