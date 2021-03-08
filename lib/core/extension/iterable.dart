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
