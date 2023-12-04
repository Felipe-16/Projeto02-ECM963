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
    child: Padding(
      padding: EdgeInsets.all(12.0),
      child: ListTile(
        leading: Image.network(
          'https://image.tmdb.org/t/p/w200${movie['poster_path']}',
          height: double.infinity, 
          fit: BoxFit.fill,
        ),
        title: Text(
          movie['name'] ?? movie['original_name'] ?? '', 
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(movie['overview'] ?? ''),
      ),
    ),
  );
}}
