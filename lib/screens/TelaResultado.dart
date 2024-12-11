import 'package:flutter/material.dart';
import 'package:flutter/animation.dart'; // Importando animações

class TelaResultado extends StatefulWidget {
  final int pontuacao;

  const TelaResultado({required this.pontuacao, super.key});

  @override
  _TelaResultadoState createState() => _TelaResultadoState();
}

class _TelaResultadoState extends State<TelaResultado> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animationScale;
  late Animation<Color?> _animationColor;

  @override
  void initState() {
    super.initState();

    // Inicializando o controlador de animação
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Animação de escala (zoom)
    _animationScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Animação de cor para os textos
    _animationColor = ColorTween(begin: Colors.green.shade300, end: Colors.green.shade700).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Iniciar animação
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade100, Colors.green.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animação do título
              FadeTransition(
                opacity: _animationController,
                child: ScaleTransition(
                  scale: _animationScale,
                  child: Text(
                    'Seu Resultado',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: _animationColor.value,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Exibição da pontuação
              ScaleTransition(
                scale: _animationScale,
                child: FadeTransition(
                  opacity: _animationController,
                  child: Text(
                    'Pontuação: ${widget.pontuacao}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              
              // Botão com animação
              ScaleTransition(
                scale: _animationScale,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                    backgroundColor: Colors.green.shade800,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadowColor: Colors.green.shade600,
                    elevation: 5,
                  ),
                  child: const Text(
                    'Voltar ao início',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
