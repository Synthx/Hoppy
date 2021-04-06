import 'package:charts_flutter/flutter.dart' hide Color;
import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/generated/l10n.dart';

class BeerCountryChart extends StatelessWidget {
  final Map<BeerCountry, int> repartition;

  const BeerCountryChart({
    required this.repartition,
  });

  @override
  Widget build(BuildContext context) {
    final dataList = repartition.generateChartData(
      labelFn: (country) => country.flag,
      otherLabel: Localization.of(context).others,
    );
    final series = Series<ChartData, String>(
      id: 'beer-country',
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
          ArcLabelDecorator(
            labelPosition: ArcLabelPosition.auto,
          ),
        ],
      ),
    );
  }
}
