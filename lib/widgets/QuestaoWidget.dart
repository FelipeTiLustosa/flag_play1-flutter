import 'package:flutter/material.dart';

class QuestaoWidget extends StatelessWidget {
  final String caminhoBandeira;

  const QuestaoWidget({Key? key, required this.caminhoBandeira}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Image.asset(
        caminhoBandeira,
        height: 150,
        fit: BoxFit.contain,
      ),
    );
  }
}
