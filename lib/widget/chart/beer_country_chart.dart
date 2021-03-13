import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';

class BeerCountryChart extends StatelessWidget {
  final Map<BeerCountry, int> repartition;

  const BeerCountryChart({
    required this.repartition,
  });

  @override
  Widget build(BuildContext context) {
    final List<ChartData<BeerCountry>> dataList = [];
    repartition.forEach((key, value) {
      dataList.add(ChartData(
        key: key,
        value: value,
      ));
    });
    final series = Series<ChartData<BeerCountry>, String>(
      id: 'beer-country',
      data: dataList,
      domainFn: (data, _) => data.key.name,
      measureFn: (data, _) => data.value,
      labelAccessorFn: (data, _) => data.key.name,
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
