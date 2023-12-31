// coverage:ignore-file
import 'package:cifraclub/di/di_setup.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/song_player_middleware.dart';
import 'package:cifraclub/domain/home/models/video_lesson.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/register_email_middleware.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/font_size_middleware.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/version_options_bottom_sheet_middleware.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/auto_scroll_middleware.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/chord_middleware.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/content_middleware.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/floating_footer_bar_middleware.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/header_middleware.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/songbook_middleware.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/version_loader_middleware.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_bloc.dart';
import 'package:cifraclub/presentation/screens/version/version_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class VersionEntry extends ScreenEntry {
  static const name = "Version";
  static const artistUrlParamKey = "artistUrl";
  static const songUrlParamKey = "songUrl";
  static const songbookVersionIdParamKey = "songbookVersionId";
  static const artistNameParamKey = "artistName";
  static const songNameParamKey = "songName";
  static const youtubeIdParamKey = "youtubeId";
  static const instrumentParamKey = "instrument";
  static const versionLabelParamKey = "versionLabel";

  VersionEntry(super.params);

  static void pushFromSongbook(Nav nav, int songbookVersionId) {
    nav.push(screenName: name, params: {songbookVersionIdParamKey: songbookVersionId.toString()});
  }

  static void pushFromSong(Nav nav, String artistUrl, String songUrl, String artistName, String songName) {
    nav.push(
      screenName: name,
      params: {
        artistUrlParamKey: artistUrl,
        songUrlParamKey: songUrl,
        artistNameParamKey: artistName,
        songNameParamKey: songName,
      },
    );
  }

  static void pushFromVideoLesson(
    Nav nav,
    VideoLesson videoLesson,
  ) {
    nav.push(screenName: name, params: {
      artistUrlParamKey: videoLesson.artist?.url ?? "",
      songUrlParamKey: videoLesson.song?.url ?? "",
      artistNameParamKey: videoLesson.artist?.name ?? "",
      songNameParamKey: videoLesson.song?.name ?? "",
      youtubeIdParamKey: videoLesson.youtubeId,
      instrumentParamKey: videoLesson.instrument?.apiType.toString() ?? "",
      versionLabelParamKey: videoLesson.version?.label ?? "",
    });
  }

  String? get artistUrl => params[artistUrlParamKey];
  String? get songUrl => params[songUrlParamKey];
  int? get songbookVersionId => int.tryParse(params[songbookVersionIdParamKey] ?? "");
  String? get artistName => params[artistNameParamKey];
  String? get songName => params[songNameParamKey];
  String? get youtubeId => params[youtubeIdParamKey];
  Instrument? get instrument => Instrument.getInstrumentByType(int.tryParse(params[instrumentParamKey] ?? ""));
  String? get versionLabel => params[versionLabelParamKey];

  @override
  String get screenName => name;

  @override
  String? get screenViewName => name;

  @override
  Widget build(BuildContext context) {
    var devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final deviceWidth = MediaQuery.of(context).size.width;
    return BlocProvider<VersionBloc>(
      create: (context) => VersionBloc([
        getIt<VersionLoaderMiddleware>(),
        getIt<ContentMiddleware>(param1: deviceWidth),
        getIt<AutoScrollMiddleware>(param1: devicePixelRatio),
        getIt<SongbookMiddleware>(),
        getIt<ChordMiddleware>(),
        getIt<FloatingFooterBarMiddleware>(),
        getIt<HeaderMiddleware>(),
        getIt<VersionOptionsBottomSheetMiddleware>(),
        getIt<SongPlayerMiddleware>(),
        getIt<RegisterEmailMiddleware>(),
        getIt<FontSizeMiddleware>(),
      ], getIt())
        ..add(OnVersionInit(
          artistName: artistName,
          songName: songName,
          artistUrl: artistUrl,
          songUrl: songUrl,
          songbookVersionId: songbookVersionId,
          youtubeId: youtubeId,
          instrument: instrument,
          versionUrl: versionLabel,
        )),
      child: VersionScreen(getIt(), versionOptionsBottomSheet: getIt()),
    );
  }
}
