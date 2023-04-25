// coverage:ignore-file
import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';
import 'package:cifraclub/domain/user/use_cases/logout.dart';
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart';
import 'package:cifraclub/domain/user/use_cases/open_user_profile_page.dart';
import 'package:cifraclub/presentation/screens/dev/dev_screen_bloc.dart';
import 'package:cifraclub/presentation/screens/dev/widgets/bottom_sheet/dev_bottom_sheet.dart';
import 'package:cifraclub/presentation/screens/ntp_test/ntp_test_entry.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(context.text.developerPage),
      ),
      body: ListView(
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
                      icon: const Icon(Icons.directions_run),
                    ),
                ],
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.access_time_filled),
            title: Text(context.text.ntpScreen),
            onTap: () {
              Nav.of(context).push(
                screenName: NtpTestEntry.name,
                params: {NtpTestEntry.colorParamKey: Colors.blue.value.toString()},
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_box_outlined),
            title: const Text("Bottom Sheet"),
            onTap: () async {
              final result = await widget.devBottomSheet.open(context);
              // ignore: avoid_print
              print(result);
            },
          ),
          ListTile(
            leading: const Icon(Icons.accessible_forward_outlined),
            title: const Text("Compra"),
            onTap: () {
              _bloc.getProducts();
            },
          ),
          ListTile(
            leading: const Icon(Icons.g_translate_rounded),
            title: const Text("Restore purchases"),
            onTap: () {
              _bloc.restorePurchases();
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_chart_sharp),
            title: const Text("Get orders"),
            onTap: () {
              _bloc.getOrders();
            },
          ),
        ],
      ),
    );
  }
}
