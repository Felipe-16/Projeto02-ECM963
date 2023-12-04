import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_app/app/modules/atores/page/atores_detail_page.dart';

class AtoresDeitailsModule extends Module {
  @override
  final List<Bind> binds = [
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => AtoresDetailsPage(actorDetails: {},),
    ),
  ];
}
