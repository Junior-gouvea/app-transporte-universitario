import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../utils/validadores.dart';
import 'sessao_controller.dart';

class PerfilCotroller extends ChangeNotifier {
  final SessaoController _sessao = GetIt.I<SessaoController>();

  PerfilCotroller() {
    _sessao.addListener(notifyListeners);
  }

  bool get autenticado => _sessao.autenticado;
  String get nome => _sessao.usuarioLogado?.nome ?? '';
  String get email => _sessao.usuarioLogado?.email ?? '';
  String get inicial => nome.isNotEmpty ? nome[0].toUpperCase() : '?';

  String? validarNome(String? valor) => Validadores.nome(valor, minimo: 3);

  void salvarNome(String novoNome) => _sessao.atualizarNome(novoNome);

  @override
  void dispose() {
    _sessao.removeListener(notifyListeners);
    super.dispose();
  }
}
