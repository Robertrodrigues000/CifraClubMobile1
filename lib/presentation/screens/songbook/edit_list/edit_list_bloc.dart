import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/use_cases/delete_versions.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_all_versions_from_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/sort_versions_from_songbook.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:cifraclub/domain/version/use_cases/get_ordered_versions.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_event.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_state.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/list_order_type.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:typed_result/typed_result.dart';

class EditListBloc extends Cubit<EditListState> {
  final int _songbookId;
  final GetAllVersionsFromSongbook _getAllVersionsFromSongbook;
  final SortVersionsFromSongbook _sortVersionFromSongbook;
  final DeleteVersions _deleteVersions;
  final GetOrderedVersions _getOrderedVersions;

  EditListBloc(
    this._songbookId,
    this._getAllVersionsFromSongbook,
    this._sortVersionFromSongbook,
    this._deleteVersions,
    this._getOrderedVersions,
  ) : super(EditListState(songbookId: _songbookId));

  final _eventController = BehaviorSubject<EditListEvent>();
  Stream<EditListEvent> get editListEventStream => _eventController.stream;

  Future<void> init() async {
    final versions = await _getAllVersionsFromSongbook(_songbookId);

    emit(state.copyWith(versions: _getOrderedVersions(ListOrderType.custom, versions, ListType.user)));
  }

  void deleteVersion(int index) {
    final versions = List<Version>.from(state.versions, growable: true);
    final deletedVersions = List<Version>.from(state.deletedVersions, growable: true);

    var deletedVersion = versions[index];
    deletedVersions.add(deletedVersion);

    emit(state.copyWith(hasChanges: true, deletedVersions: deletedVersions, versions: versions..removeAt(index)));
  }

  Future<void> save() async {
    final originalVersions = _getOrderedVersions(
      ListOrderType.custom,
      await _getAllVersionsFromSongbook(_songbookId),
      ListType.user,
    );

    if (originalVersions.equals(state.versions)) {
      _eventController.add(ReorderSuccess());
      return;
    }

    emit(state.copyWith(isLoading: true));

    Result<void, RequestError>? deleteVersionsResult;

    if (state.deletedVersions.isNotEmpty) {
      deleteVersionsResult = await _deleteVersions(
        songbookId: _songbookId,
        versions: state.deletedVersions,
      );
    }

    final sortVersionResult = await _sortVersionFromSongbook(_songbookId, state.versions);

    if (deleteVersionsResult?.isFailure ?? false || sortVersionResult.isFailure) {
      _eventController.add(ReorderError(
        error: sortVersionResult.isFailure ? sortVersionResult.getError()! : deleteVersionsResult!.getError()!,
        deleteError: deleteVersionsResult?.isFailure ?? false,
        sortError: sortVersionResult.isFailure,
      ));
      emit(state.copyWith(isLoading: false, hasChanges: true));
    } else {
      _eventController.add(ReorderSuccess());
      emit(state.copyWith(isLoading: false, hasChanges: false));
    }
  }

  void onReorderList(int oldIndex, int newIndex) {
    final currentState = state;
    final versions = List<Version>.from(currentState.versions);

    newIndex = oldIndex < newIndex ? newIndex - 1 : newIndex;

    if (oldIndex == newIndex) {
      return;
    }

    final version = versions.removeAt(oldIndex);
    versions.insert(newIndex, version);

    emit(currentState.copyWith(versions: versions, hasChanges: true));
  }
}
