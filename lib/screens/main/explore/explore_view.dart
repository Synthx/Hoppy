import 'package:flutter/material.dart';
import 'package:hoppy/screens/screens.dart';

class ExploreView extends StatefulWidget {
  @override
  State createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  void openSearchBeerDialog() {
    Navigator.push(context, SearchBeerDialog.route());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hoppy"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => openSearchBeerDialog(),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Text('Explorer'),
        ],
      ),
    );
  }
}
