extension DoubleExtension on double {
  double average(double value) {
    if (this == double.nan) return value;

    return (this + value) / 2;
  }

  double toPrecision({int precision = 2}) {
    if (this == double.nan) return this;

    return double.parse(toStringAsFixed(precision));
  }
}
