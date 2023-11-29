import 'package:cifraclub/domain/app/use_cases/is_app_installed.dart';
import 'package:cifraclub/domain/app/use_cases/open_app_or_store.dart';
import 'package:cifraclub/domain/app/use_cases/share_link.dart';
import 'package:cifraclub/domain/songbook/use_cases/favorite_unfavorite_version.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_is_favorite_version_by_song_id.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart';
import 'package:cifraclub/domain/version/models/musical_scale.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/models/version_data.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/save_version_to_list_bottom_sheet/save_version_to_list_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet_action.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet_bloc.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet_state.dart';
import 'package:cifraclub/presentation/bottom_sheets/default_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/widgets/key_section.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/widgets/selected_version_section.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/widgets/version_settings_section.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/widgets/version_options_section.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/constants/app_urls.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/button_type.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/cifraclub_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VersionOptionsBottomSheet {
  final SaveVersionToListBottomSheet saveToListBottomSheet;
  final GetIsFavoriteVersionBySongId _getIsFavoriteVersionBySongId;
  final GetCredentialStream _getCredentialStream;
  final OpenLoginPage _openLoginView;
  final FavoriteUnfavoriteVersion _favoriteUnfavoriteVersion;
  final ShareLink _shareLink;
  final OpenAppOrStore _openAppOrStore;
  final IsAppInstalled _isAppInstalled;

  const VersionOptionsBottomSheet(
    this.saveToListBottomSheet,
    this._getIsFavoriteVersionBySongId,
    this._getCredentialStream,
    this._openLoginView,
    this._shareLink,
    this._openAppOrStore,
    this._isAppInstalled,
    this._favoriteUnfavoriteVersion,
  );

  // coverage:ignore-start
  Future<void> show({
    required BuildContext context,
    required String artistUrl,
    required String songUrl,
    required int songId,
    bool isTabsVisible = false,
    bool isVersionBottomSheet = false,
    VersionData? versionData,
    bool isPro = false,
    Function(VersionOptionsBottomSheetAction)? onAction,
    VersionOptionsBottomSheetBloc? bloc,
  }) {
    return _show(
      context,
      artistUrl,
      songUrl,
      songId,
      isVersionBottomSheet,
      versionData,
      onAction,
      bloc ??
          VersionOptionsBottomSheetBloc(
            _getIsFavoriteVersionBySongId,
            _getCredentialStream,
            _openLoginView,
            _shareLink,
            _openAppOrStore,
            _isAppInstalled,
            _favoriteUnfavoriteVersion,
            songId,
            versionData,
            isPro,
            isTabsVisible,
          )
        ..init(),
    );
  }
  // coverage:ignore-end

  Future<void> _show(
    BuildContext screenContext,
    String artistUrl,
    String songUrl,
    int songId,
    bool isVersionBottomSheet,
    VersionData? versionData,
    Function(VersionOptionsBottomSheetAction)? onAction,
    VersionOptionsBottomSheetBloc bloc,
  ) {
    final controller = ScrollController();
    final keyVisibilityInstruments = [Instrument.drums, Instrument.bass, Instrument.harmonica];
    return DefaultBottomSheet.showBottomSheet(
      child: BlocProvider(
        create: (_) => bloc,
        child: BlocBuilder<VersionOptionsBottomSheetBloc, VersionOptionsBottomSheetState>(builder: (context, state) {
          return SingleChildScrollView(
            controller: controller,
            child: SafeArea(
              child: Column(
                children: [
                  VersionOptionsSection(
                    onSaveVersionToList: () async {
                      if (state.isLoggedIn) {
                        await saveToListBottomSheet.show(
                          context: screenContext,
                          artistUrl: artistUrl,
                          songUrl: songUrl,
                          versionData: versionData,
                        );
                      } else {
                        bloc.openLoginPage();
                      }
                    },
                    onFavoriteVersion: () async {
                      if (state.isLoggedIn) {
                        final result = await bloc.onFavorite(artistUrl, songUrl);
                        if (screenContext.mounted) {
                          handleResult(screenContext, result);
                        }
                      } else {
                        bloc.openLoginPage();
                      }
                    },
                    onShareVersion: () async {
                      if (context.mounted) {
                        DefaultBottomSheet.close(context);
                        final box = context.findRenderObject() as RenderBox?;
                        final rect = box != null ? box.localToGlobal(Offset.zero) & box.size : null;
                        final link = AppUrls.shareVersionWithConfig(
                          artistUrl: artistUrl,
                          songUrl: songUrl,
                          instrument: versionData?.instrument,
                          capo: versionData?.capo.capoId,
                          key: versionData?.key != null ? MusicalScale.getMusicalScale(versionData!.key!) : null,
                          tuning: versionData?.tuning?.value,
                          versionUrl: versionData?.versionUrl,
                        );
                        await bloc.shareLink(link, rect);
                      }
                    },
                    onSetFontSize: () => onAction?.call(OnVersionBottomSheetTapOnFontSize()), // coverage:ignore-line
                    isVersionBottomSheet: isVersionBottomSheet,
                    isFavorite: state.isFavorite,
                    isPro: state.isPro,
                  ),
                  if (isVersionBottomSheet) ...[
                    SizedBox(
                      height: context.appDimensionScheme.errorWidgetButtonSpace,
                    ),
                    SelectedVersionSection(
                      instrument: state.instrument,
                      version: state.selectedVersion,
                      // coverage:ignore-start
                      onVersionChanged: () {
                        if (context.mounted) {
                          DefaultBottomSheet.close(context);
                        }
                        onAction?.call(OnVersionBottomSheetTapOnVersion());
                      },
                      // coverage:ignore-end
                    ),
                    Visibility(
                      visible: !keyVisibilityInstruments.contains(state.instrument),
                      child: Column(
                        children: [
                          SizedBox(
                            height: context.appDimensionScheme.errorWidgetButtonSpace,
                          ),
                          KeySection(
                            musicalScale: state.musicalScale,
                            originalKey: state.originalKey,
                            selectedKey: state.selectedKey,
                            isVersionOptions: true,
                            // coverage:ignore-start
                            onKeySelected: (key) {
                              onAction?.call(OnVersionBottomSheetTapOnChangeKey(key));
                            },
                            // coverage:ignore-end
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: context.appDimensionScheme.errorWidgetButtonSpace,
                    ),
                    VersionSettingsSection(
                      instrument: state.instrument,
                      isBeatVisible: state.isBeatVisible,
                      isTabVisible: state.isTabsVisible,
                      isLeftHanded: state.isLeftHanded,
                      isTunerInstalled: state.isTunerInstalled,
                      tuning: state.tuning,
                      capo: state.capo,
                      // coverage:ignore-start
                      onBeatVisibilityChanged: (isVisible) {
                        bloc.toggleBeatVisibility();
                      },
                      // coverage:ignore-end
                      onTabVisibilityChanged: (isVisible) {
                        onAction?.call(OnVersionBottomSheetTapOnTabsVisibility(isVisible));
                        bloc.toggleTabsVisibility();
                      },
                      onLeftHandedChanged: (isLeftHanded) {
                        bloc.toggleLeftHanded();
                      },
                      // coverage:ignore-start
                      onTuningChanged: () {
                        if (context.mounted) {
                          DefaultBottomSheet.close(context);
                        }
                        onAction?.call(OnVersionBottomSheetTapOnTuning());
                      },
                      onCapoChanged: () {
                        if (context.mounted) {
                          DefaultBottomSheet.close(context);
                        }
                        onAction?.call(OnVersionBottomSheetTapOnCapo());
                      },
                      // coverage:ignore-end
                      onTapTuner: () => bloc.openAppOrStore(),
                    ),
                    Visibility(
                      visible: !keyVisibilityInstruments.contains(state.instrument),
                      child: CifraClubButton(
                        type: ButtonType.outline,
                        padding: EdgeInsets.all(context.appDimensionScheme.screenMargin),
                        width: double.infinity,
                        onPressed: () {}, // coverage:ignore-line
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppSvgs.resetSettingsIcon),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Text(context.text.resetSettings)
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ),
      context: screenContext,
      scrollController: controller,
      heightMaxFactor: 0.9,
    );
  }
}
