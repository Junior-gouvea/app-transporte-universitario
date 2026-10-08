import 'package:flutter/material.dart';
import '../model/presenca_model.dart';

enum FiltroSentido { todos, ida, volta }

class ListaMotoristaController extends ChangeNotifier {
  // Dados estáticos (mockados) para demonstrar a listagem
  final List<PresencaModel> _alunos = [
    PresencaModel(alunoId: '1', nomeAluno: 'Ana Souza', vaiNaIda: true, vaiNaVolta: true, pontoEmbarque: 'Praça Central'),
    PresencaModel(alunoId: '2', nomeAluno: 'Bruno Lima', vaiNaIda: true, vaiNaVolta: false, pontoEmbarque: 'Posto de Combustível'),
    PresencaModel(alunoId: '3', nomeAluno: 'Carla Mendes', vaiNaIda: true, vaiNaVolta: true, pontoEmbarque: 'Entrada da Cidade'),
    PresencaModel(alunoId: '4', nomeAluno: 'Diego Rocha', vaiNaIda: false, vaiNaVolta: true, pontoEmbarque: 'Praça Central'),
    PresencaModel(alunoId: '5', nomeAluno: 'Elisa Prado', vaiNaIda: true, vaiNaVolta: true, pontoEmbarque: 'Posto de Combustível'),
    PresencaModel(alunoId: '6', nomeAluno: 'Felipe Castro', vaiNaIda: false, vaiNaVolta: true, pontoEmbarque: 'Entrada da Cidade'),
  ];

  FiltroSentido filtro = FiltroSentido.todos;

  int get totalIda => _alunos.where((a) => a.vaiNaIda).length;
  int get totalVolta => _alunos.where((a) => a.vaiNaVolta).length;

  List<PresencaModel> get alunosFiltrados {
    switch (filtro) {
      case FiltroSentido.ida:
        return _alunos.where((a) => a.vaiNaIda).toList();
      case FiltroSentido.volta:
        return _alunos.where((a) => a.vaiNaVolta).toList();
      case FiltroSentido.todos:
        return List.unmodifiable(_alunos);
    }
  }

  void alterarFiltro(FiltroSentido novo) {
    filtro = novo;
    notifyListeners();
  }
}
