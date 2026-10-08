import 'package:flutter/material.dart';

class ConfirmarPresencaController extends ChangeNotifier {
  bool vaiNaIda = true;
  bool vaiNaVolta = true;
  String pontoEmbarque = 'Praça Central';

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
}