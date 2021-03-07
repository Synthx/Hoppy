import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings.freezed.dart';

@freezed
class Settings with _$Settings {
  factory Settings({
    bool? firstVisit,
    bool? darkMode,
    String? name,
    DateTime? birthDate,
  }) = _Settings;
}
