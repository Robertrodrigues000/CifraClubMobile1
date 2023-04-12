import 'package:copy_with_extension/copy_with_extension.dart';

part 'lists_state.g.dart';

// coverage:ignore-file
@CopyWith()
class ListsState {
  final List<String> userLists;
  final List<String> specialLists;

  ListsState({
    this.userLists = const [],
    this.specialLists = const [],
  });
}
