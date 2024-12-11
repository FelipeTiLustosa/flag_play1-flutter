import 'package:flutter/material.dart';
import 'dart:async';

class TemporizadorWidget extends StatefulWidget {
  final int limiteTempo;
  final Function aoAcabarTempo;

  const TemporizadorWidget({required this.limiteTempo, required this.aoAcabarTempo, super.key});

  @override
  _TemporizadorWidgetState createState() => _TemporizadorWidgetState();
}

class _TemporizadorWidgetState extends State<TemporizadorWidget> {
  late int _tempoRestante;
  late Timer _temporizador;

  @override
  void initState() {
    super.initState();
    _tempoRestante = widget.limiteTempo;
    _iniciarTemporizador();
  }

  // Função para iniciar o contador regressivo
  void _iniciarTemporizador() {
    _temporizador = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_tempoRestante > 0) {
        setState(() {
          _tempoRestante--;
        });
      } else {
        widget.aoAcabarTempo(); // Chama a função passada quando o tempo acabar
        _temporizador.cancel(); // Para o temporizador
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'Tempo restante: $_tempoRestante segundos',
      style: const TextStyle(fontSize: 20),
    );
  }

  @override
  void dispose() {
    _temporizador.cancel(); // Certifique-se de cancelar o temporizador ao sair da tela
    super.dispose();
  }
}
