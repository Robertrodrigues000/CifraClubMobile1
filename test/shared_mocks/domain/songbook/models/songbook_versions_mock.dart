import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/version/models/version.dart';

import '../../version/models/version_mock.dart';
import 'songbook_mock.dart';

({Songbook songbook, List<Version> versions}) getFakeSongbookVersions({ListType listType = ListType.user}) =>
    (songbook: getFakeSongbook(listType: listType), versions: [getFakeVersion(), getFakeVersion()]);
