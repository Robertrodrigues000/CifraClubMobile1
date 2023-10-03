// coverage:ignore-file
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_bloc.dart';
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

import 'package:cifraclub/di/di_setup.dart';

class ArtistSongsEntry extends ScreenEntry {
  static const name = "ArtistSongs";
  static const artistUrlParamKey = "artistUrl";
  static const instrumentParamKey = "instrument";
  static const artistNameParamKey = "artistName";

  ArtistSongsEntry(super.params);

  static void push(Nav nav, String artistUrl, String instrument, String artistName) {
    nav.push(screenName: name, params: {
      artistUrlParamKey: artistUrl,
      instrumentParamKey: instrument,
      artistNameParamKey: artistName,
    });
  }

  String? get artistUrl => params[artistUrlParamKey];
  String? get instrument => params[instrumentParamKey];
  String? get artistName => params[artistNameParamKey];

  @override
  String get screenName => name;

  @override
  String? get screenViewName => name;

  @override
  Widget build(BuildContext context) {
    Instrument? instrumentFilter = instrument?.isNotEmpty == true ? Instrument.values.byName(instrument!) : null;
    return BlocProvider<ArtistSongsBloc>(
      create: (context) =>
          ArtistSongsBloc(getIt(), getIt(), getIt(), getIt(), instrument: instrumentFilter, artistUrl: artistUrl)
            ..init(),
      child: ArtistSongsScreen(
        artistName: artistName ?? "",
        versionOptionsBottomSheet: getIt(),
      ),
    );
  }
}
