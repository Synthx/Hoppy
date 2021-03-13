import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';

class BeerColorChart extends StatelessWidget {
  final Map<BeerColor, int> repartition;

  const BeerColorChart({
    required this.repartition,
  });

  @override
  Widget build(BuildContext context) {
    final List<ChartData<BeerColor>> dataList = [];
    repartition.forEach((key, value) {
      dataList.add(ChartData(
        key: key,
        value: value,
      ));
    });
    final series = Series<ChartData<BeerColor>, String>(
      id: 'beer-color',
      data: dataList,
      domainFn: (data, _) => data.key.name,
      measureFn: (data, _) => data.value,
      colorFn: (data, _) => ColorUtil.fromDartColor(data.key.color),
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
