enum ListType {
  user("default", 0),
  recents("recents", 1),
  favorites("favorites", 2),
  canPlay("canplay", 3, "can"),
  cantPlay("cantplay", 4, "cannot");

  final String apiName;
  final int localId;
  final String? label;

  const ListType(this.apiName, this.localId, [this.label]);

  static ListType getListTypeById(int id) {
    return values.firstWhere((e) => e.localId == id, orElse: () => ListType.user);
  }
}
