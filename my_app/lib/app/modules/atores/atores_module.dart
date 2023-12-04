import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_app/app/modules/atores/atores_page.dart';

class AtoresModule extends Module {
  @override
  final List<Bind> binds = [
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => AtoresPage(),
    ),
  ];
}
