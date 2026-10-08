import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../utils/validadores.dart';
import 'sessao_controller.dart';

class CadastroUsuarioController extends ChangeNotifier {
  final SessaoController _sessao = GetIt.I<SessaoController>();

  bool ocultarSenha = true;
  bool ocultarConfirmacao = true;

  void alternarSenha() {
    ocultarSenha = !ocultarSenha;
    notifyListeners();
  }

  void alternarConfirmacao() {
    ocultarConfirmacao = !ocultarConfirmacao;
    notifyListeners();
  }

  String? validarNome(String? valor) => Validadores.nome(valor);
  String? validarEmail(String? valor) => Validadores.email(valor);
  String? validarTelefone(String? valor) => Validadores.telefone(valor);
  String? validarSenha(String? valor) => Validadores.senha(valor);
  String? validarConfirmacao(String? valor, String senha) =>
      Validadores.confirmacaoSenha(valor, senha);

  /// Retorna null se cadastrou (e já entrou no app), ou a mensagem de erro.
  String? cadastrar({
    required String nome,
    required String email,
    required String telefone,
    required String senha,
  }) {
    return _sessao.cadastrar(
      nome: nome,
      email: email,
      telefone: telefone,
      senha: senha,
    );
  }
}
