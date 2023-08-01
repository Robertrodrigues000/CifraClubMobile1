sealed class VersionEvent {}

class OnYouTubeVideoSelected implements VersionEvent {
  final String videoId;

  const OnYouTubeVideoSelected(this.videoId);
}

class OnYouTubeVideoClosed implements VersionEvent {}
