import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/anime_model.dart';

class AnimeService {
  static Future<List<Anime>> fetchAnime() async {
    try {
      debugPrint("Starting fetchAnime()...");
      // console.log("Starting fetchAnime()...");
      final response = await http.get(
        Uri.parse('https://api.jikan.moe/v4/top/anime'),
      );

      debugPrint("Status Code: ${response.statusCode}");
      log("Response Body: ${response.body}" as num);

      if (response.statusCode == 200) {
        // 👈 Check for status code 200
        final jsonData = json.decode(response.body);
        final List animeJsonList = jsonData['data'];

        List<Anime> animeList =
            animeJsonList.map((json) => Anime.fromJson(json)).toList();

        print("Parsed Anime List: ${animeList.length} items");

        return animeList;
      } else {
        print("Error fetching data: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Exception in fetchAnime: $e");
      return [];
    }
  }
}
