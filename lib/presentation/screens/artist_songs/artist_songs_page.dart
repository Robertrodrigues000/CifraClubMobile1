enum ArtistSongsPage {
  mostAccessed(0),
  alphabeticalOrder(1),
  videoLessons(2);

  final int pageIndex;

  const ArtistSongsPage(this.pageIndex);

  static ArtistSongsPage fromIndex(int index) {
    return switch (index) {
      0 => ArtistSongsPage.mostAccessed,
      1 => ArtistSongsPage.alphabeticalOrder,
      _ => ArtistSongsPage.videoLessons,
    };
  }
}
