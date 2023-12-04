class LocalSong {
  final String songName;
  final String artistName;

  final String? path;
  final String? completePath;

  final int duration;
  final String? albumId;

  const LocalSong({
    required this.songName,
    required this.artistName,
    this.path,
    this.completePath,
    required this.duration,
    this.albumId,
  });
}
