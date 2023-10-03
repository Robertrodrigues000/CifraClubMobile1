import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/list_options_bottom_sheet/list_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_entry.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_screen.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_screen.dart';
import 'package:cifraclub/presentation/screens/songbook/songbook_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/songbook_state.dart';
import 'package:cifraclub/presentation/widgets/device_type_builder.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget_type.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class SongbookScreen extends StatefulWidget {
  const SongbookScreen(this.deviceType, this.listOptionsBottomSheet, {super.key});

  final ListOptionsBottomSheet listOptionsBottomSheet;
  final DeviceType deviceType;

  @override
  State<SongbookScreen> createState() => _SongbookScreenState();
}

class _SongbookScreenState extends State<SongbookScreen> {
  late final SongbookBloc _bloc = BlocProvider.of<SongbookBloc>(context);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongbookBloc, SongbookState>(
      builder: (context, state) {
        if (!(state.userCredential?.isUserLoggedIn ?? false)) {
          return Scaffold(
              appBar: CosmosAppBar(
                toolbarHeight: context.appDimensionScheme.appBarHeight,
                title: Text(context.text.lists, style: context.typography.title3),
                leading: null,
                automaticallyImplyLeading: false,
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: ErrorDescriptionWidget(
                      typeError: ErrorDescriptionWidgetType.loggedOut, onClick: _bloc.openLoginPage),
                ),
              ));
        } else if (widget.deviceType == DeviceType.tablet) {
          final width = MediaQuery.of(context).size.width;
          final double widthList = width < 1000 ? 300 : 400;

          return Scaffold(
            appBar: const CosmosAppBar(toolbarHeight: 0),
            body: MediaQuery.removeViewPadding(
              context: context,
              removeTop: true,
              child: Row(
                children: [
                  SizedBox(
                    width: widthList,
                    child: ListsScreen(
                      isTablet: true,
                      selectedSongbookId: state.selectedSongbookId,
                      onTapSongbook: (songbook) {
                        _bloc.onSelectSongbook(songbook.id);
                      },
                      listOptionsBottomSheet: widget.listOptionsBottomSheet,
                    ),
                  ),
                  VerticalDivider(
                    width: 1,
                    color: context.colors.neutralTertiary,
                  ),
                  Expanded(
                    child: VersionsScreen(
                      isTablet: true,
                      userId: state.userCredential?.user?.id,
                      songbookId: state.selectedSongbookId,
                      listOptionsBottomSheet: widget.listOptionsBottomSheet,
                      onDeleteSongbook: () {
                        _bloc.onSelectSongbook(ListType.recents.localId);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return ListsScreen(
            isTablet: false,
            onTapSongbook: (songbook) =>
                VersionsEntry.push(Nav.of(context), songbook.id ?? 0, state.userCredential?.user?.id ?? 0),
            listOptionsBottomSheet: widget.listOptionsBottomSheet,
          );
        }
      },
    );
  }
}
