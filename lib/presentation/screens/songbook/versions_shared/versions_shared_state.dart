import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/list_order_type.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'versions_shared_state.g.dart';

@CopyWith()
class VersionsSharedState {
  final List<Version> versions;
  final Songbook? songbook;
  final ListOrderType selectedListOrderType;
  final RequestError? error;
  const VersionsSharedState({
    this.versions = const [],
    this.songbook,
    this.error,
    this.selectedListOrderType = ListOrderType.custom,
  });
}
