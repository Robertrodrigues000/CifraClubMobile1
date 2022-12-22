import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/genres/genres_bloc.dart';
import 'package:cifraclub/presentation/screens/genres/genres_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestGenres extends StatelessWidget {
  const RequestGenres({Key? key, required this.stateString, required this.state}) : super(key: key);

  final String stateString;
  final GenresState state;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(stateString),
          const SizedBox(
            height: 16,
          ),
          if (state is GenresLoadingState)
            const CircularProgressIndicator()
          else
            ElevatedButton(
              onPressed: BlocProvider.of<GenresBloc>(context).requestGenres,
              child: Text(context.text.getIt),
            ),
        ],
      ),
    );
  }
}
