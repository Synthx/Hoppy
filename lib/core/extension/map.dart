import 'dart:collection';

extension GenericIntegerMapExtension<T> on Map<T, int> {
  void increment(T value, {int step = 1}) {
    if (this.containsKey(value)) {
      this[value] = this[value]! + step;
    } else {
      this[value] = step;
    }
  }

  SplayTreeMap<T, int> sort() {
    return SplayTreeMap.from(
      this,
      (a, b) => this[a]! > this[b]! ? 1 : -1,
    );
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
