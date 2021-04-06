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
    final dataList = repartition.generateChartData(
      labelFn: (style) => Localization.of(context).beer_style(style.key),
      otherLabel: Localization.of(context).others,
    );
    final series = Series<ChartData, String>(
      id: 'beer-style',
      data: dataList,
      domainFn: (data, _) => data.label,
      measureFn: (data, _) => data.size,
      colorFn: (data, index) => ColorUtil.fromDartColor(kChartColorList[index]),
      labelAccessorFn: (data, _) => data.label,
    );

    return PieChart(
      [series],
      animate: false,
      defaultRenderer: ArcRendererConfig(
        arcWidth: kChartArcWidth,
        arcRendererDecorators: [
          ArcLabelDecorator(),
        ],
      ),
    );
  }
}
