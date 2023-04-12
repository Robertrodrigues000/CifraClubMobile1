enum ListType {
  user("default"),
  favorites("favorites"),
  canPlay("canplay"),
  cantPlay("cantplay"),
  recents("recents");

  final String apiName;

  const ListType(this.apiName);
}
