import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/movie.dart';

class MovieProvider extends ChangeNotifier {
  List<Movie> _searchResults = [];

  List<Movie> get searchResults => _searchResults;

  Future<void> searchMovies(String searchTerm) async {
    final response = await http
        .get(Uri.parse('https://api.tvmaze.com/search/shows?q=$searchTerm'));

    if (response.statusCode == 200) {
      final List<dynamic> results = json.decode(response.body);
      _searchResults = results.map((result) {
        var show = result['show'];
        return Movie(
          id: show['id'],
          name: show['name'],
          summary: show['summary'],
          imageUrl: show['image'] == null
              ? "https://static.tvmaze.com/uploads/images/medium_portrait/413/1034988.jpg"
              : show['image']['medium'] ?? show['image']['original'],
          genres: List<String>.from(show['genres']),
          status: show['status'],
          runtime: show['runtime'] ?? 0,
          premiered: show['premiered'] ?? "",
          language: show['language'] ?? "",
          actors: List<String>.from(show['cast'] ?? []),
          officialSite: show['officialSite'] ?? '',
          scheduleTime: show['schedule']['time'] ?? '',
          scheduleDays: List<String>.from(show['schedule']['days'] ?? []),
        );
      }).toList();

      notifyListeners();
    } else {
      // Handle errors
      print('Error: ${response.statusCode}');
    }
  }
}
