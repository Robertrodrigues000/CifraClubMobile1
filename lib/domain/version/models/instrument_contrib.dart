enum InstrumentContrib {
  guitar("Cifras", "imagem"),
  score("Partituras", "imagem"),
  bass("Tab de baixo", "imagem"),
  drums("Tab de bateria", "imagem"),
  guitarPro("Guitar Pro", "imagem"),
  harmonica("Tab de Gaita", "imagem"),
  ;

  final String instrumentName;
  final String instrumentImage;

  const InstrumentContrib(this.instrumentName, this.instrumentImage);
}
