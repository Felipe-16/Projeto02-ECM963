import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../shared/Components/app_bar/app_bar_widget.dart';

class SeriesPage extends StatefulWidget {
  @override
  _SeriesPageState createState() => _SeriesPageState();
}

class _SeriesPageState extends State<SeriesPage> {
  List<Map<String, dynamic>> topTV = [];

  @override
  void initState() {
    super.initState();
    fetchTopTV();
  }

  Future<void> fetchTopTV() async {
    final apiKey =
        'b291cbd1c4594544d1906cabdab59e7b'; 
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/trending/tv/week?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      setState(() {
        topTV = List<Map<String, dynamic>>.from(decodedData['results']);
      });
    } else {
      throw Exception('Failed to load trending movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        icon: Icons.live_tv,
        titulo: 'Trending TV',
      ),
      body: ListView.builder(
        itemCount: topTV.length,
        itemBuilder: (context, index) {
          return _buildMovieCard(topTV[index]);
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
                  movie['name'] ?? movie['original_name'] ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  movie['overview'] ?? '',
                  style: TextStyle(fontSize: 14.0),
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
