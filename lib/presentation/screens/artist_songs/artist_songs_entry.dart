// coverage:ignore-file
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_bloc.dart';
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class ArtistSongsEntry extends ScreenEntry {
  static const name = "ArtistSongsEntry";

  ArtistSongsEntry(super.params);

  @override
  String get screenName => name;

  @override
  String? get screenViewName => name;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArtistSongsBloc()..init(),
      child: const ArtistSongsScreen(),
    );
  }
}
