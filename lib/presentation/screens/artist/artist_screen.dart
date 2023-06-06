// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/artist/artist_bloc.dart';
import 'package:cifraclub/presentation/screens/artist/artist_state.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/artist_song_item.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/artist_title.dart';
import 'package:cifraclub/presentation/widgets/cosmos_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nav/nav.dart';

class ArtistScreen extends StatefulWidget {
  const ArtistScreen({super.key, required this.name});
  final String name;
  @override
  State<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  late ArtistBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ArtistBloc>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc.getArtistSongs();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArtistBloc, ArtistState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CosmosAppBar(
            title: Text(widget.name, style: context.typography.title3),
            toolbarHeight: context.appDimensionScheme.appBarHeight,
            automaticallyImplyLeading: false,
            //TODO: implementar title spacing no cosmos e depois adicionar aqui
            leading: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(width: context.appDimensionScheme.appBarMargin),
                InkWell(
                  onTap: () => Nav.of(context).pop(),
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: SvgPicture.asset(
                      AppSvgs.backArrowIcon,
                      fit: BoxFit.none,
                      color: context.colors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: CustomScrollView(
            slivers: [
              ArtistTitle(
                title: context.text.mostAccessed,
                verticalPadding: context.appDimensionScheme.screenMargin,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: state.songs.length,
                  (context, index) => ArtistSongItem(
                    onTap: () {},
                    onOptionsTap: () {},
                    name: state.songs[index].name,
                    ranking: index + 1,
                    isVerified: state.songs[index].verified,
                    hasVideolessons: state.songs[index].videoLessons > 0,
                  ),
                ),
              ),
              ArtistTitle(
                title: context.text.albums,
                verticalPadding: context.appDimensionScheme.screenMargin,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: state.albuns.length,
                  (context, index) => ListTile(
                    title: Text("Albuns -- ${state.albuns[index]}"),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}