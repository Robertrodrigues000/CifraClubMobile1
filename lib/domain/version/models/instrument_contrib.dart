import 'package:cifraclub/presentation/constants/app_webp.dart';

enum InstrumentContrib {
  guitar("Cifras", AppWebp.contribCifra),
  score("Partituras", AppWebp.contribScore),
  bass("Tab de baixo", AppWebp.contribBass),
  drums("Tab de bateria", AppWebp.contribDrum),
  guitarPro("Guitar Pro", AppWebp.contribGP),
  harmonica("Tab de Gaita", AppWebp.contribHarmonica),
  ;

  final String instrumentName;
  final String instrumentImage;

  const InstrumentContrib(this.instrumentName, this.instrumentImage);
}
