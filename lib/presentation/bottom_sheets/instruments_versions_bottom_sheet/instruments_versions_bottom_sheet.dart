import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/models/instrument_version.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/default_bottom_sheet.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/version/version_filter.dart';
import 'package:cifraclub/presentation/widgets/selectable_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InstrumentVersionsBottomSheet extends StatelessWidget {
  final List<({Instrument instrument, List<InstrumentVersion> versions})> instrumentVersions;
  final Instrument selectedInstrument;
  final String selectedVersionName;
  final Function(VersionFilter versionFilter) onTap;

  const InstrumentVersionsBottomSheet({
    super.key,
    required this.instrumentVersions,
    required this.selectedInstrument,
    required this.selectedVersionName,
    required this.onTap,
  });

  // coverage:ignore-start
  static void show(
    BuildContext context,
    List<({Instrument instrument, List<InstrumentVersion> versions})> instrumentVersions,
    Instrument selectedInstrument,
    String selectedVersionName,
    Function(VersionFilter versionFilter) onTap,
  ) {
    DefaultBottomSheet.showBottomSheet(
      context: context,
      child: InstrumentVersionsBottomSheet(
        instrumentVersions: instrumentVersions,
        selectedInstrument: selectedInstrument,
        selectedVersionName: selectedVersionName,
        onTap: onTap,
      ),
    );
  }
  // coverage:ignore-end

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: context.appDimensionScheme.screenMargin,
                right: context.appDimensionScheme.screenMargin,
                bottom: 16,
              ),
              child: Text(
                context.text.version,
                style: context.typography.title5,
              ),
            ),
            ExpansionPanelList.radio(
              expandedHeaderPadding: EdgeInsets.zero,
              elevation: 0,
              initialOpenPanelValue: Key("$selectedInstrument"),
              dividerColor: context.colors.neutralPrimary,
              expandIconColor: context.colors.neutralTwelfth,
              materialGapSize: 0,
              children: instrumentVersions.map(
                (instrumentVersion) {
                  return ExpansionPanelRadio(
                    value: Key("${instrumentVersion.instrument}"),
                    canTapOnHeader: true,
                    headerBuilder: (context, isExpanded) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: instrumentVersion.instrument.getInstrumentName(context),
                                  style: context.typography.title6.copyWith(color: context.colors.textPrimary),
                                ),
                                const WidgetSpan(child: SizedBox(width: 8)),
                                TextSpan(
                                  text: context.text.versionsCount(instrumentVersion.versions.length),
                                  style: context.typography.subtitle7,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    },
                    body: Column(
                      children: instrumentVersion.versions.map((e) {
                        final isSelected =
                            instrumentVersion.instrument == selectedInstrument && e.versionName == selectedVersionName;

                        return SelectableItem(
                          isSelected: isSelected,
                          onTap: () {
                            onTap(
                              VersionFilter(
                                instrument: instrumentVersion.instrument,
                                versionName: e.versionName,
                                versionUrl: e.versionUrl,
                                isVerified: e.isVerified,
                              ),
                            );
                            DefaultBottomSheet.close(context);
                          },
                          text: e.versionName,
                          isVerified: e.isVerified,
                          trailingIcon: e.videoLesson != null
                              ? SvgPicture.asset(
                                  AppSvgs.youtubeIcon,
                                  color: isSelected ? context.colors.primary : null,
                                )
                              : null,
                        );
                      }).toList(),
                    ),
                  );
                },
              ).toList(),
            )
          ],
        ),
      ),
    );
  }
}
