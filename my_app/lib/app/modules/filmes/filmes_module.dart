import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_app/app/modules/filmes/filmes_page.dart';

class FilmesModule extends Module {
  @override
  final List<Bind> binds = [
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => FilmesPage(),
    ),
  ];
}
