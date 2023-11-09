// coverage:ignore-file
sealed class VersionOptionsResult {}

class FavoriteVersionSuccess implements VersionOptionsResult {}

class UnFavoriteVersionSuccess implements VersionOptionsResult {}

class FavoriteVersionError implements VersionOptionsResult {}

class UnFavoriteVersionError implements VersionOptionsResult {}
