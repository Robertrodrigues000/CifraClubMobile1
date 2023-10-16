import 'dart:async';
import 'dart:ui';
import 'package:cifraclub/domain/app/use_cases/share_link.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_songbook_by_id.dart';
import 'package:cifraclub/domain/songbook/use_cases/validate_artist_image_preview.dart';
import 'package:cifraclub/domain/version/use_cases/get_ordered_versions.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/list_order_type.dart';
import 'package:cifraclub/presentation/screens/songbook/versions_shared/versions_shared_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typed_result/typed_result.dart';

class VersionsSharedBloc extends Cubit<VersionsSharedState> {
  final GetSongbookById _getSongbookById;
  final ShareLink _shareLink;

  final GetOrderedVersions _getOrderedVersions;
  final ValidateArtistImagePreview _validateArtistImagePreview;

  VersionsSharedBloc(
    this._shareLink,
    this._getOrderedVersions,
    this._validateArtistImagePreview,
    this._getSongbookById,
  ) : super(const VersionsSharedState());

  Future<void> init(int? songbookId) async {
    if (songbookId != null) {
      final result = await _getSongbookById(songbookId);

      final songbook = result.get()?.songbook;
      final versions = result.get()?.versions ?? [];

      if (songbook != null) {
        emit(state.copyWith(
            error: null,
            songbook: songbook,
            selectedListOrderType: ListOrderType.recent,
            versions: _getOrderedVersions(ListOrderType.recent, versions, songbook.type)));
      } else {
        emit(state.copyWith(error: result.getError()));
      }
    }
  }

  Future<void> shareLink(String link, Rect? rect) async {
    await _shareLink(link: link, sharePositionOrigin: rect);
  }

  Future<void> onSelectedOrderType(ListOrderType orderListType) async {
    emit(state.copyWith(
        selectedListOrderType: orderListType,
        versions: _getOrderedVersions(orderListType, state.versions, state.songbook?.type ?? ListType.user)));
  }

  List<String> getPreview() {
    if (state.songbook == null || state.songbook!.preview.isEmpty) {
      return [];
    }
    return _validateArtistImagePreview(state.songbook?.preview ?? []);
  }
}
