import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/artist/artist_entry.dart';
import 'package:cifraclub/presentation/bottom_sheets/genres_bottom_sheet/genre_bottom_sheet.dart';
import 'package:cifraclub/presentation/screens/top_artists/top_artists_bloc.dart';
import 'package:cifraclub/presentation/screens/top_artists/top_artists_state.dart';
import 'package:cifraclub/presentation/screens/top_artists/widgets/top_artists.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget_type.dart';
import 'package:cifraclub/presentation/widgets/genres_capsule/genres_capsule.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nav/nav.dart';

class TopArtistsScreen extends StatefulWidget {
  const TopArtistsScreen(this._genreBottomSheet, {super.key});

  final GenreBottomSheet _genreBottomSheet;

  @override
  State<TopArtistsScreen> createState() => _TopArtistsScreenState();
}

class _TopArtistsScreenState extends State<TopArtistsScreen> {
  late final TopArtistsBloc _bloc = BlocProvider.of<TopArtistsBloc>(context);

  @override
  Widget build(BuildContext context) {
    final dimensions = context.appDimensionScheme;
    return Scaffold(
      appBar: CosmosAppBar(
        title: Text(
          context.text.topArtists,
          style: context.typography.title4.copyWith(color: context.colors.textPrimary),
        ),
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.only(left: context.appDimensionScheme.appBarMargin),
          child: InkWell(
            onTap: () => Nav.of(context).pop(), // coverage:ignore-line
            child: SizedBox(
              height: 48,
              width: 48,
              child: SvgPicture.asset(
                AppSvgs.backArrowIcon,
                fit: BoxFit.none,
                color: context.colors.textPrimary,
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<TopArtistsBloc, TopArtistsState>(
        bloc: _bloc,
        builder: (context, state) => Builder(
          builder: (context) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: dimensions.screenMargin),
                    child: GenresCapsule(
                      genres: state.genres,
                      selectedGenre: state.selectedGenre,
                      onGenreSelected: _bloc.onGenreSelected,
                      onMore: () async {
                        final result = await widget._genreBottomSheet.open(context);
                        if (result != null) {
                          _bloc.insertGenre(result);
                          return true;
                        }
                        return false;
                      },
                    ),
                  ),
                ),
                Builder(builder: (context) {
                  if (state.isLoadingArtists) {
                    return const SliverFillRemaining(child: Center(child: CircularProgressIndicator()));
                  } else if (state.error != null) {
                    return SliverFillRemaining(
                      child: Center(
                        child: ErrorDescriptionWidget(
                          typeError: state.error! is ConnectionError
                              ? ErrorDescriptionWidgetType.connection
                              : ErrorDescriptionWidgetType.server,
                          onClick: () => _bloc.requestTopArtists(genreUrl: state.selectedGenre),
                        ),
                      ),
                    );
                  } else {
                    return TopArtists(
                      topArtists: state.topArtists,
                      // coverage:ignore-start
                      onTap: (artist) => ArtistEntry.push(Nav.of(context), artist.url, artist.name),
                      // coverage:ignore-end
                      selectedGenre: state.selectedGenre,
                    );
                  }
                }),
              ],
            );
          },
        ),
      ),
    );
  }
}
