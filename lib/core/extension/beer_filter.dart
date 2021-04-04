import 'package:hoppy/data/data.dart';

extension BeerFilterExtension on BeerFilter {
  int count() {
    var counter = 0;

    if (keyword != null && keyword!.isNotEmpty) {
      counter += 1;
    }
    if (havePicture != null) {
      counter += 1;
    }

    counter += colors.length;
    counter += styles.length;
    counter += countries.length;

    return counter;
  }

  bool isEmpty() {
    return count() == 0;
  }
}
