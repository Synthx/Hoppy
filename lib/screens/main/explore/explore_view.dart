import 'package:flutter/material.dart';
import 'package:hoppy/screens/screens.dart';

import 'explore.dart';

class ExploreView extends StatefulWidget {
  @override
  State createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView>
    with AutomaticKeepAliveClientMixin {
  void _openSearchBeerDialog() {
    Navigator.push(
      context,
      SearchBeerDialog.route(),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    List<Widget> widgets = [
      BeerColorList(),
      MostDrunkenBeerCountryCard(),
      BeerColorRepartitionCard(),
      LastAddedBeerCard(),
      FavoriteBeerList(),
      MostDrunkenBeerStyleCard(),
      EmptyBeerCard(),
      MostDrunkenBeerCard(),
      StatisticCard(),
    ];
    widgets.shuffle();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hoppy"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _openSearchBeerDialog(),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [HelloCard(), ...widgets],
      ),
    );
  }
}
