// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/data/song/song_player_manager.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AudioPlayer extends StatefulWidget {
  final Duration totalDuration;
  final Duration actualTime;
  final SongPlayerState state;
  final VoidCallback onCancel;
  final Function(Duration) onTimeChanged;
  final VoidCallback onPlay;
  final VoidCallback onPause;
  final bool isScrolledUnder;

  const AudioPlayer({
    super.key,
    required this.totalDuration,
    required this.actualTime,
    required this.onCancel,
    required this.onTimeChanged,
    required this.state,
    required this.onPlay,
    required this.onPause,
    required this.isScrolledUnder,
  });

  @override
  State<AudioPlayer> createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  Duration? _currentSlideTime;

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: widget.isScrolledUnder ? context.colors.neutralSecondary : context.colors.neutralPrimary,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.appDimensionScheme.playerHorizontalPadding,
          vertical: context.appDimensionScheme.playerVerticalPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                widget.state == SongPlayerState.playing ? widget.onPause() : widget.onPlay();
              },
              child: Ink(
                height: 40,
                width: 40,
                child: SvgPicture.asset(
                  widget.state == SongPlayerState.playing ? AppSvgs.pauseIcon : AppSvgs.playIcon,
                  fit: BoxFit.none,
                  color: context.colors.textPrimary,
                ),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              _formatTime(_currentSlideTime ?? widget.actualTime),
              style: context.typography.subtitle7,
              textHeightBehavior:
                  const TextHeightBehavior(applyHeightToFirstAscent: false, applyHeightToLastDescent: false),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.playerSpaceBetweenActionAndSlider),
                child: SliderTheme(
                  data: SliderThemeData(
                    overlayShape: SliderComponentShape.noOverlay,
                    thumbColor: context.colors.primary,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 8.0,
                      elevation: 0,
                    ),
                    trackHeight: 4,
                    inactiveTrackColor: context.colors.neutralTertiary,
                  ),
                  child: Slider(
                    value: _currentSlideTime?.inSeconds.toDouble() ?? widget.actualTime.inSeconds.toDouble(),
                    onChanged: (value) {
                      final position = Duration(seconds: value.toInt());
                      setState(() {
                        _currentSlideTime = position;
                      });
                    },
                    onChangeEnd: (value) {
                      final position = Duration(seconds: value.toInt());
                      _currentSlideTime = null;
                      widget.onTimeChanged(position);
                    },
                    min: 0,
                    max: widget.totalDuration.inSeconds.toDouble(),
                  ),
                ),
              ),
            ),
            Text(
              "-${_formatTime(_calculateDurationLeft(widget.totalDuration, _currentSlideTime ?? widget.actualTime))}",
              style: context.typography.subtitle7,
              textHeightBehavior:
                  const TextHeightBehavior(applyHeightToFirstAscent: false, applyHeightToLastDescent: false),
            ),
            const SizedBox(width: 4),
            InkWell(
              onTap: widget.onCancel,
              child: Ink(
                height: 40,
                width: 40,
                child: SvgPicture.asset(
                  AppSvgs.closeIcon,
                  fit: BoxFit.none,
                  color: context.colors.textPrimary,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String _formatTime(Duration duration) {
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Duration _calculateDurationLeft(Duration total, Duration actual) {
    final minutes = total.inMinutes - actual.inMinutes;
    final seconds = (total.inSeconds % 60) - (actual.inSeconds % 60);
    return Duration(minutes: minutes, seconds: seconds);
  }
}
