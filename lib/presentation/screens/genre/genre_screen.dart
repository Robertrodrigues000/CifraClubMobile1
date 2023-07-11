import 'package:cifraclub/presentation/screens/genre/genre_bloc.dart';
import 'package:cifraclub/presentation/screens/genre/genre_state.dart';
import 'package:cifraclub/presentation/widgets/top_list_item.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  late GenreBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<GenreBloc>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc.requestTopArtists();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenreBloc, GenreState>(builder: (context, state) {
      return Scaffold(
        appBar: CosmosAppBar(
          title: Text(state.genreName ?? ""),
        ),
        body: Builder(
          builder: (context) {
            if (state is GenreLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GenreLoadedState) {
              return ListView.builder(
                itemCount: state.artists.length,
                itemBuilder: (context, index) {
                  return TopListItem(
                    title: state.artists[index].name,
                    imageUrl: state.artists[index].image?.size162,
                    ranking: (index + 1).toString(),
                    onTap: () {}, // coverage:ignore-line
                  );
                },
              );
            } else {
              return const Center(child: Text("Erro"));
            }
          },
        ),
      );
    });
  }
}
