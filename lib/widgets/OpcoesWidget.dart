import 'package:flutter/material.dart';

class OpcoesWidget extends StatelessWidget {
  final List<String> opcoes;
  final ValueChanged<String> aoSelecionarOpcao;

  const OpcoesWidget({
    Key? key,
    required this.opcoes,
    required this.aoSelecionarOpcao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: opcoes.map((opcao) {
        return GestureDetector(
          onTap: () => aoSelecionarOpcao(opcao),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              opcao,
              style: TextStyle(fontSize: 18),
            ),
          ),
        );
      }).toList(),
    );
  }
}
