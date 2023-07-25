import 'package:cifraclub/presentation/screens/version/version_bloc.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VersionScreen extends StatefulWidget {
  const VersionScreen({super.key});

  @override
  State<VersionScreen> createState() => _VersionScreenState();
}

class _VersionScreenState extends State<VersionScreen> {
  late final bloc = BlocProvider.of<VersionBloc>(context);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VersionBloc, VersionState>(builder: (context, state) {
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: Text(state.version?.content ?? "")),
          ],
        ),
      );
    });
  }
}
