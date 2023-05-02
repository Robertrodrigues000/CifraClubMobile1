import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/songbook/cifras/cifras_entry.dart';
import 'package:cifraclub/presentation/screens/songbook/cifras/cifras_screen.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_screen.dart';
import 'package:cifraclub/presentation/screens/songbook/songbook_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/songbook_state.dart';
import 'package:cifraclub/presentation/widgets/device_type_builder.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class SongbookScreen extends StatefulWidget {
  const SongbookScreen({super.key});

  @override
  State<SongbookScreen> createState() => _SongbookScreenState();
}

class _SongbookScreenState extends State<SongbookScreen> {
  late SongbookBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<SongbookBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return DeviceTypeBuilder(builder: (context, deviceType) {
      if (deviceType == DeviceType.tablet) {
        return BlocBuilder<SongbookBloc, SongbookState>(builder: (context, state) {
          return Scaffold(
            appBar: const CosmosAppBar(toolbarHeight: 0),
            body: MediaQuery.removeViewPadding(
              context: context,
              removeTop: true,
              child: Row(
                children: [
                  SizedBox(
                    width: 300,
                    child: ListsScreen(
                      onTapSongbook: (songbook) {
                        _bloc.onSelectSongbook(songbook);
                      },
                    ),
                  ),
                  VerticalDivider(
                    width: 1,
                    color: context.colors.neutralTertiary,
                  ),
                  Expanded(
                    child: CifrasScreen(
                      isTablet: true,
                      songbook: state.selectedSongbook,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      } else {
        return ListsScreen(
          onTapSongbook: (songbook) {
            Nav.of(context).push(screenName: CifrasEntry.name);
          },
        );
      }
    });
  }
}
