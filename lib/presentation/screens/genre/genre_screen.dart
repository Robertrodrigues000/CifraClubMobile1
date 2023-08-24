import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/genre/genre_bloc.dart';
import 'package:cifraclub/presentation/screens/genre/genre_state.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget_type.dart';
import 'package:cifraclub/presentation/widgets/top_list_item.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nav/nav.dart';

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  late final GenreBloc _bloc = BlocProvider.of<GenreBloc>(context);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenreBloc, GenreState>(builder: (context, state) {
      return Scaffold(
        appBar: CosmosAppBar(
          title: Text(
            state.genreName ?? "",
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
        body: Builder(
          builder: (context) {
            if (state is GenreLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GenreLoadedState) {
              return ListView.builder(
                itemCount: state.artists.length,
                itemBuilder: (context, index) {
                  return TopListItem(
                    title: state.artists[index].name,
                    imageUrl: state.artists[index].image?.size162,
                    ranking: (index + 1).toString(),
                    onTap: () {}, // coverage:ignore-line
                  );
                },
              );
            } else {
              return Center(
                child: ErrorDescriptionWidget(
                  typeError: (state as GenreErrorState) is ConnectionError
                      ? ErrorDescriptionWidgetType.connection
                      : ErrorDescriptionWidgetType.server,
                  onClick: () => _bloc.requestTopArtists(),
                ),
              );
            }
          },
        ),
      );
    });
  }
}
