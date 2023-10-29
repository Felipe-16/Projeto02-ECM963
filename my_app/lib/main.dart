import 'package:flutter/material.dart';
import 'package:my_app/app/app_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app.module.dart';

void main() => runApp(ModularApp(module: AppModule(), child: AppWidget()));

