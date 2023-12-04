import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_app/app/modules/landing/landing_page.dart';
import 'package:my_app/app/modules/series/series_module.dart';
import '../atores/atores_module.dart';
import '../filmes/filmes_module.dart';
import '../home/home_module.dart';


class LandingModule extends Module {
  @override
  final List<Bind> binds = [
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) => LandingPage(),
        children: [
          ModuleRoute('/home', module: HomeModule()), 
          ModuleRoute('/filmes', module: FilmesModule()), 
          ModuleRoute('/atores', module: AtoresModule()), 
          ModuleRoute('/series', module: SeriesModule()), 
        ]),
  ];
}
