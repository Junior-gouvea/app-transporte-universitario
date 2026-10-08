import 'package:flutter/material.dart';

class SobreController extends ChangeNotifier {
  final String nomeApp = 'Transporte Universitário';
  final String versao = '1.0.0';

  final String objetivo =
      'Facilitar a organização do transporte de alunos universitários: o aluno '
      'confirma sua presença na ida e na volta e escolhe o ponto de embarque, '
      'enquanto o motorista consulta a lista de passageiros e gerencia os '
      'pontos de embarque.';

  
  final List<String> integrantes = const [
    'Júnior Candido Gouvêa',
    'João Gabriel Meloni Coutinho',
  ];

  
  final String disciplina = 'Programação a Dispositivos Moveis';
  final String instituicao = 'FATEC Ribeirão Preto';
  final String professor = 'Rodrigo Plotze';
}
