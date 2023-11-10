import 'package:cifraclub/domain/app/use_cases/share_link.dart';
import 'package:cifraclub/domain/songbook/use_cases/favorite_unfavorite_version.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_is_favorite_version_by_song_id.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart';
import 'package:cifraclub/domain/version/models/musical_scale.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/models/tuning.dart';
import 'package:cifraclub/domain/version/models/version_data.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/save_version_to_list_bottom_sheet/save_version_to_list_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/tuning_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet_bloc.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet_state.dart';
import 'package:cifraclub/domain/songbook/models/version_options_result.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/bottom_sheets/default_bottom_sheet.dart';
import 'package:cifraclub/presentation/constants/app_urls.dart';
import 'package:cifraclub/presentation/widgets/icon_text_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VersionOptionsBottomSheet {
  final SaveVersionToListBottomSheet saveToListBottomSheet;
  final GetIsFavoriteVersionBySongId _getIsFavoriteVersionBySongId;
  final GetCredentialStream _getCredentialStream;
  final OpenLoginPage _openLoginView;
  final FavoriteUnfavoriteVersion _favoriteUnfavoriteVersion;
  final ShareLink _shareLink;

  const VersionOptionsBottomSheet(
    this.saveToListBottomSheet,
    this._getIsFavoriteVersionBySongId,
    this._getCredentialStream,
    this._openLoginView,
    this._shareLink,
    this._favoriteUnfavoriteVersion,
  );

  // coverage:ignore-start
  Future<void> show({
    required BuildContext context,
    required String artistUrl,
    required String songUrl,
    required int songId,
    VersionData? versionData,
    VersionOptionsBottomSheetBloc? bloc,
  }) {
    return _show(
      context,
      artistUrl,
      songUrl,
      songId,
      versionData,
      bloc ??
          VersionOptionsBottomSheetBloc(
            _getIsFavoriteVersionBySongId,
            _getCredentialStream,
            _openLoginView,
            _shareLink,
            _favoriteUnfavoriteVersion,
            songId,
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
    VersionData? versionData,
    VersionOptionsBottomSheetBloc bloc,
  ) {
    final controller = ScrollController();

    final options = List<VersionOptionsBottomSheetItem>.from(VersionOptionsBottomSheetItem.values);

    return DefaultBottomSheet.showBottomSheet(
      child: BlocProvider(
        create: (_) => bloc,
        child: BlocBuilder<VersionOptionsBottomSheetBloc, VersionOptionsBottomSheetState>(builder: (context, state) {
          return SingleChildScrollView(
            controller: controller,
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
                    child: Text(
                      context.text.versionOptionsBottomSheet,
                      style: context.typography.title5,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ...options.map(
                    (e) {
                      return IconTextTile(
                        // coverage:ignore-start
                        onClick: () async {
                          switch (e) {
                            case VersionOptionsBottomSheetItem.saveVersion:
                              if (context.mounted) {
                                DefaultBottomSheet.close(context);
                              }
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
                            case VersionOptionsBottomSheetItem.favoriteVersion:
                              if (context.mounted) {
                                DefaultBottomSheet.close(context);
                              }
                              if (state.isLoggedIn) {
                                final result = await bloc.onFavorite(artistUrl, songUrl);
                                if (screenContext.mounted) {
                                  handleResult(screenContext, result);
                                }
                              } else {
                                bloc.openLoginPage();
                              }
                            case VersionOptionsBottomSheetItem.share:
                              if (context.mounted) {
                                DefaultBottomSheet.close(context);
                                final box = context.findRenderObject() as RenderBox?;
                                final rect = box != null ? box.localToGlobal(Offset.zero) & box.size : null;
                                final link = AppUrls.shareVersionWithConfig(
                                  artistUrl: artistUrl,
                                  songUrl: songUrl,
                                  instrument: versionData?.instrument,
                                  capo: versionData?.capo.capoId,
                                  key:
                                      versionData?.key != null ? MusicalScale.getMusicalScale(versionData!.key!) : null,
                                  tuning: versionData?.tuning?.value,
                                  versionUrl: versionData?.versionUrl,
                                );
                                await bloc.shareLink(link, rect);
                              }
                            case VersionOptionsBottomSheetItem.correctVersion:
                              //TODO
                              if (context.mounted) {
                                TuningBottomSheet.show(context, (tuning) {
                                  // ignore: avoid_print
                                  print("Tuning value: $tuning");
                                }, Tuning.defaultTuning, Instrument.guitar);
                              }
                          }
                        },
                        // coverage:ignore-end
                        text: e.getText(
                            context, (e == VersionOptionsBottomSheetItem.favoriteVersion ? state.isFavorite : false)),
                        leadingIconAsset: e.icon,
                      );
                    },
                  )
                ],
              ),
            ),
          );
        }),
      ),
      context: screenContext,
      scrollController: controller,
    );
  }
}

// coverage:ignore-start
void handleResult(BuildContext context, VersionOptionsResult result) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  switch (result) {
    case FavoriteVersionSuccess():
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.text.favoriteVersionMessage)));
    case UnFavoriteVersionSuccess():
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.text.unFavoriteVersionMessage)));
    case FavoriteVersionError():
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.text.favoriteVersionErrorMessage)));
    case UnFavoriteVersionError():
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.text.unFavoriteVersionErrorMessage)));
  }
}
// coverage:ignore-end

enum VersionOptionsBottomSheetItem {
  saveVersion(AppSvgs.saveVersionIcon),
  favoriteVersion(AppSvgs.favoriteVersionIcon),
  correctVersion(AppSvgs.correctVersionIcon),
  share(AppSvgs.shareIcon);

  final String icon;

  const VersionOptionsBottomSheetItem(this.icon);

  String getText(BuildContext context, bool isFavorite) {
    switch (this) {
      case VersionOptionsBottomSheetItem.saveVersion:
        return context.text.saveVersionToList;
      case VersionOptionsBottomSheetItem.favoriteVersion:
        return isFavorite ? context.text.unFavoriteVersion : context.text.favoriteVersion;
      case VersionOptionsBottomSheetItem.correctVersion:
        return context.text.correctVersion;
      case VersionOptionsBottomSheetItem.share:
        return context.text.share;
    }
  }
}
