// coverage:ignore-file
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/widgets/version_configuration_tile.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class VersionSettingsSection extends StatelessWidget {
  const VersionSettingsSection({
    super.key,
    required this.isBeatVisible,
    required this.isTabVisible,
    required this.isLeftHanded,
    required this.onBeatVisibilityChanged,
    required this.onTabVisibilityChanged,
    required this.onLeftHandedChanged,
    required this.onTuningChanged,
    required this.onCapoChanged,
    required this.tuning,
    required this.capo,
    required this.instrument,
    required this.onTapTuner,
    required this.isTunerInstalled,
  });

  final Instrument instrument;
  final bool isBeatVisible;
  final bool isTabVisible;
  final bool isLeftHanded;
  final bool isTunerInstalled;
  final String tuning;
  final String capo;
  final Function(bool) onBeatVisibilityChanged;
  final Function(bool) onTabVisibilityChanged;
  final Function(bool) onLeftHandedChanged;
  final VoidCallback onTuningChanged;
  final VoidCallback onCapoChanged;
  final VoidCallback onTapTuner;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: ItemVisibility.beat.instruments.contains(instrument),
          child: SwitchListTile(
            value: isBeatVisible,
            onChanged: onBeatVisibilityChanged,
            title: Text(
              context.text.showBeat,
              style: context.typography.subtitle3,
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            contentPadding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
          ),
        ),
        Visibility(
          visible: ItemVisibility.tabs.instruments.contains(instrument),
          child: SwitchListTile(
            value: isTabVisible,
            onChanged: onTabVisibilityChanged,
            title: Text(context.text.showTabs, style: context.typography.subtitle3),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            contentPadding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
          ),
        ),
        VersionConfigurationTile(
          name: context.text.tuner,
          onTap: onTapTuner,
          child: SvgImage(
            assetPath: isTunerInstalled ? AppSvgs.openAppIcon : AppSvgs.downloadIcon,
            color: context.colors.textPrimary,
          ),
        ),
        Visibility(
          visible: ItemVisibility.tuning.instruments.contains(instrument),
          child: VersionConfigurationTile(
            name: context.text.tuning,
            onTap: onTuningChanged,
            child: Text(
              tuning,
              style: context.typography.subtitle5,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Visibility(
          visible: ItemVisibility.capo.instruments.contains(instrument),
          child: VersionConfigurationTile(
            name: context.text.capo,
            onTap: onCapoChanged,
            child: Text(
              capo,
              style: context.typography.subtitle5,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Visibility(
          visible: ItemVisibility.leftHanded.instruments.contains(instrument),
          child: SwitchListTile(
            value: isLeftHanded,
            onChanged: onLeftHandedChanged,
            title: Text(context.text.leftHanded, style: context.typography.subtitle3),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            contentPadding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
          ),
        ),
      ],
    );
  }
}

enum ItemVisibility {
  leftHanded([Instrument.guitar, Instrument.ukulele, Instrument.cavaco, Instrument.violaCaipira]),
  capo([Instrument.guitar]),
  tuning([Instrument.guitar, Instrument.violaCaipira]),
  tabs([Instrument.guitar]),
  beat([]);

  final List<Instrument> instruments;

  const ItemVisibility(this.instruments);
}
