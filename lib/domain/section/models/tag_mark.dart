enum TagMark {
  // External tablature
  tabExternalStart("#t1#"),
  tabExternalEnd("#/t1#"),

  // Internal tablature
  tabInternalStart("#t2#"),
  tabInternalEnd("#/t2#"),

  // Chord
  chordStart("<b>"),
  chordEnd("</b>");

  final String mark;

  const TagMark(this.mark);
}
