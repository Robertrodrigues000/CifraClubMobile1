enum App {
  cifraClub(
    androidPackageName: "com.studiosol.cifraclub",
    iosPackageName: "CifraClubApp://",
    appStoreUrl: "itms-apps://itunes.apple.com/br/app/cifra-club/id921625944",
  ),
  afinador(
    androidPackageName: "com.studiosol.afinadorlite",
    iosPackageName: "afinadorCifraClub://",
    appStoreUrl: "itms-apps://itunes.apple.com/br/app/afinador-cifra-club/id480625281",
  ),
  metronomo(
    androidPackageName: "com.studiosol.metronomo",
    iosPackageName: "metronomoCifraClub://",
    appStoreUrl: "https://apps.apple.com/br/app/metronome-cifra-club/id569883867",
  ),
  palheta(
    androidPackageName: "br.com.studiosol.apalhetaperdida",
    iosPackageName: "aPalhetaPerdida://",
    appStoreUrl: "itms-apps://itunes.apple.com/br/app/a-palheta-perdida/id1248322967",
  ),
  palco(
    androidPackageName: "com.studiosol.palcomp3",
    iosPackageName: "palcoMP3App://",
    appStoreUrl: "https://apps.apple.com/br/app/palco-mp3-m%C3%BAsicas-e-podcasts/id497345210",
  ),
  letras(
    androidPackageName: "com.studiosol.player.letras",
    iosPackageName: "letrasApp://",
    appStoreUrl: "itms-apps://itunes.apple.com/br/app/letras-mus-br/id773347891",
  ),
  academy(
    androidPackageName: "com.studiosol.cifraclub.academy",
    iosPackageName: "fb724965028903370://",
    appStoreUrl: "https://apps.apple.com/br/app/cifra-club-academy/id1582624832",
  );

  const App({
    required this.androidPackageName,
    required this.iosPackageName,
    required this.appStoreUrl,
  });

  final String androidPackageName;
  final String iosPackageName;
  final String appStoreUrl;

  String get googlePlayUrl =>
      "https://play.google.com/store/apps/details?id=$androidPackageName"; // coverage:ignore-line
}
