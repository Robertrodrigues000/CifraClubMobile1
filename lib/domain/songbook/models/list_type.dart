enum ListType {
  user("default", 0),
  recents("recents", 1),
  favorites("favorites", 2),
  canPlay("canplay", 3),
  cantPlay("cantplay", 4);

  final String apiName;
  final int localId;

  const ListType(this.apiName, this.localId);
}
