import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/app/modules/atores/page/atores_detail_page.dart';

import '../../../shared/Components/app_bar/app_bar_widget.dart';

class AtoresPage extends StatefulWidget {
  @override
  _AtoresPageState createState() => _AtoresPageState();
}

class _AtoresPageState extends State<AtoresPage> {
  List<Map<String, dynamic>> topActors = [];

  @override
  void initState() {
    super.initState();
    fetchTopActors();
  }

  Future<void> fetchTopActors() async {
    final apiKey =
        'b291cbd1c4594544d1906cabdab59e7b'; 
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/trending/person/week?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      setState(() {
        topActors = List<Map<String, dynamic>>.from(decodedData['results']);
      });
    } else {
      throw Exception('Failed to load trending actors');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(
          icon: Icons.person,
          titulo: 'Trending Actors',
        ),
        body: ListView.builder(
          itemCount: topActors.length,
          itemBuilder: (context, index) {
            return _buildActorCard(context, topActors[index]);
          },
        ));
  }

  Widget _buildActorCard(BuildContext context, Map<String, dynamic> actor) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AtoresDetailsPage(actorDetails: actor),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(8.0),
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: ListTile(
            leading: actor['profile_path'] != null
                ? Image.network(
                    'https://image.tmdb.org/t/p/w200${actor['profile_path']}',
                    height: double.infinity,
                    fit: BoxFit.fill,
                  )
                : SizedBox(), 
            title: Text(
              actor['name'] ?? '',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(actor['known_for_department'] ?? ''),
          ),
        ),
      ),
    );
  }
}
