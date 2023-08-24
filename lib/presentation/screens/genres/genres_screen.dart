import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/genre/genre_entry.dart';
import 'package:cifraclub/presentation/screens/genres/genres_bloc.dart';
import 'package:cifraclub/presentation/screens/genres/genres_state.dart';
import 'package:cifraclub/presentation/screens/genres/widgets/genres_list.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget_type.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nav/nav.dart';

class GenresScreen extends StatefulWidget {
  const GenresScreen({super.key});

  @override
  State<GenresScreen> createState() => _GenresScreenState();
}

class _GenresScreenState extends State<GenresScreen> {
  late final GenresBloc _bloc = BlocProvider.of<GenresBloc>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CosmosAppBar(
        title: Text(
          context.text.musicalStyles,
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
      body: BlocBuilder<GenresBloc, GenresState>(
        builder: (context, state) {
          if (state is GenresLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GenresLoadedState) {
            return GenresList(
              genres: state.genres,
              onTap: (genre) => GenreEntry.push(Nav.of(context), genre.url, genre.name), // coverage:ignore-line
            );
          } else {
            return Center(
              child: ErrorDescriptionWidget(
                typeError: (state as GenresErrorState) is ConnectionError
                    ? ErrorDescriptionWidgetType.connection
                    : ErrorDescriptionWidgetType.server,
                onClick: () => _bloc.requestGenres(),
              ),
            );
          }
        },
      ),
    );
  }
}
