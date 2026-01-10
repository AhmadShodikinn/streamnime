import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:streaming_app/data/database/anime_database.dart';
import 'package:streaming_app/data/models/saved_anime_model.dart';
import 'package:streaming_app/presentation/search_page.dart';
import 'package:streaming_app/presentation/widget/showcase_item_grid.dart';

class MyListPage extends StatefulWidget {
  const MyListPage({Key? key}) : super(key: key);

  @override
  _MyListPageState createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  final ScrollController _scrollController = ScrollController();

  List<SavedAnimeModel> _animeList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedAnime();
  }

  Future<void> _loadSavedAnime() async {
    final result = await AnimeDatabase.instance.getSavedAnime();

    setState(() {
      _animeList = result;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // leading: Padding(
        //   padding: const EdgeInsets.only(left: 15.0),
        //   child: Image.asset(
        //     'assets/images/Animplex.png',
        //     fit: BoxFit.contain,
        //     height: 30,
        //   ),
        // ),
        // leadingWidth: 80,
        // title: Text(
        //   "My List",
        //   style: TextStyle(
        //     color: Colors.black,
        //     fontSize: 22,
        //     fontWeight: FontWeight.w700,
        //   ),
        // ),
        title: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          titleSpacing: 0, // biar rapi ke kiri
          title: Row(
            children: [
              Image.asset(
                'assets/images/Animplex.png',
                height: 24, // icon size
              ),
              const SizedBox(width: 8),
              const Text(
                "My List",
                style: TextStyle(
                  fontFamily: "Urbanist",
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              FontAwesomeIcons.magnifyingGlass,
              size: 20,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SearchPage()),
              );
            },
          ),
        ],
        actionsPadding: EdgeInsets.only(right: 5),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _animeList.isEmpty
            ? const Center(
                child: Text(
                  "My List masih kosong",
                  style: TextStyle(fontSize: 16),
                ),
              )
            : ShowcaseItemGrid(_animeList, _scrollController),
      ),
    );
  }
}
