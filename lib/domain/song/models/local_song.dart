class LocalSong {
  final String songName;
  final String artistName;

  final String? path;

  final int duration;
  final String? albumId;

  const LocalSong({
    required this.songName,
    required this.artistName,
    this.path,
    required this.duration,
    this.albumId,
  });
}
