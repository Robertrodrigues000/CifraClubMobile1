// coverage:ignore-file
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/widgets/version_configuration_tile.dart';
import 'package:flutter/material.dart';

class SelectedVersionSection extends StatelessWidget {
  const SelectedVersionSection({
    super.key,
    required this.instrument,
    required this.version,
    required this.onVersionChanged,
  });
  final Instrument instrument;
  final String version;
  final VoidCallback onVersionChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
          child: Text(
            context.text.version,
            style: context.typography.title6,
          ),
        ),
        SizedBox(
          height: context.appDimensionScheme.screenMargin,
        ),
        VersionConfigurationTile(
          name: instrument.getInstrumentName(context),
          onTap: onVersionChanged,
          child: Text(
            version,
            style: context.typography.subtitle5,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
