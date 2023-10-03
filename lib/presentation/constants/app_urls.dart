// coverage:ignore-file
class AppUrls {
  static const supportUrl = "https://suporte.cifraclub.com.br/support/home";
  static const cifraClubStoreUrl = "https://cifraclubstore.com.br/";
  static const privacyPolicyUrl = "https://www.cifraclub.com.br/politica-privacidade.html";
  static const termsOfUseUrl = "https://www.cifraclub.com.br/aviso-legal.html";

  static const youtubeUrl = "https://www.youtube.com/cifraclub";
  static const facebookUrl = "https://www.facebook.com/cifraclub/";
  static const twitterUrl = "https://twitter.com/cifraclub";
  static const tiktokUrl = "https://www.tiktok.com/@cifraclub";
  static const instagramUrl = "https://www.instagram.com/cifraclub/";

  static String songbookUrlFormat(int ccid, int songbookId) =>
      "https://www.cifraclub.com.br/musico/$ccid/repertorio/$songbookId/";
  static String versionUrlFormat(String artistUrl, String songUrl) =>
      "https://www.cifraclub.com.br/$artistUrl/$songUrl";
  static String artistUrlFormat(String artistUrl) => "https://www.cifraclub.com.br/$artistUrl";
  static String albumUrlFormat(String artistUrl, String albumUrl) =>
      "https://www.cifraclub.com.br/$artistUrl/discografia/$albumUrl/";
}
