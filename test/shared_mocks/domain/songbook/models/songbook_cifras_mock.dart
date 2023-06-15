import 'package:cifraclub/domain/cifra/models/cifra.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';

import '../../cifra/models/cifra_mock.dart';
import 'songbook_mock.dart';

({Songbook songbook, List<Cifra> cifras}) getFakeSongbookCifras({ListType listType = ListType.user}) =>
    (songbook: getFakeSongbook(listType: listType), cifras: [getFakeCifra(), getFakeCifra()]);
