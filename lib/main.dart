import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'screens/TelaIntroducao.dart'; // Certifique-se de que o caminho está correto

void main() {
  runApp(DevicePreview(
    enabled: true, // Ative o DevicePreview. Pode alterar para `false` em produção.
    builder: (context) => const MeuApp(), // Passe o seu aplicativo aqui.
  ));
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flag Play',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TelaIntroducao(), // Tela de introdução como tela inicial
      builder: DevicePreview.appBuilder,
    );
  }
}
