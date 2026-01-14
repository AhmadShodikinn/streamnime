import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streaming_app/bloc/search/search_bloc.dart';
import 'package:streaming_app/bloc/search/search_event.dart';
import 'package:streaming_app/bloc/search/search_state.dart';
import 'package:streaming_app/data/models/search_anime_model.dart';
import 'package:streaming_app/data/repository/search_anime_repository.dart';
import 'package:streaming_app/presentation/detail_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:streaming_app/presentation/constant/app_colors.dart';
import 'package:streaming_app/presentation/widget/loading_indicator.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  late SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = SearchBloc(SearchAnimeRepository());
    _searchBloc.add(FetchSearchAnimeData("one"));
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _searchBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
          child: Column(
            children: [
              SearchHeader(
                controller: _searchController,
                onSearch: () {
                  final keyword = _searchController.text.trim();

                  if (keyword.isNotEmpty) {
                    _searchBloc.add(FetchSearchAnimeData(keyword));
                  }
                },
              ),
              Expanded(
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state is SearchLoading) {
                      return LoadingIndicator();
                    } else if (state is SearchLoaded) {
                      final searchAnimeData = state.searchData.data.animeList;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Top Searches",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: searchAnimeData.length,
                              itemBuilder: (context, index) {
                                return CardSearch(
                                  searchAnimeItem: searchAnimeData[index],
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    } else if (state is SearchError) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Oops!",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Urbanist",
                                color: AppColors.softRed,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "It looks like you don't have a connection.",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Urbanist",
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget SearchHeader({
  required TextEditingController controller,
  required VoidCallback onSearch,
}) {
  return Row(
    children: [
      Expanded(
        child: TextField(
          controller: controller,
          onSubmitted: (_) => onSearch(),
          decoration: InputDecoration(
            hintText: 'Search',
            filled: true,
            fillColor: AppColors.softGreen.withOpacity(0.15),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: AppColors.softGreen,
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: AppColors.softGreen,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: AppColors.softGreen,
                width: 1.5,
              ),
            ),
          ),
        ),
      ),

      const SizedBox(width: 12),

      GestureDetector(
        onTap: onSearch,
        child: Container(
          height: 52,
          width: 52,
          decoration: BoxDecoration(
            color: AppColors.softGreen.withOpacity(0.15),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Center(
            child: Icon(
              FontAwesomeIcons.magnifyingGlass,
              color: AppColors.softGreen,
              size: 18,
            ),
          ),
        ),
      ),
    ],
  );
}

class CardSearch extends StatelessWidget {
  final SearchAnimeItem searchAnimeItem;

  const CardSearch({Key? key, required this.searchAnimeItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = searchAnimeItem.status;

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailPage(animeId: searchAnimeItem.animeId),
                ),
              );
            },
            child: Container(
              height: 100,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(searchAnimeItem.poster),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Center(
                child: Icon(Icons.play_circle, color: Colors.white, size: 40),
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  searchAnimeItem.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Row(
                  children: [
                    Text("Score :", style: const TextStyle(fontSize: 14)),
                    const SizedBox(width: 10),
                    Text(
                      searchAnimeItem.score.isEmpty
                          ? "none"
                          : searchAnimeItem.score,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: status == "Completed"
                        ? AppColors.softGreen
                        : Colors.amber,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
