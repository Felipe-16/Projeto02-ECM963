import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../shared/Components/app_bar/app_bar_widget.dart';

class FilmesPage extends StatefulWidget {
  @override
  _FilmesPageState createState() => _FilmesPageState();
}

class _FilmesPageState extends State<FilmesPage> {
  List<Map<String, dynamic>> topMovies = [];

  @override
  void initState() {
    super.initState();
    fetchTopMovies();
  }

  Future<void> fetchTopMovies() async {
    final apiKey =
        'b291cbd1c4594544d1906cabdab59e7b'; 
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/trending/movie/week?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      setState(() {
        topMovies = List<Map<String, dynamic>>.from(decodedData['results']);
      });
    } else {
      throw Exception('Failed to load trending movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        icon: Icons.movie,
        titulo: 'Trending Movies',
      ),
      body: ListView.builder(
        itemCount: topMovies.length,
        itemBuilder: (context, index) {
          return _buildMovieCard(topMovies[index]);
        },
      ),
    );
  }

  Widget _buildMovieCard(Map<String, dynamic> movie) {
  return Card(
    margin: EdgeInsets.all(8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(4.0), 
          child: Image.network(
            'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
            width: 120.0, 
            height: 180.0, 
            fit: BoxFit.cover, 
          ),
        ),
        Expanded( 
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: <Widget>[
                Text(
                  movie['title'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0), 
                Text(
                  movie['overview'],
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                  maxLines: 3, 
                  overflow: TextOverflow.ellipsis, 
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}


}
