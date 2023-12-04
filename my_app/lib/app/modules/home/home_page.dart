import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  String _selectedFilter = '';

  Future<void> _searchTMDb(String searchTerm) async {
    final apiKey =
        'b291cbd1c4594544d1906cabdab59e7b'; 

    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/search/multi?api_key=$apiKey&query=$searchTerm'),
    );

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      setState(() {
        _searchResults =
            List<Map<String, dynamic>>.from(decodedData['results']);
      });
    } else {
      throw Exception('Failed to load search results');
    }
  }

  Widget _buildFilterButton(String filterName) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = filterName == _selectedFilter ? '' : filterName;
          _searchTMDb(_searchController.text);
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: _selectedFilter == filterName ? Colors.blue : Colors.grey[300],
        ),
        child: Text(
          filterName,
          style: TextStyle(
            color: _selectedFilter == filterName ? Colors.white : Colors.black,
            fontWeight: _selectedFilter == filterName
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButtonAll() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = '';
          _searchTMDb(_searchController.text);
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: _selectedFilter.isEmpty ? Colors.blue : Colors.grey[300],
        ),
        child: Text(
          'Todos',
          style: TextStyle(
            color: _selectedFilter.isEmpty ? Colors.white : Colors.black,
            fontWeight:
                _selectedFilter.isEmpty ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (value) {
                _searchTMDb(value);
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFilterButtonAll(),
                _buildFilterButton('Filme'),
                _buildFilterButton('Série'),
                _buildFilterButton('Pessoa'),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final result = _searchResults[index];
                  if (_selectedFilter.isNotEmpty &&
                      _selectedFilter != result['media_type']) {
                    return SizedBox();
                  }
                  return _buildListItem(
                    result['media_type'],
                    result['name'] ?? result['title'],
                    result['poster_path'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(String? type, String? name, String? posterPath) {
    final mediaType = _mapMediaType(type);
    if (_selectedFilter.isNotEmpty && mediaType != _selectedFilter) {
      return SizedBox();
    }

    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: posterPath != null
                ? NetworkImage('https://image.tmdb.org/t/p/w200$posterPath')
                : AssetImage('assets/placeholder_image.png') as ImageProvider,
          ),
        ),
      ),
      title: Text(name ?? ''),
      subtitle: Text(mediaType ?? ''),
      onTap: () {
        // Ação ao clicar no item da lista
      },
    );
  }

  String? _mapMediaType(String? type) {
    switch (type) {
      case 'movie':
        return 'Filme';
      case 'tv':
        return 'Série';
      case 'person':
        return 'Pessoa';
      default:
        return null;
    }
  }
}
