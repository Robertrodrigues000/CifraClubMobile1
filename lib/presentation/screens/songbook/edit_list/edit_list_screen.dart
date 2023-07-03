import 'dart:ui';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/dialogs/list_operation_dialogs/edit_mode_dialog.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_state.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/version_tile.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/button_type.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/cifraclub_button.dart';
import 'package:cifraclub/presentation/widgets/cosmos_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditListScreen extends StatefulWidget {
  const EditListScreen({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  State<EditListScreen> createState() => _EditListScreenState();
}

class _EditListScreenState extends State<EditListScreen> {
  late final bloc = BlocProvider.of<EditListBloc>(context);
  late final navigator = Navigator.of(context, rootNavigator: true);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditListBloc, EditListState>(
      builder: (context, state) {
        return WillPopScope(
          // coverage:ignore-start
          onWillPop: () async {
            _shouldOpenDialog(context, state.hasChanges);
            return !state.hasChanges;
          },
          // coverage:ignore-end
          child: Scaffold(
            appBar: CosmosAppBar(
              title: Text(
                widget.name,
                style: context.typography.title3,
              ),
              toolbarHeight: context.appDimensionScheme.appBarHeight,
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: () => _shouldOpenDialog(context, state.hasChanges),
                icon: SvgPicture.asset(
                  AppSvgs.backArrowIcon,
                  fit: BoxFit.none,
                  color: context.colors.textPrimary,
                ),
              ),
            ),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ReorderableListView.builder(
                    proxyDecorator: proxyDecorator,
                    itemBuilder: (BuildContext context, int index) {
                      var item = state.versions[index];
                      return VersionTile(
                        key: Key("$index"),
                        song: item.name,
                        artist: item.artist.name,
                        type: "Violão",
                        tone: item.tone,
                        onDeleteTap: () => bloc.deleteVersion(index),
                        editable: true,
                        index: index,
                      );
                    },
                    itemCount: state.versions.length,
                    onReorder: bloc.onReorderList,
                    scrollDirection: Axis.vertical,
                    buildDefaultDragHandles: false,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
                  child: Container(
                    color: context.colors.textPrimaryInverse,
                    child: Padding(
                      padding: EdgeInsets.all(context.appDimensionScheme.internalMargin),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: CifraClubButton(
                              type: ButtonType.outline,
                              onPressed: () => _shouldOpenDialog(context, state.hasChanges),
                              child: Text(context.text.cancel),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: CifraClubButton(
                              type: ButtonType.solidOrange,
                              onPressed: bloc.save,
                              child: Text(context.text.save),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _shouldOpenDialog(BuildContext context, bool hasChanges) async {
    if (hasChanges) {
      final editModeDialog = await EditModeDialog.show(context);
      if (editModeDialog && context.mounted) {
        navigator.pop();
      }
    } else {
      navigator.pop();
    }
  }

  // coverage:ignore-start
  Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final double animValue = Curves.easeInOut.transform(animation.value);
        final double elevation = lerpDouble(0, 6, animValue)!;
        return Material(
          elevation: elevation,
          color: context.colors.neutralSecondary,
          child: child,
        );
      },
      child: child,
    );
  }
// coverage:ignore-end
}
