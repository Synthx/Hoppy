import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/generated/l10n.dart';

class BeerStyleChart extends StatelessWidget {
  final Map<BeerStyle, int> repartition;

  const BeerStyleChart({
    required this.repartition,
  });

  @override
  Widget build(BuildContext context) {
    final dataList = <ChartData<BeerStyle>>[];
    repartition.forEach((key, value) {
      dataList.add(ChartData(
        key: key,
        value: value,
      ));
    });
    final series = Series<ChartData<BeerStyle>, String>(
      id: 'beer-style',
      data: dataList,
      domainFn: (data, _) => Localization.of(context).beer_style(data.key.key),
      measureFn: (data, _) => data.value,
      labelAccessorFn: (data, _) =>
          Localization.of(context).beer_style(data.key.key),
    );

    return PieChart(
      [series],
      animate: false,
      defaultRenderer: ArcRendererConfig(
        arcWidth: kChartArcWidth,
        arcRendererDecorators: [
          ArcLabelDecorator(
            labelPosition: ArcLabelPosition.auto,
          ),
        ],
      ),
    );
  }
}
