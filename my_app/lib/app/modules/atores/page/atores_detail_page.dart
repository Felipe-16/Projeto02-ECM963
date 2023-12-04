import 'package:flutter/material.dart';

class AtoresDetailsPage extends StatelessWidget {
  final Map<String, dynamic> actorDetails;

  const AtoresDetailsPage({Key? key, required this.actorDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(actorDetails['name']),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              'https://image.tmdb.org/t/p/w500${actorDetails['profile_path']}',
              fit: BoxFit.cover,
              height: 300,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Biografia:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(actorDetails['biography']),
                  // Adicione outros detalhes que deseja exibir
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
