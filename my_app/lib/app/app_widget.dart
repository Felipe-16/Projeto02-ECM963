import 'package:flutter/material.dart';
import 'package:flutter_modular/src/presenters/modular_base.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      title: 'Movies FMG',
      theme: ThemeData(
        fontFamily: 'Roboto',
        appBarTheme: AppBarTheme(
          color: Colors.blue,
          centerTitle: true,
        ),
      ),
    ).modular();
  }
}
