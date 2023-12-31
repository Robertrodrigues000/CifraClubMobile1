import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/albums/albums_bloc.dart';
import 'package:cifraclub/presentation/screens/albums/albums_state.dart';
import 'package:cifraclub/presentation/screens/albums/widgets/albums.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget_type.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nav/nav.dart';

class AlbumsScreen extends StatefulWidget {
  final String artistName;
  final String totalAlbums;

  const AlbumsScreen({super.key, required this.artistName, required this.totalAlbums});

  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  late final AlbumsBloc _bloc = BlocProvider.of<AlbumsBloc>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CosmosAppBar(
        title: Text(
          context.text.albums,
          style: context.typography.title6,
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
      body: BlocBuilder<AlbumsBloc, AlbumsState>(
        bloc: _bloc,
        builder: (context, state) => Builder(
          builder: (context) {
            if (state.error != null) {
              return Center(
                child: ErrorDescriptionWidget(
                  typeError: state.error is ConnectionError
                      ? ErrorDescriptionWidgetType.connection
                      : ErrorDescriptionWidgetType.server,
                  onClick: () => _bloc.getAlbums(),
                ),
              );
            } else {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: context.appDimensionScheme.screenMargin,
                        right: context.appDimensionScheme.screenMargin,
                        top: context.appDimensionScheme.screenMargin,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.artistName,
                            style: context.typography.title5,
                          ),
                          Text(
                            "${widget.totalAlbums} ${context.text.albums}",
                            style: context.typography.subtitle5,
                          ),
                          SizedBox(
                            height: context.appDimensionScheme.screenMargin,
                          )
                        ],
                      ),
                    ),
                  ),
                  if (state.isLoading)
                    const SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.only(bottom: 32),
                      sliver: Albums(albums: state.albums),
                    ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
