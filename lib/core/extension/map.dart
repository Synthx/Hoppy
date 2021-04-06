import 'dart:collection';

import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';

extension GenericIntegerMapExtension<T> on Map<T, int> {
  void increment(T value, {int step = 1}) {
    if (containsKey(value)) {
      this[value] = this[value]! + step;
    } else {
      this[value] = step;
    }
  }

  SplayTreeMap<T, int> sort() {
    return SplayTreeMap.from(
      this,
      (a, b) => this[a]! > this[b]! ? -1 : 1,
    );
  }

  List<ChartData> generateChartData({
    required String Function(T) labelFn,
    required String otherLabel,
  }) {
    final chartDataList = <ChartData>[];
    final otherChartData = ChartData(
      label: otherLabel,
      size: 0,
    );
    var count = 1;
    final sortedData = sort();
    sortedData.forEach((value, size) {
      if (count <= kChartMaxElementDisplayed) {
        chartDataList.add(ChartData(
          label: labelFn(value),
          size: size,
        ));
      } else {
        otherChartData.size += size;
      }

      count++;
    });

    if (otherChartData.size > 0) {
      chartDataList.add(otherChartData);
    }

    return chartDataList;
  }

  void decrement(T value, {int step = 1}) {
    if (containsKey(value)) {
      final current = this[value]!;
      if (current > step) {
        this[value] = current - step;
      } else {
        remove(value);
      }
    }
  }
}
