import 'package:flutter/material.dart';
import 'package:my_app/app/modules/atores/atores_page.dart';
import 'package:my_app/app/modules/filmes/filmes_page.dart';
import 'package:my_app/app/modules/home/home_page.dart';
import 'package:my_app/app/modules/series/series_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(), // Substitua cada índice por uma página correspondente
    FilmesPage(),
    SeriesPage(),
    AtoresPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          _buildNavigationBarItem(Icons.search, 'Pesquisar'),
          _buildNavigationBarItem(Icons.movie, 'Filmes'),
          _buildNavigationBarItem(Icons.live_tv, 'Séries'),
          _buildNavigationBarItem(Icons.person, 'Atores'),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  BottomNavigationBarItem _buildNavigationBarItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}

class SearchBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Página de Pesquisa'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Defina o índice ativo do BottomNavigationBar
        type: BottomNavigationBarType.fixed,
        items: [
          _buildNavigationBarItem(Icons.search, 'Pesquisar'),
          _buildNavigationBarItem(Icons.movie, 'Filmes'),
          _buildNavigationBarItem(Icons.live_tv, 'Séries'),
          _buildNavigationBarItem(Icons.person, 'Atores'),
        ],
        onTap: (index) {
          // Implemente a navegação aqui, se necessário
        },
      ),
    );
  }

  BottomNavigationBarItem _buildNavigationBarItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}

