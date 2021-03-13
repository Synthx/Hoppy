import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';

class ChartTile extends StatelessWidget {
  final Widget? prefix;
  final String title;
  final int value;

  const ChartTile({
    required this.title,
    required this.value,
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
      ),
      child: Row(
        children: [
          if (prefix != null) prefix!,
          Expanded(
            child: Text(title),
          ),
          const SizedBox(width: 20),
          Text('$value'),
        ],
      ),
    );
  }
}
