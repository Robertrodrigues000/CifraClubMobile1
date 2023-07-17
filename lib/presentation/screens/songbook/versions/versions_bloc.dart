import 'dart:async';
import 'dart:ui';
import 'package:cifraclub/domain/app/use_cases/share_link.dart';
import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit_state.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_versions_stream_by_songbook_id.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_songbook_stream_by_id.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_pro_status_stream.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class VersionsBloc extends Cubit<VersionsState> {
  final GetSongbookStreamById _getSongbookStreamById;
  final GetVersionsStreamBySongbookId _getVersionsStremBySongbookId;
  final ShareLink _shareLink;
  final GetVersionsLimitState _getVersionsLimitState;
  final GetProStatusStream _getProStatusStream;
  final GetVersionsLimit _getVersionsLimit;

  VersionsBloc(
    this._getSongbookStreamById,
    this._shareLink,
    this._getVersionsStremBySongbookId,
    this._getVersionsLimitState,
    this._getProStatusStream,
    this._getVersionsLimit,
  ) : super(const VersionsState());

  final CompositeSubscription _compositeSubscription = CompositeSubscription();

  Future<void> init(int? songbookId) async {
    await _compositeSubscription.clear();

    _getProStatusStream().listen(_updateProStatus).addTo(_compositeSubscription);
    if (songbookId != null) {
      _getSongbookStreamById(songbookId).listen(_updateSongbook).addTo(_compositeSubscription);
      _getVersionsStremBySongbookId(songbookId).listen(_updateVersions).addTo(_compositeSubscription);
      _getVersionsLimitState(songbookId).listen(_updateVersionLimitState).addTo(_compositeSubscription);
    }
  }

  void _updateSongbook(Songbook? songbook) {
    emit(state.copyWith(songbook: songbook));
  }

  void _updateVersions(List<Version> versions) {
    emit(state.copyWith(versions: versions, versionsCount: versions.length));
  }

  void _updateVersionLimitState(ListLimitState tabLimitState) {
    emit(state.copyWith(versionLimitState: tabLimitState));
  }

  Future<void> _updateProStatus(bool isPro) async {
    final versionsLimit = _getVersionsLimit(isPro);
    emit(state.copyWith(
      versionsLimit: versionsLimit,
      isPro: isPro,
    ));
  }

  Future<void> shareLink(String link, Rect? rect) async {
    await _shareLink(link: link, sharePositionOrigin: rect);
  }

  @override
  Future<void> close() {
    _compositeSubscription.dispose();
    return super.close();
  }
}
