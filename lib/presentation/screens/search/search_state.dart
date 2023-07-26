import 'package:cifraclub/domain/version/models/version.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'search_state.g.dart';

@CopyWith()
class SearchState {
  final List<Version> versions;

  const SearchState({
    this.versions = const [],
  });
}
