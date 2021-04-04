import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/store/store.dart';
import 'package:hoppy/widget/widget.dart';

class BeerCountryRepartitionDialog extends StatefulWidget {
  static MaterialPageRoute route() => MaterialPageRoute(
        builder: (_) => BeerCountryRepartitionDialog(),
        fullscreenDialog: true,
      );

  @override
  State createState() => _BeerCountryRepartitionDialogState();
}

class _BeerCountryRepartitionDialogState
    extends State<BeerCountryRepartitionDialog> {
  void _closeDialog() {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MiniFabButton(
        icon: Icon(Icons.clear),
        onTap: () => _closeDialog(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.25),
                BlendMode.srcOver,
              ),
              child: Image.asset(
                'assets/images/beer-country.jpg',
                height: kCardHeight,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 40,
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Statistique',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 16,
                        ),
                  ),
                  Text(
                    'Origines des bières',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 26,
                        ),
                  ),
                ],
              ),
            ),
            BlocBuilder<StatisticCubit, StatisticState>(
              buildWhen: (prev, curr) =>
                  prev.checkInStatistic.count != curr.checkInStatistic.count,
              builder: (context, state) {
                final countryRepartition =
                    state.checkInStatistic.drunkenCountryRepartition.sort();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 400,
                      child: BeerCountryChart(
                        repartition: countryRepartition,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                      ),
                      child: Text(
                        'Détail de la répartition',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: countryRepartition.length,
                      shrinkWrap: true,
                      separatorBuilder: (context, _) => Divider(
                        height: 0,
                        color: Theme.of(context).dividerColor,
                      ),
                      padding: EdgeInsets.only(
                        bottom: max(
                          MediaQuery.of(context).padding.bottom,
                          kDefaultPadding,
                        ),
                      ),
                      itemBuilder: (context, index) {
                        var value = countryRepartition.keys.elementAt(index);
                        final count =
                            countryRepartition.values.elementAt(index);
                        return ChartTile(
                          title: value.name,
                          value: count,
                          prefix: Container(
                            margin: const EdgeInsets.only(
                              right: 20,
                            ),
                            child: Text(
                              value.flag,
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
