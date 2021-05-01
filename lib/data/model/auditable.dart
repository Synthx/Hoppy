abstract class Auditable {
  int? get id;

  set id(int? id);

  int get creationDate;

  set creationDate(int timestamp);

  int get lastModifiedDate;

  set lastModifiedDate(int timestamp);
}
