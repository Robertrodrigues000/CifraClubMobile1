import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit_state.dart';
import 'package:cifraclub/domain/remote_config/use_cases/get_list_limit_constants.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook_error.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_all_user_songbooks.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_user_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_version_to_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/validate_artist_image_preview.dart';
import 'package:cifraclub/domain/songbook/use_cases/validate_songbook_name.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_pro_status_stream.dart';
import 'package:cifraclub/presentation/bottom_sheets/save_version_to_list_bottom_sheet/save_version_to_list_result.dart';
import 'package:cifraclub/presentation/bottom_sheets/save_version_to_list_bottom_sheet/save_version_to_list_state.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_state.dart';
import 'package:cifraclub/presentation/widgets/subscription_holder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typed_result/typed_result.dart';

class SaveVersionToListBottomSheetBloc extends Cubit<SaveVersionToListState> with SubscriptionHolder {
  final GetAllUserSongbooks _getAllUserSongbooks;
  final InsertUserSongbook _insertUserSongbook;
  final GetListLimitState _getListLimitState;
  final GetVersionsLimitState _getVersionsLimitState;
  final InsertVersionToSongbook _insertVersionToSongbook;
  final ValidateSongbookName _validateSongbookName;
  final GetListLimit _getListLimit;
  final GetVersionsLimit _getVersionsLimit;
  final GetProStatusStream _getProStatusStream;
  final ValidateArtistImagePreview _validateArtistImagePreview;
  final GetListLimitConstants _getListLimitConstants;
  final String artistUrl;
  final String songUrl;

  SaveVersionToListBottomSheetBloc(
    this._getAllUserSongbooks,
    this._insertUserSongbook,
    this._getListLimitState,
    this._getVersionsLimitState,
    this._insertVersionToSongbook,
    this._validateSongbookName,
    this._getListLimit,
    this._getVersionsLimit,
    this._getProStatusStream,
    this._validateArtistImagePreview,
    this._getListLimitConstants,
    this.artistUrl,
    this.songUrl,
  ) : super(const SaveVersionToListState());

  Future<void> init() async {
    final isPro = await _getProStatusStream().first;
    final songbooks = await _getAllUserSongbooks().first;
    final listLimitState = await _getListLimitState().first;
    emit(
      state.copyWith(
        userLists: songbooks.where((element) => element.type == ListType.user).toList(growable: false),
        specialLists: songbooks
            .where((element) => element.type != ListType.user && element.type != ListType.recents)
            .toList(growable: false),
        listState: listLimitState,
        isPro: isPro,
      ),
    );
  }

  int getListLimit() => _getListLimit(state.isPro);
  int getVersionsLimit() => _getVersionsLimit(state.isPro);

  Future<SaveToListResult> createNewSongbook(String name) async {
    final listLimitState = await _getListLimitState().first;

    if (listLimitState == ListLimitState.reached) {
      return ListLimitStateReached(listLimit: getListLimit());
    }

    final result = await _insertUserSongbook(name: name);

    if (result.isSuccess) {
      return addSongToSongbook(songbookId: result.get()?.id, name: name, isNewList: true);
    } else {
      return SaveToListError();
    }
  }

  Future<SaveToListResult> addSongToSongbook({
    int? songbookId,
    required String name,
    required bool isNewList,
  }) async {
    if (songbookId == null) {
      return SaveToListError();
    }

    final result = await _insertVersionToSongbook(
      songbookId: songbookId,
      artistUrl: artistUrl,
      songUrl: songUrl,
      isPro: state.isPro,
    );
    if (result.isFailure) {
      final error = result.getError()!;
      return switch (error) {
        SongbookVersionsLimitReachedError() => VersionListLimitStateReached(versionsLimit: error.versionsLimit),
        SongbookRepeatedSongError() => VersionIsAlreadyOnListError(),
        SongbookRequestError() => SaveToListError(),
      };
    }

    final currentListState = await _getListLimitState().first;
    final currentVersionsListState = await _getVersionsLimitState(songbookId).first;

    if (currentListState == ListLimitState.withinLimit && currentVersionsListState == ListLimitState.withinLimit) {
      return SaveVersionToListCompleted(name: name, showListsLimitWarning: false, isNewList: isNewList);
    }

    return SaveVersionToListCompleted(
      name: name,
      showListsLimitWarning: true,
      limitWarning: await getListLimitWarning(currentListState, currentVersionsListState, songbookId),
      isNewList: isNewList,
    );
  }

  Future<ListLimitWarning?> getListLimitWarning(
    ListLimitState currentListState,
    ListLimitState currentVersionsListState,
    int songbookId,
  ) async {
    final limitConstants = _getListLimitConstants();
    final listState = currentListState != ListLimitState.withinLimit ? currentListState : currentVersionsListState;

    return ListLimitWarning(
      limit: limitConstants.maxListsForFree,
      proLimit: limitConstants.maxListsForPro,
      listState: listState,
      isVersionLimit: currentVersionsListState != ListLimitState.withinLimit,
    );
  }

  Future<bool> isValidSongbookName(String name) async {
    final status = await _validateSongbookName(name);

    switch (status) {
      case SongbookNameValidation.existingName:
        return false;
      case SongbookNameValidation.validInput:
        return true;
    }
  }

  List<String> validatePreview(List<String?> preview) => _validateArtistImagePreview(preview);
}
