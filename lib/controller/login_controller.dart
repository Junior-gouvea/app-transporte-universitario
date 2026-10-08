import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../utils/validadores.dart';
import 'sessao_controller.dart';

class LoginController extends ChangeNotifier {
  final SessaoController _sessao = GetIt.I<SessaoController>();

  bool ocultarSenha = true;

  void alternarSenha() {
    ocultarSenha = !ocultarSenha;
    notifyListeners();
  }

  String? validarEmail(String? valor) => Validadores.email(valor);

  String? validarSenha(String? valor) =>
      Validadores.obrigatorio(valor, 'Informe a senha');

  /// Retorna null se autenticou, ou a mensagem de erro.
  String? entrar(String email, String senha) => _sessao.entrar(email, senha);
}
