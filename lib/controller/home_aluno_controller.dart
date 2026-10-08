import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'sessao_controller.dart';

class HomeAlunoController extends ChangeNotifier {
  final SessaoController _sessao = GetIt.I<SessaoController>();

  HomeAlunoController() {
    // Quando o nome mudar (ex.: no Perfil), a Home é atualizada.
    _sessao.addListener(notifyListeners);
  }

  String get nome => _sessao.usuarioLogado?.nome ?? 'Aluno';
  String get email => _sessao.usuarioLogado?.email ?? '';
  String get inicial => nome.isNotEmpty ? nome[0].toUpperCase() : '?';

  void sair() => _sessao.sair();

  @override
  void dispose() {
    _sessao.removeListener(notifyListeners);
    super.dispose();
  }
}
