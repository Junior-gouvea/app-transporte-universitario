import 'package:flutter/material.dart';
import '../widgets/logo_app.dart';

class SobreView extends StatefulWidget {
  const SobreView({super.key});

  @override
  State<SobreView> createState() => _SobreViewState();
}

class _SobreViewState extends State<SobreView> {
  static const String _nomeApp = 'Transporte Universitário';
  static const String _versao = '1.0.0';
  static const String _objetivo =
      'Facilitar a organização do transporte de alunos universitários: o aluno '
      'confirma sua presença na ida e na volta e escolhe o ponto de embarque, '
      'enquanto o motorista consulta a lista de passageiros e gerencia os '
      'pontos de embarque.';

  
  static const List<String> _integrantes = [
    'Júnior Candido Gouvêa',
    'João Gabriel Meloni Coutinho',
  ];

  static const String _disciplina = 'Programação a Dispositivos Movéis';
  static const String _instituicao = 'FATEC Ribeirão Preto';
  static const String _professor = 'Rodrigo Plotze';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sobre')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const LogoApp(tamanho: 96),
            const SizedBox(height: 12),
            Text(
              _nomeApp,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Text(
              'Versão $_versao',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Objetivo do aplicativo',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(_objetivo),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Equipe de desenvolvimento',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    for (final nome in _integrantes)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.person),
                        title: Text(nome),
                      ),
                  ],
                ),
              ),
            ),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Informações acadêmicas',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.menu_book),
                      title: Text('Disciplina'),
                      subtitle: Text(_disciplina),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.school),
                      title: Text('Instituição'),
                      subtitle: Text(_instituicao),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.badge),
                      title: Text('Professor'),
                      subtitle: Text(_professor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
