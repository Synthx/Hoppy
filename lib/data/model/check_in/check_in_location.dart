import 'package:hive/hive.dart';

part 'check_in_location.g.dart';

@HiveType(typeId: 7)
enum CheckInLocation {
  @HiveField(0)
  HOME,
  @HiveField(1)
  FRIENDS,
  @HiveField(2)
  BAR,
  @HiveField(3)
  RESTAURANT,
  @HiveField(4)
  WORK,
}

extension CheckInLocationExtension on CheckInLocation {
  String get name {
    switch (this) {
      case CheckInLocation.HOME:
        return 'A la maison';
      case CheckInLocation.FRIENDS:
        return 'Chez des amis';
      case CheckInLocation.BAR:
        return 'Dans un bar';
      case CheckInLocation.RESTAURANT:
        return 'Dans un restaurant';
      case CheckInLocation.WORK:
        return 'Au travail';
    }
  }
}
