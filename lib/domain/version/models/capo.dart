import 'package:cifraclub/extensions/build_context.dart';
import 'package:flutter/material.dart';

enum Capo {
  noCapo(capoId: 0),
  capo1(capoId: 1),
  capo2(capoId: 2),
  capo3(capoId: 3),
  capo4(capoId: 4),
  capo5(capoId: 5),
  capo6(capoId: 6),
  capo7(capoId: 7),
  capo8(capoId: 8),
  capo9(capoId: 9),
  capo10(capoId: 10),
  capo11(capoId: 11),
  capo12(capoId: 12);

  final int capoId;

  const Capo({required this.capoId});

  String getCapoName(BuildContext context) {
    return switch (this) {
      noCapo => context.text.noCapo,
      capo1 => context.text.capo1,
      capo2 => context.text.capo2,
      capo3 => context.text.capo3,
      capo4 => context.text.capo4,
      capo5 => context.text.capo5,
      capo6 => context.text.capo6,
      capo7 => context.text.capo7,
      capo8 => context.text.capo8,
      capo9 => context.text.capo9,
      capo10 => context.text.capo10,
      capo11 => context.text.capo11,
      capo12 => context.text.capo12,
    };
  }

  static Capo getCapoById(int? id) {
    return Capo.values.firstWhere((capo) => capo.capoId == id, orElse: () => noCapo);
  }
}
