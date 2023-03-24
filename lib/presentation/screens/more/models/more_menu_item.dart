import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/constants/app_urls.dart';
import 'package:cifraclub/presentation/screens/dev/dev_entry.dart';
import 'package:cifraclub/presentation/screens/genres/genres_entry.dart';
import 'package:cifraclub/presentation/screens/top_artists/top_artists_entry.dart';
import 'package:cifraclub/presentation/screens/top_songs/top_songs_entry.dart';
import 'package:flutter/material.dart';

class MoreMenuItem {
  final String title;
  final String imageAsset;
  final String? trailingTitle;
  final bool isTitleBold;
  final String destination;

  const MoreMenuItem({
    required this.title,
    required this.imageAsset,
    this.isTitleBold = false,
    this.trailingTitle,
    required this.destination,
  });

  bool get isExternalDestination => destination.startsWith('http');

  // coverage:ignore-start
  static List<MoreMenuItem> getAll(BuildContext context) {
    return [
      MoreMenuItem(
        title: context.text.topSongs,
        imageAsset: AppSvgs.moreTopSongsIcon,
        destination: TopSongsEntry.name,
      ),
      MoreMenuItem(
        title: context.text.topArtists,
        imageAsset: AppSvgs.moreTopArtistsIcon,
        destination: TopArtistsEntry.name,
      ),
      MoreMenuItem(
        title: context.text.genres,
        imageAsset: AppSvgs.moreGenresIcon,
        destination: GenresEntry.name,
      ),
      MoreMenuItem(
        title: context.text.sendNewCifra,
        imageAsset: AppSvgs.moreContribIcon,
        destination: DevScreenEntry.name,
      ),
      MoreMenuItem(
        title: context.text.cifraClubStore,
        imageAsset: AppSvgs.moreStoreIcon,
        destination: AppUrls.cifraClubStoreUrl,
      ),
      MoreMenuItem(
        title: context.text.manageSubscription,
        imageAsset: AppSvgs.moreManageSubscriptionIcon,
        destination: DevScreenEntry.name,
      ),
      MoreMenuItem(
        title: context.text.cifraClubPro,
        imageAsset: AppSvgs.moreSubscriptionIcon,
        destination: DevScreenEntry.name,
        isTitleBold: true,
        trailingTitle: context.text.premium,
      ),
      MoreMenuItem(
        title: context.text.termsOfUse,
        imageAsset: AppSvgs.moreTermsOfUseIcon,
        destination: AppUrls.termsOfUseUrl,
      ),
      MoreMenuItem(
        title: context.text.privacyPolicy,
        imageAsset: AppSvgs.morePrivacyPolicyIcon,
        destination: AppUrls.privacyPolicyUrl,
      ),
      MoreMenuItem(
        title: context.text.support,
        imageAsset: AppSvgs.moreSupportIcon,
        destination: AppUrls.supportUrl,
      ),
    ];
  }
  // coverage:ignore-end
}
