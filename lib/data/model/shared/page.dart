import 'package:freezed_annotation/freezed_annotation.dart';

part 'page.freezed.dart';

@freezed
class Page<T> with _$Page<T> {
  factory Page({
    required List<T> content,
    required int number,
    required int size,
    required int totalElements,
    required int totalPages,
  }) = _Page;
}
