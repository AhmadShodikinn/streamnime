import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streaming_app/bloc/complete/complete_bloc.dart';
import 'package:streaming_app/bloc/complete/complete_event.dart';
import 'package:streaming_app/bloc/complete/complete_state.dart';
import 'package:streaming_app/presentation/widget/loading_indicator.dart';
import 'package:streaming_app/presentation/widget/showcase_item_grid.dart';

class CompletedPage extends StatefulWidget {
  const CompletedPage({Key? key}) : super(key: key);

  @override
  _CompletedPageState createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<CompleteBloc>().add(FetchMoreCompleteAnimeData());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: BlocBuilder<CompleteBloc, CompleteState>(
        builder: (context, state) {
          if (state is CompleteLoading) {
            // return const Center(child: CircularProgressIndicator());
            return LoadingIndicator();
          } else if (state is CompleteLoaded) {
            final completeList = state.completeData.data.animeList;

            return Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
              child: ShowcaseItemGrid(completeList, _scrollController),
            );
          } else if (state is CompleteError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox.shrink();
        },
      ),

      // body: Padding(
      //   padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
      //   child: ShowcaseItemGrid(),
      // ),
    );
  }
}
