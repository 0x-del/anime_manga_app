import 'package:flutter/material.dart';
import '../models/anime_model.dart';
import '../services/anime_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Anime> _animeList = [];

  @override
  void initState() {
    super.initState();
    _loadAnime(); // 👈 Call it during init
  }

  void _loadAnime() async {
    print("Calling AnimeService.fetchAnime...");
    final animeList = await AnimeService.fetchAnime();
    print("Fetched Anime: $animeList"); // 👈 Add debug print

    setState(() {
      _animeList = animeList;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Building HomePage UI with ${_animeList.length} anime");

    return Scaffold(
      appBar: AppBar(title: const Text('Anime Explorer')),
      body:
          _animeList.isEmpty
              ? const Center(
                child: CircularProgressIndicator(),
              ) // loader while fetching
              : Column(
                children: [
                  Text("Anime Count: ${_animeList.length}"), // ✅ Show count
                  Expanded(
                    child: ListView.builder(
                      itemCount: _animeList.length,
                      itemBuilder: (context, index) {
                        final anime = _animeList[index];
                        return ListTile(
                          title: Text(anime.title),
                          subtitle: Text('Score: ${anime.score}'),
                          leading: Image.network(
                            anime.imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
    );
  }
}
