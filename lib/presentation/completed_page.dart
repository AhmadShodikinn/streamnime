import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streaming_app/bloc/complete/complete_bloc.dart';
import 'package:streaming_app/bloc/complete/complete_event.dart';
import 'package:streaming_app/bloc/complete/complete_state.dart';
import 'package:streaming_app/data/repository/complete_anime_repository.dart';
import 'package:streaming_app/presentation/widget/showcase_item_grid.dart';

class CompletedPage extends StatefulWidget {
  const CompletedPage({Key? key}) : super(key: key);

  @override
  _CompletedPageState createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          "Completed Anime",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Urbanist",
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: BlocProvider(
        create: (_) =>
            CompleteBloc(CompleteAnimeRepository())
              ..add(FetchCompleteAnimeData()),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocBuilder<CompleteBloc, CompleteState>(
            builder: (context, state) {
              if (state is CompleteLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CompleteLoaded) {
                final completeList = state.completeData.data.animeList;

                return Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
                  child: ShowcaseItemGrid(completeList),
                );
              } else if (state is CompleteError) {
                return Center(child: Text(state.message));
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),

      // body: Padding(
      //   padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
      //   child: ShowcaseItemGrid(),
      // ),
    );
  }
}
