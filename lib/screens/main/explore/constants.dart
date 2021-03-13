import 'package:flutter/material.dart';

TextStyle cardSubtitleStyle(BuildContext context) {
  return Theme.of(context).textTheme.bodyText1!.copyWith(
        color: Colors.white.withOpacity(0.8),
        fontSize: 16,
      );
}

TextStyle cardTitleStyle(BuildContext context) {
  return Theme.of(context).textTheme.headline4!.copyWith(
        color: Colors.white,
      );
}

TextStyle cardContentStyle(BuildContext context) {
  return Theme.of(context).textTheme.bodyText1!.copyWith(
        color: Colors.white,
        fontSize: 16,
      );
}
