import 'package:flutter/material.dart';

/// Logotipo do aplicativo (imagem em assets/images/logo.png).
/// Se o asset não for encontrado, mostra um ícone de ônibus no lugar.
class LogoApp extends StatelessWidget {
  final double tamanho;

  const LogoApp({super.key, this.tamanho = 110});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/logo.png',
        width: tamanho,
        height: tamanho,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.directions_bus,
          size: tamanho,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
