sealed class VersionEffect {}

class OnShowYouTubeVideo implements VersionEffect {
  final String videoId;

  const OnShowYouTubeVideo(this.videoId);
}

class OnCloseYouTubeVideo implements VersionEffect {}
