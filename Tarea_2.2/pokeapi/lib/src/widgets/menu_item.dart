import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.texto,
    this.icon,
  });

  final String texto;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        texto,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      leading: icon != null ? Icon(icon) : null,
    );
  }
}
