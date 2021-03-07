import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hoppy/data/data.dart';

part 'settings_state.freezed.dart';

@freezed
class SettingsState with _$SettingsState {
  factory SettingsState({
    required bool loading,
    required Settings value,
    GlobalKey? mainKey,
  }) = _SettingsState;
}
