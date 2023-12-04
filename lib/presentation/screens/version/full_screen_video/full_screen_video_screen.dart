// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nav/nav.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class FullScreenVideoScreen extends StatefulWidget {
  final String videoId;
  const FullScreenVideoScreen({super.key, required this.videoId});

  @override
  State<FullScreenVideoScreen> createState() => _FullScreenVideoScreenState();
}

class _FullScreenVideoScreenState extends State<FullScreenVideoScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        mute: false,
        showControls: true,
        showFullscreenButton: true,
      ),
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    _controller.loadVideoById(videoId: widget.videoId);

    _controller.setFullScreenListener((isFullScreen) {
      if (!isFullScreen) {
        Nav.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerScaffold(
      enableFullScreenOnVerticalDrag: false,
      builder: (context, player) {
        return player;
      },
      controller: _controller,
    );
  }
}
