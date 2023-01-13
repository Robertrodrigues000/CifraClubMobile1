// coverage:ignore-file
import 'package:cifraclub/presentation/navigator/app_navigator.dart';
import 'package:cifraclub/presentation/screens/genre/genre_entry.dart';
import 'package:cifraclub/presentation/screens/genres/genres_entry.dart';
import 'package:cifraclub/presentation/screens/ntp_test/ntp_test_entry.dart';
import 'package:flutter/material.dart';
import 'package:cifraclub/extensions/build_context.dart';

class DevScreen extends StatefulWidget {
  const DevScreen({Key? key}) : super(key: key);

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
          ListTile(
            leading: const Icon(Icons.access_time_filled),
            title: Text(context.text.ntpScreen),
            onTap: () {
              AppNavigator.of(context).push(
                screenName: NtpTestEntry.name,
                params: {NtpTestEntry.colorParamKey: Colors.blue.value.toString()},
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.music_note),
            title: Text(context.text.genreScreen),
            onTap: () {
              AppNavigator.of(context).push(
                screenName: GenresEntry.name,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.accessible),
            title: const Text("Internal Genre"),
            onTap: () {
              AppNavigator.of(context).push(
                screenName: GenreEntry.name,
                params: {GenreEntry.genreUrlParamKey: "mpb"},
              );
            },
          ),
        ],
      ),
    );
  }
}
