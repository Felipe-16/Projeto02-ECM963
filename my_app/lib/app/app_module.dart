import 'package:my_app/app/modules/home/home_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_app/app/modules/landing/landing_page.dart';

import 'modules/landing/landing_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LandingPage()),
  ];

  @override
  final List<ModularRoute> routes = [

    ModuleRoute(
      '/',
      module: LandingModule(),
      guardedRoute: '/home',
    ),

    ModuleRoute(
      '/home',
      module: HomeModule(),
    ),
  ];
}

