import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/theme/theme.dart';

class HomeSection extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;

  const HomeSection({
    required this.title,
    required this.child,
    this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        vertical: kSpacer,
      ),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kSafeArea,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.titleLarge?.copyWith(
                      color: context.secondaryColor,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle ?? '',
                    ),
                ],
              ),
            ),
            const SizedBox(height: kSpacer),
            child,
          ],
        ),
      ),
    );
  }
}
