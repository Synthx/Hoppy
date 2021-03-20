import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_report.freezed.dart';

@freezed
class ErrorReport with _$ErrorReport {
  factory ErrorReport({
    required Object error,
    StackTrace? stackTrace,
    required DateTime time,
    required TargetPlatform platform,
    required Map<String, dynamic> deviceInfo,
    required Map<String, dynamic> packageInfo,
    File? screenshot,
  }) = _ErrorReport;
}
