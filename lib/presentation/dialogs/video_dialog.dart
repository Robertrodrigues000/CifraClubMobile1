import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/button_type.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/cifraclub_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoDialog extends StatefulWidget {
  const VideoDialog({
    super.key,
  });

  // coverage:ignore-start
  static Future<T?> show<T>({
    required BuildContext context,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return const VideoDialog();
      },
    );
  }

  @override
  State<VideoDialog> createState() => _VideoDialogState();
}

class _VideoDialogState extends State<VideoDialog> {
  var isYoutubeFullScreen = false;
  late final YoutubePlayerController _controller = YoutubePlayerController.fromVideoId(
    videoId: "2Rsz3JEbw0Y",
    params: const YoutubePlayerParams(
      showFullscreenButton: true,
    ),
  );

  @override
  void initState() {
    super.initState();

    _controller.setFullScreenListener((value) {
      isYoutubeFullScreen = value;
    });
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: YoutubePlayerScaffold(
        controller: _controller,
        builder: (BuildContext context, Widget player) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: player,
              ),
              const SizedBox(height: 24),
              CifraClubButton(
                type: ButtonType.solidBlack,
                innerPadding: EdgeInsets.zero,
                height: 40,
                width: 137,
                onPressed: () {
                  _controller.stopVideo();
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.close,
                      size: 16,
                      color: context.colors.textPrimaryInverse,
                    ),
                    const SizedBox(width: 8),
                    Text(context.text.closeVideo),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
