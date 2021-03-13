import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';

class BeerStyleSelectorDialog extends StatelessWidget {
  static route() => MaterialPageRoute<BeerStyle?>(
        builder: (_) => BeerStyleSelectorDialog(),
      );

  void _closeDialog(BuildContext context) {
    context.pop();
  }

  void _selectBeerStyle(BuildContext context, BeerStyle beerStyle) {
    context.pop(beerStyle);
  }

  @override
  Widget build(BuildContext context) {
    final beerStyles = BeerStyle.values;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Style de bière'),
        leading: IconButton(
          onPressed: () => _closeDialog(context),
          icon: const Icon(Icons.clear),
        ),
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) {
          return const Divider(height: 1);
        },
        itemCount: beerStyles.length,
        itemBuilder: (context, index) {
          final beerStyle = beerStyles[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 3,
            ),
            onTap: () => _selectBeerStyle(context, beerStyle),
            title: Text('${beerStyle.name}'),
          );
        },
      ),
    );
  }
}
