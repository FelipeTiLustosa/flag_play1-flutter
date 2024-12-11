import 'package:flutter/material.dart';
import 'TelaResultado.dart';
import '../data/questions_data.dart'; // Certifique-se de que o caminho está correto
import '../widgets/TemporizadorWidget.dart'; // Certifique-se de que o caminho está correto

class TelaQuiz extends StatefulWidget {
  final int limiteTempo;

  const TelaQuiz({required this.limiteTempo, super.key});

  @override
  _TelaQuizState createState() => _TelaQuizState();
}

class _TelaQuizState extends State<TelaQuiz> {
  int indicePerguntaAtual = 0;
  int pontuacao = 0;
  String respostaSelecionada = '';
  late int tempoRestante;
  bool tempoEsgotado = false;

  @override
  void initState() {
    super.initState();
    tempoRestante = widget.limiteTempo;
  }

  void _tempoEsgotado() {
    setState(() {
      tempoEsgotado = true;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TelaResultado(pontuacao: pontuacao),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pergunta = perguntas[indicePerguntaAtual];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quiz de Bandeiras',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade700,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.orange.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TemporizadorWidget(
              limiteTempo: widget.limiteTempo,
              aoAcabarTempo: _tempoEsgotado,
            ),
            const SizedBox(height: 20),
            Text(
              'Questão ${indicePerguntaAtual + 1} de ${perguntas.length}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    pergunta['flag'],
                    height: 150,
                  ),
                  const SizedBox(height: 20),
                  // Exibindo as opções de resposta com Radio Buttons
                  ...pergunta['options'].map((opcao) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: RadioListTile<String>(
                        value: opcao,
                        groupValue: respostaSelecionada,
                        onChanged: tempoEsgotado
                            ? null
                            : (String? value) {
                                setState(() {
                                  respostaSelecionada = value!;
                                });
                              },
                        title: Text(
                          opcao,
                          style: const TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        activeColor: Colors.blue.shade700,
                        tileColor: Colors.orange.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        selectedTileColor: Colors.orange.shade300,
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: tempoEsgotado
                  ? null
                  : () {
                      if (respostaSelecionada == pergunta['correctAnswer']) {
                        pontuacao++;
                      }
                      if (indicePerguntaAtual + 1 < perguntas.length) {
                        setState(() {
                          indicePerguntaAtual++;
                          respostaSelecionada = '';
                        });
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TelaResultado(pontuacao: pontuacao),
                          ),
                        );
                      }
                    },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                backgroundColor: Colors.orange.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Responder',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
