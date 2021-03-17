import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (_) => AboutView(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A propos'),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
