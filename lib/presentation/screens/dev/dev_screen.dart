// coverage:ignore-file
// ignore_for_file: avoid_print

import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';
import 'package:cifraclub/domain/user/use_cases/logout.dart';
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart';
import 'package:cifraclub/domain/user/use_cases/open_user_profile_page.dart';
import 'package:cifraclub/presentation/constants/app_urls.dart';
import 'package:cifraclub/presentation/screens/dev/dev_screen_bloc.dart';
import 'package:cifraclub/presentation/screens/dev/dev_screen_state.dart';
import 'package:cifraclub/presentation/screens/dev/widgets/bottom_sheet/dev_bottom_sheet.dart';
import 'package:cifraclub/presentation/screens/ntp_test/ntp_test_entry.dart';
import 'package:cifraclub/presentation/screens/songbook/bottom_sheet/list_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/screens/songbook/bottom_sheet/privacy_bottom_sheet.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/list_operation_dialogs/input_dialog.dart';
import 'package:cifraclub/presentation/widgets/loading_indicator_container.dart';
import 'package:cifraclub/presentation/widgets/share_builder.dart';
import 'package:flutter/material.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class DevScreen extends StatefulWidget {
  final GetCredentialStream getCredentialsStream;
  final OpenLoginPage openLoginView;
  final OpenUserProfilePage openUserProfilePage;
  final Logout logout;
  final DevBottomSheet devBottomSheet;

  const DevScreen(
      {Key? key,
      required this.getCredentialsStream,
      required this.openLoginView,
      required this.openUserProfilePage,
      required this.logout,
      required this.devBottomSheet})
      : super(key: key);

  @override
  State<DevScreen> createState() => _DevScreenState();
}

class _DevScreenState extends State<DevScreen> {
  late DevScreenBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<DevScreenBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DevScreenBloc, DevScreenState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text(context.text.developerPage),
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                StreamBuilder<UserCredential>(
                  stream: widget.getCredentialsStream(),
                  builder: (BuildContext context, AsyncSnapshot<UserCredential> snapshot) {
                    final credentials = snapshot.data;
                    if (credentials == null) {
                      return const SizedBox();
                    }
                    return Row(
                      children: [
                        if (!credentials.isUserLoggedIn)
                          MaterialButton(
                            onPressed: widget.openLoginView,
                            child: const Text("Open login page"),
                          )
                        else
                          MaterialButton(
                            onPressed: widget.openUserProfilePage,
                            child: const Text("Open user profile page"),
                          ),
                        Expanded(
                          child: Text(credentials.user?.name ?? ""),
                        ),
                        if (credentials.isUserLoggedIn)
                          IconButton(
                            onPressed: widget.logout,
                            icon: Icon(
                              Icons.directions_run,
                              color: context.colors.textPrimary,
                            ),
                          ),
                      ],
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.add_alarm,
                    color: context.colors.textPrimary,
                  ),
                  title: Text(state.isLoading ? "Desabilitar loading" : "Habilitar loading"),
                  onTap: () {
                    _bloc.toggleIsLoading();
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.access_time_filled,
                    color: context.colors.textPrimary,
                  ),
                  title: Text(context.text.ntpScreen),
                  onTap: () {
                    Nav.of(context).push(
                      screenName: NtpTestEntry.name,
                      params: {NtpTestEntry.colorParamKey: Colors.blue.value.toString()},
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.add_box_outlined,
                    color: context.colors.textPrimary,
                  ),
                  title: const Text("Bottom Sheet"),
                  onTap: () async {
                    final result = await widget.devBottomSheet.open(context);
                    print(result);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.accessible_forward_outlined,
                    color: context.colors.textPrimary,
                  ),
                  title: const Text("Compra"),
                  onTap: () {
                    _bloc.getProducts();
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.g_translate_rounded,
                    color: context.colors.textPrimary,
                  ),
                  title: const Text("Restore purchases"),
                  onTap: () {
                    _bloc.restorePurchases();
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.add_chart_sharp,
                    color: context.colors.textPrimary,
                  ),
                  title: const Text("Get orders"),
                  onTap: () {
                    _bloc.getOrders();
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.g_translate_rounded,
                    color: context.colors.textPrimary,
                  ),
                  title: const Text("List Option BS"),
                  onTap: () {
                    ListOptionsBottomSheet(
                      onTap: (options) {
                        switch (options) {
                          case OptionsBottomSheet.clear:
                            print("clear");
                            break;
                          case OptionsBottomSheet.delete:
                            print("delete");
                            break;
                          case OptionsBottomSheet.rename:
                            InputDialog.show(
                                context: context,
                                isNewList: false,
                                listName: "Lista",
                                onTap: (newName) {
                                  print("rename: $newName");
                                });
                            break;
                          case OptionsBottomSheet.privacy:
                            PrivacyBottomSheet(
                              isPublic: false,
                              onTap: (privacy) {
                                switch (privacy) {
                                  case true:
                                    print("public");
                                    break;
                                  case false:
                                    print("private");
                                    break;
                                }
                              },
                            ).show(context);
                            break;
                          case OptionsBottomSheet.share:
                            print("share");
                            break;
                        }
                      },
                      isUserList: true,
                    ).show(context);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.add_chart_sharp,
                    color: context.colors.textPrimary,
                  ),
                  title: const Text("Search Songs"),
                  onTap: () {
                    _bloc.getSongs();
                  },
                ),
                ShareLinkBuilder(
                  link: AppUrls.cifraListUrlFormat(549746031, 9992196),
                  builder: (context, shareLink) {
                    return ListTile(
                      leading: Icon(
                        Icons.share,
                        color: context.colors.textPrimary,
                      ),
                      title: const Text("Share Test"),
                      onTap: () async {
                        await shareLink();
                      },
                    );
                  },
                ),
              ],
            ),
            LoadingIndicatorContainer(
              isLoading: state.isLoading,
            ),
          ],
        ),
      );
    });
  }
}
