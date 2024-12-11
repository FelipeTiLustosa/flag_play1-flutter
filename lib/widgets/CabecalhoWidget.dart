import 'package:flutter/material.dart';

class CabecalhoWidget extends StatelessWidget {
  final String titulo;

  const CabecalhoWidget({Key? key, required this.titulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titulo),
      centerTitle: true,
      backgroundColor: Colors.blueAccent,
    );
  }
}
