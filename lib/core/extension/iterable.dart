extension NumberIterableExtension<T extends num> on Iterable<T> {
  double average() {
    if (isEmpty) return double.nan;

    return fold(0, (num acc, T curr) => acc + curr) / length;
  }
}

extension GenericIterableExtension<T> on Iterable<T> {
  Map<T, int> group() {
    return fold({}, (Map<T, int> acc, T curr) {
      if (acc.containsKey(curr)) {
        acc[curr] = acc[curr]! + 1;
      } else {
        acc[curr] = 1;
      }

      return acc;
    });
  }
}
