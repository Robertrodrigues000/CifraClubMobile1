import 'dart:async';
import 'dart:ui';
import 'package:cifraclub/domain/app/use_cases/share_link.dart';
import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit_state.dart';
import 'package:cifraclub/domain/preferences/use_cases/get_list_order_type_preference.dart';
import 'package:cifraclub/domain/preferences/use_cases/set_list_order_type_preference.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_versions_stream_by_songbook_id.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_songbook_stream_by_id.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_pro_status_stream.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:cifraclub/domain/version/use_cases/get_ordered_versions.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_state.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/list_order_type.dart';
import 'package:cifraclub/presentation/widgets/subscription_holder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class VersionsBloc extends Cubit<VersionsState> with SubscriptionHolder {
  final GetSongbookStreamById _getSongbookStreamById;
  final GetVersionsStreamBySongbookId _getVersionsStremBySongbookId;
  final ShareLink _shareLink;
  final GetVersionsLimitState _getVersionsLimitState;
  final GetProStatusStream _getProStatusStream;
  final GetVersionsLimit _getVersionsLimit;
  final SetListOrderTypePreferences _setOrderFilterPreferences;
  final GetListOrderTypePreferences _getOrderFilterPreferences;
  final GetOrderedVersions _getOrderedVersions;

  VersionsBloc(
    this._getSongbookStreamById,
    this._shareLink,
    this._getVersionsStremBySongbookId,
    this._getVersionsLimitState,
    this._getProStatusStream,
    this._getVersionsLimit,
    this._getOrderFilterPreferences,
    this._setOrderFilterPreferences,
    this._getOrderedVersions,
  ) : super(const VersionsState());

  Future<void> init(int? songbookId) async {
    await subscriptions.clear();
    _getProStatusStream().listen(_updateProStatus).addTo(subscriptions);

    if (songbookId != null) {
      final versionsStreamBroadcast = _getVersionsStremBySongbookId(songbookId).asBroadcastStream();
      final songbookStreamBroadcast = _getSongbookStreamById(songbookId).asBroadcastStream();

      final songbook = songbookStreamBroadcast.first;
      final versions = versionsStreamBroadcast.first;
      final result = await Future.wait([songbook, versions]);
      await _onFirstEmit(result[0] as Songbook?, result[1] as List<Version>);

      versionsStreamBroadcast.listen(_updateVersions).addTo(subscriptions);
      songbookStreamBroadcast.listen(_updateSongbook).addTo(subscriptions);
      _getVersionsLimitState(songbookId).listen(_updateVersionLimitState).addTo(subscriptions);
    }
  }

  void _updateSongbook(Songbook? songbook) {
    emit(state.copyWith(songbook: songbook));
  }

  void _updateVersions(List<Version> versions) {
    emit(state.copyWith(
      versionsCount: versions.length,
      versions: _getOrderedVersions(state.selectedListOrderType, versions, state.songbook?.type ?? ListType.user),
    ));
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

  Future<void> _onFirstEmit(Songbook? songbook, List<Version> versions) async {
    emit(state.copyWith(songbook: songbook, versions: versions, versionsCount: versions.length));

    if (songbook != null) {
      final orderTypeDefault = ListOrderType.getOrderTypeByKey(_getOrderFilterPreferences());

      if (songbook.type == ListType.recents ||
          (songbook.type != ListType.user && orderTypeDefault == ListOrderType.custom)) {
        emit(
          state.copyWith(
            selectedListOrderType: ListOrderType.recent,
            versions: _getOrderedVersions(ListOrderType.recent, versions, songbook.type),
          ),
        );
      } else {
        emit(
          state.copyWith(
            selectedListOrderType: orderTypeDefault,
            versions: _getOrderedVersions(orderTypeDefault, versions, songbook.type),
          ),
        );
      }
    }
  }

  Future<void> shareLink(String link, Rect? rect) async {
    await _shareLink(link: link, sharePositionOrigin: rect);
  }

  Future<void> onSelectedOrderType(ListOrderType orderListType) async {
    await _setOrderFilterPreferences(orderListType);
    emit(state.copyWith(
        selectedListOrderType: orderListType,
        versions: _getOrderedVersions(orderListType, state.versions, state.songbook?.type ?? ListType.user)));
  }

  @override
  Future<void> close() {
    disposeAll();
    return super.close();
  }
}
