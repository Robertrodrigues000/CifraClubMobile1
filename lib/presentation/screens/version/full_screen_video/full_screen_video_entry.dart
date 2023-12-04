// coverage:ignore-file
import 'package:cifraclub/presentation/screens/version/full_screen_video/full_screen_video_screen.dart';
import 'package:flutter/material.dart';
import 'package:nav/nav.dart';

class FullScreenVideoEntry extends ScreenEntry {
  static const name = "Full Screen Video";
  static const youtubeIdParamKey = "youtubeId";

  FullScreenVideoEntry(super.params);

  static void push(Nav nav, String youtubeId) {
    nav.push(screenName: name, params: {youtubeIdParamKey: youtubeId});
  }

  String? get youtubeId => params[youtubeIdParamKey];

  @override
  String get screenName => name;

  @override
  String? get screenViewName => name;

  @override
  Widget build(BuildContext context) {
    return FullScreenVideoScreen(videoId: youtubeId ?? "");
  }
}
