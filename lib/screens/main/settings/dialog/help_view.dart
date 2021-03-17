import 'package:flutter/material.dart';

class HelpView extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (_) => HelpView(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aide'),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
