import 'package:flutter/material.dart';

import 'explore.dart';

class ExploreView extends StatefulWidget {
  @override
  State createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var widgets = <Widget>[
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
        title: const Text('Hoppy'),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [HelloCard(), ...widgets],
      ),
    );
  }
}
