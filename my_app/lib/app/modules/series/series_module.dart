import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_app/app/modules/series/series_page.dart';


class SeriesModule extends Module {
  @override
  final List<Bind> binds = [
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => SeriesPage(),
    ),
  ];
}
