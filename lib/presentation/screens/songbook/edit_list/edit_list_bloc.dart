import 'package:cifraclub/domain/version/models/version.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditListBloc extends Cubit<EditListState> {
  EditListBloc({required EditListState initialState}) : super(initialState);

  void deleteVersion(int index) {
    final versions = List<Version>.from(state.versions, growable: true);
    final deletedVersions = List<Version>.from(state.deletedVersions, growable: true);

    var deletedVersion = versions[index];
    deletedVersions.add(deletedVersion);

    emit(state.copyWith(hasChanges: true, deletedVersions: deletedVersions, versions: versions..removeAt(index)));
  }

  void save() {/*TODO*/} // coverage:ignore-line

  void onReorderList(int oldIndex, int newIndex) {
    final currentState = state;
    final versions = List<Version>.from(currentState.versions, growable: true);

    if (oldIndex < newIndex) {
      newIndex -= 1; // coverage:ignore-line
    }

    final version = versions.removeAt(oldIndex);
    versions.insert(newIndex, version);

    emit(currentState.copyWith(versions: versions, hasChanges: true));
  }
}
