import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'gerenciar_pontos_controller.dart';

class ConfirmarPresencaController extends ChangeNotifier {
  final GerenciarPontosController _pontos = GetIt.I<GerenciarPontosController>();

  bool vaiNaIda = true;
  bool vaiNaVolta = true;
  String? pontoEmbarque;

  ConfirmarPresencaController() {
    // Escolhe o primeiro ponto cadastrado e acompanha mudanças na lista
    pontoEmbarque = nomesPontos.isEmpty ? null : nomesPontos.first;
    _pontos.addListener(_aoMudarPontos);
  }

  /// Nomes dos pontos cadastrados em Gerenciar Pontos
  List<String> get nomesPontos => _pontos.pontos.map((p) => p.nome).toList();

  void _aoMudarPontos() {
    // Se o ponto escolhido foi removido, seleciona outro
    if (!nomesPontos.contains(pontoEmbarque)) {
      pontoEmbarque = nomesPontos.isEmpty ? null : nomesPontos.first;
    }
    notifyListeners();
  }

  void alternarIda(bool valor) {
    vaiNaIda = valor;
    notifyListeners(); // Avisa a View para atualizar a tela
  }

  void alternarVolta(bool valor) {
    vaiNaVolta = valor;
    notifyListeners();
  }

  void alterarPonto(String novoPonto) {
    pontoEmbarque = novoPonto;
    notifyListeners();
  }

  @override
  void dispose() {
    _pontos.removeListener(_aoMudarPontos); // evita vazamento de listener
    super.dispose();
  }
}
