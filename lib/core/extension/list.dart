import 'dart:math';

extension ListExtension<T> on List<T> {
  T random() {
    assert(length > 0);
    final random = Random();

    return this[random.nextInt(length)];
  }
}
