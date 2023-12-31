import 'dart:ui';

import 'package:cifraclub/domain/app/use_cases/share_link.dart';
import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/clear_versions_from_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/clear_recents.dart';
import 'package:cifraclub/domain/songbook/use_cases/delete_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_data.dart';
import 'package:cifraclub/domain/songbook/use_cases/validate_songbook_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typed_result/typed_result.dart';

class ListOptionsBottomSheetBloc extends Cubit {
  final DeleteSongbook _deleteSongbook;
  final UpdateSongbookData _updateSongbookData;
  final ValidateSongbookName _validateSongbookName;
  final ClearVersionsFromSongbook _clearSongsFromSongbook;
  final ShareLink _shareLink;
  final ClearRecents _clearRecents;

  ListOptionsBottomSheetBloc(
    this._deleteSongbook,
    this._updateSongbookData,
    this._validateSongbookName,
    this._clearSongsFromSongbook,
    this._shareLink,
    this._clearRecents,
  ) : super(null);

  Future<Result<void, RequestError>> updateSongbookData({
    required Songbook songbook,
    String? songbookName,
    bool? isPublic,
  }) async {
    return _updateSongbookData(songbook: songbook, name: songbookName, isPublic: isPublic);
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

  Future<Result<void, RequestError>> clearList(int? songbookId) async {
    if (songbookId != null) {
      if (songbookId == ListType.recents.localId) {
        return _clearRecents();
      }
      return _clearSongsFromSongbook(songbookId);
    } else {
      logger?.sendNonFatalCrash(exception: "Clear songbook with null Id"); // coverage:ignore-line
      return Err(ServerError());
    }
  }

  Future<void> shareLink(String link, Rect? rect) async {
    await _shareLink(link: link, sharePositionOrigin: rect);
  }

  Future<Result<void, RequestError>> deleteSongbook(int? songbookId) async {
    return _deleteSongbook(songbookId!);
  }
}
