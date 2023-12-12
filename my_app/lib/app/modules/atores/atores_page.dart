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
    final apiKey = 'b291cbd1c4594544d1906cabdab59e7b';
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/trending/person/week?api_key=$apiKey'),
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

  Future<Map<String, dynamic>> fetchActorDetails(int actorId) async {
    final apiKey = 'b291cbd1c4594544d1906cabdab59e7b';
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/person/$actorId?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load actor details');
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
      ),
    );
  }

  Widget _buildActorCard(BuildContext context, Map<String, dynamic> actor) {
    return GestureDetector(
      onTap: () async {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Center(child: CircularProgressIndicator());
          },
        );
        final actorDetails = await fetchActorDetails(actor['id']);
        Navigator.pop(context); // Fecha o indicador de carregamento
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AtoresDetailsPage(actorDetails: actorDetails),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            actor['profile_path'] != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${actor['profile_path']}',
                      width: 120.0,
                      height: 180.0,
                      fit: BoxFit.cover,
                    ),
                  )
                : SizedBox(width: 120.0, height: 180.0),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      actor['name'] ?? '',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      actor['known_for_department'] ?? '',
                      style: TextStyle(fontSize: 14.0),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
