import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;
  final double? toolbarHeight;
  final IconData? icon;
  final Widget? login;

  const AppBarWidget({
    Key? key,
    required this.titulo,
    this.icon,
    this.login,
    this.toolbarHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          Text(
            titulo,
            style: const TextStyle(fontSize: 36),
          ),
        ],
      ),
      actions: <Widget>[
        Container(
          child: login,
        )
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.shade500,
                Colors.blue.shade900,
              ]),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight);
}