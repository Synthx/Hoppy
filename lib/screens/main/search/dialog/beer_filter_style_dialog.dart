import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/screens/main/search/dialog/beer_filter_style_selector.dart';
import 'package:hoppy/store/store.dart';

class BeerFilterStyleDialog extends StatelessWidget {
  static MaterialPageRoute route() => MaterialPageRoute(
        builder: (_) => BeerFilterStyleDialog(),
      );

  void _closeDialog(BuildContext context) {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Styles de bière'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => _closeDialog(context),
        ),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          final selectedStyles = state.filter.styles;
          final styles = BeerStyle.values
              .map((e) => Selectable(
                    value: e,
                    selected: selectedStyles.contains(e),
                  ))
              .toList();
          return ListView.builder(
            padding: const EdgeInsets.all(kDefaultPadding),
            physics: const BouncingScrollPhysics(),
            itemCount: styles.length,
            itemBuilder: (context, index) {
              final style = styles[index];
              return BeerFilterStyleSelector(
                style: style,
              );
            },
          );
        },
      ),
    );
  }
}
