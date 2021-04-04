import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/generated/l10n.dart';

class BeerColorChart extends StatelessWidget {
  final Map<BeerColor, int> repartition;

  const BeerColorChart({
    required this.repartition,
  });

  @override
  Widget build(BuildContext context) {
    final dataList = <ChartData<BeerColor>>[];
    repartition.forEach((key, value) {
      dataList.add(ChartData(
        key: key,
        value: value,
      ));
    });
    final series = Series<ChartData<BeerColor>, String>(
      id: 'beer-color',
      data: dataList,
      domainFn: (data, _) => Localization.of(context).beer_color(data.key.key),
      measureFn: (data, _) => data.value,
      colorFn: (data, _) => ColorUtil.fromDartColor(data.key.color),
      labelAccessorFn: (data, _) =>
          Localization.of(context).beer_color(data.key.key),
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
