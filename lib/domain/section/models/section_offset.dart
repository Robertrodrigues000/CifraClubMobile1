class SectionOffset {
  final int start;
  final int end;

  const SectionOffset({
    required this.start,
    required this.end,
  });

  SectionOffset copyWith({
    int? start,
    int? end,
  }) {
    return SectionOffset(
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  @override
  String toString() => "[$start-$end]"; // coverage:ignore-line
}
