import 'package:charts_flutter/flutter.dart' hide TextStyle;
import 'package:flutter/material.dart' hide AnimatedIcon;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/screens/main/explore/widget/more_card_button.dart';
import 'package:hoppy/screens/screens.dart';
import 'package:hoppy/store/store.dart';
import 'package:hoppy/widget/widget.dart';

class BeerColorRepartitionCard extends StatelessWidget {
  void _openAddBeerDialog(BuildContext context) {
    Navigator.push(
      context,
      AddBeerDialog.route(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kCardHeight,
      margin: const EdgeInsets.symmetric(
        vertical: kCardVerticalMargin,
      ),
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        children: [
          Spacer(flex: 2),
          Container(
            child: BlocBuilder<StatisticCubit, StatisticState>(
              buildWhen: (prev, curr) =>
                  prev.beerStatistic.count != curr.beerStatistic.count,
              builder: (context, state) {
                if (state.beerStatistic.count == 0) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedIcon(
                        icon: Text('📈', style: TextStyle(fontSize: 50)),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Ajouter des bières et obtenez des statistiques détaillés sur vos goûts',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                }

                final List<ChartData> dataList = [];
                state.beerStatistic.colorRepartition.forEach((key, value) {
                  dataList.add(ChartData(label: key.name, value: value));
                });
                final series = Series<ChartData, String>(
                  id: 'beer-color',
                  data: dataList,
                  domainFn: (data, _) => data.label,
                  measureFn: (data, _) => data.value,
                  fillColorFn: (_, __) => MaterialPalette.blue.shadeDefault,
                );
                return PieChart(
                  [series],
                  animate: true,
                  defaultRenderer: ArcRendererConfig(
                    arcWidth: 60,
                  ),
                );
              },
            ),
          ),
          Spacer(flex: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BlocBuilder<StatisticCubit, StatisticState>(
                buildWhen: (prev, curr) => prev.beerStatistic.count != curr.beerStatistic.count,
                builder: (context, state) {
                  if (state.beerStatistic.count > 0) {
                    return MoreCardButton(
                      onTap: () {},
                    );
                  }

                  return MoreCardButton(
                    onTap: () => _openAddBeerDialog(context),
                    iconData: Icons.add,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
