// coverage:ignore-file
import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';
import 'package:cifraclub/domain/user/use_cases/logout.dart';
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart';
import 'package:cifraclub/domain/user/use_cases/open_user_profile_page.dart';
import 'package:cifraclub/presentation/screens/genre/genre_entry.dart';
import 'package:cifraclub/presentation/screens/genres/genres_entry.dart';
import 'package:cifraclub/presentation/screens/home/home_entry.dart';
import 'package:cifraclub/presentation/screens/ntp_test/ntp_test_entry.dart';
import 'package:flutter/material.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:nav/nav.dart';

class DevScreen extends StatefulWidget {
  final GetCredentialStream getCredentialsStream;
  final OpenLoginPage openLoginView;
  final OpenUserProfilePage openUserProfilePage;
  final Logout logout;

  const DevScreen({Key? key, required this.getCredentialsStream, required this.openLoginView, required this.openUserProfilePage, required this.logout}) : super(key: key);

  @override
  State<DevScreen> createState() => _DevScreenState();
}

class _DevScreenState extends State<DevScreen> {
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
            leading: const Icon(Icons.music_note),
            title: Text(context.text.genreScreen),
            onTap: () {
              Nav.of(context).push(
                screenName: GenresEntry.name,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.accessible),
            title: const Text("Internal Genre"),
            onTap: () {
              Nav.of(context).push(
                screenName: GenreEntry.name,
                params: {GenreEntry.genreUrlParamKey: "mpb"},
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.house),
            title: const Text("Home"),
            onTap: () {
              Nav.of(context).push(
                screenName: HomeEntry.name,
              );
            },
          ),
        ],
      ),
    );
  }
}
