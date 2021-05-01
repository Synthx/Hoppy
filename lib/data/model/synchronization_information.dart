class SynchronizationInformation<T> {
  int? lastModificationDate;
  List<T> data;

  SynchronizationInformation({
    required this.lastModificationDate,
    required this.data,
  });
}
