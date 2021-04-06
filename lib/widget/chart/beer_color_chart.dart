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
    final dataList = <ChartData>[];
    repartition.forEach((value, size) {
      dataList.add(ChartData(
        label: Localization.of(context).beer_color(value.key),
        color: value.color,
        size: size,
      ));
    });
    final series = Series<ChartData, String>(
      id: 'beer-color',
      data: dataList,
      domainFn: (data, _) => data.label,
      measureFn: (data, _) => data.size,
      colorFn: (data, _) => ColorUtil.fromDartColor(data.color),
      labelAccessorFn: (data, _) => data.label,
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
