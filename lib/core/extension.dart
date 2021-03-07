extension NumberIterableExtension<T extends num> on Iterable<T> {
  double average() {
    if (this.isEmpty) return double.nan;

    return this.fold(0, (num acc, T curr) => acc + curr) / this.length;
  }
}

extension GenericIterableExtension<T> on Iterable<T> {
  Map<T, int> group() {
    return this.fold({}, (Map<T, int> acc, T curr) {
      if (acc.containsKey(curr)) {
        acc[curr] = acc[curr]! + 1;
      } else {
        acc[curr] = 1;
      }

      return acc;
    });
  }
}

extension DoubleExtension on double {
  double average(double value) {
    if (this == double.nan) return value;

    return (this + value) / 2;
  }

  double toPrecision({int precision = 2}) {
    return double.parse(this.toStringAsFixed(precision));
  }
}

extension GenericIntegerMapExtension<T> on Map<T, int> {
  void increment(T value, {int step = 1}) {
    if (this.containsKey(value)) {
      this[value] = this[value]! + step;
    } else {
      this[value] = step;
    }
  }

  void decrement(T value, {int step = 1}) {
    if (this.containsKey(value)) {
      final current = this[value]!;
      if (current > step) {
        this[value] = current - step;
      } else {
        this.remove(value);
      }
    }
  }
}
