import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../utils/validadores.dart';
import 'sessao_controller.dart';

class RecuperarSenhaController extends ChangeNotifier {
  final SessaoController _sessao = GetIt.I<SessaoController>();

  String? validarEmail(String? valor) => Validadores.email(valor);

  /// Retorna null se o e-mail está cadastrado (instruções "enviadas"),
  /// ou a mensagem de erro. Nesta etapa o envio é simulado.
  String? solicitarRecuperacao(String email) {
    if (!_sessao.emailCadastrado(email)) {
      return 'Nenhuma conta cadastrada com este e-mail.';
    }
    return null;
  }
}
