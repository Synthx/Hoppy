import 'package:flutter/material.dart';
import 'package:hoppy/screens/main/explore/widget/most_drunken_beer_country_card.dart';
import 'package:hoppy/screens/screens.dart';

import 'widget/beer_color_list.dart';
import 'widget/beer_color_repartition_card.dart';
import 'widget/empty_beer_card.dart';
import 'widget/favorite_beer_list.dart';
import 'widget/hello_card.dart';
import 'widget/last_added_beer_card.dart';
import 'widget/most_drunken_beer_style_card.dart';

class ExploreView extends StatefulWidget {
  @override
  State createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  void openSearchBeerDialog() {
    Navigator.push(
      context,
      SearchBeerDialog.route(),
    );
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
          HelloCard(),
          BeerColorList(),
          MostDrunkenBeerCountryCard(),
          BeerColorRepartitionCard(),
          LastAddedBeerCard(),
          FavoriteBeerList(),
          MostDrunkenBeerStyleCard(),
          EmptyBeerCard(),
        ],
      ),
    );
  }
}
