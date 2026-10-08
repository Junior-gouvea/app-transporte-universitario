import 'package:flutter/material.dart';
import '../model/usuario_model.dart';

/// Guarda o usuário logado e a lista (mockada) de usuários cadastrados.
/// É registrado como singleton no GetIt (veja main.dart), então todas as
/// telas enxergam o mesmo usuário e são avisadas quando ele muda.
class SessaoController extends ChangeNotifier {
  final List<UsuarioModel> _usuarios = [
    // Usuário de teste para a demonstração
    UsuarioModel(
      nome: 'Aluno Teste',
      email: 'aluno@teste.com',
      telefone: '(16) 99999-9999',
      senha: '123456',
    ),
  ];

  UsuarioModel? _usuarioLogado;

  UsuarioModel? get usuarioLogado => _usuarioLogado;
  bool get autenticado => _usuarioLogado != null;

  bool emailCadastrado(String email) {
    final alvo = email.trim().toLowerCase();
    return _usuarios.any((u) => u.email == alvo);
  }

  /// Retorna null em caso de sucesso, ou a mensagem de erro.
  String? entrar(String email, String senha) {
    final alvo = email.trim().toLowerCase();
    for (final u in _usuarios) {
      if (u.email == alvo && u.senha == senha) {
        _usuarioLogado = u;
        notifyListeners();
        return null;
      }
    }
    return 'E-mail ou senha incorretos.';
  }

  /// Retorna null em caso de sucesso, ou a mensagem de erro.
  String? cadastrar({
    required String nome,
    required String email,
    required String telefone,
    required String senha,
  }) {
    if (emailCadastrado(email)) {
      return 'Já existe uma conta cadastrada com este e-mail.';
    }
    final novo = UsuarioModel(
      nome: nome.trim(),
      email: email.trim().toLowerCase(),
      telefone: telefone.trim(),
      senha: senha,
    );
    _usuarios.add(novo);
    _usuarioLogado = novo; // após o cadastro o usuário já entra no app
    notifyListeners();
    return null;
  }

  void atualizarNome(String novoNome) {
    final usuario = _usuarioLogado;
    if (usuario == null) return;
    usuario.nome = novoNome.trim();
    notifyListeners();
  }

  void sair() {
    _usuarioLogado = null;
    notifyListeners();
  }
}
