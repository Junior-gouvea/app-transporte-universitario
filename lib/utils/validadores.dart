/// Validações reutilizadas pelas telas (login, cadastro, recuperar senha, perfil).
class Validadores {
  static final RegExp _emailRegex = RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$');

  static bool emailValido(String email) => _emailRegex.hasMatch(email.trim());

  static String? obrigatorio(String? valor, String mensagem) {
    if (valor == null || valor.trim().isEmpty) return mensagem;
    return null;
  }

  static String? email(String? valor) {
    final vazio = obrigatorio(valor, 'Informe o e-mail');
    if (vazio != null) return vazio;
    if (!emailValido(valor!)) {
      return 'Informe um e-mail válido (ex.: nome@dominio.com)';
    }
    return null;
  }

  static String? nome(String? valor, {int minimo = 3}) {
    final vazio = obrigatorio(valor, 'Informe o nome');
    if (vazio != null) return vazio;
    if (valor!.trim().length < minimo) {
      return 'O nome deve ter ao menos $minimo caracteres';
    }
    return null;
  }

  static String? telefone(String? valor) {
    final vazio = obrigatorio(valor, 'Informe o telefone');
    if (vazio != null) return vazio;
    final digitos = valor!.replaceAll(RegExp(r'\D'), '');
    if (digitos.length < 10 || digitos.length > 11) {
      return 'Informe um telefone válido com DDD';
    }
    return null;
  }

  static String? senha(String? valor, {int minimo = 6}) {
    final vazio = obrigatorio(valor, 'Informe a senha');
    if (vazio != null) return vazio;
    if (valor!.length < minimo) {
      return 'A senha deve ter ao menos $minimo caracteres';
    }
    return null;
  }

  static String? confirmacaoSenha(String? valor, String senha) {
    final vazio = obrigatorio(valor, 'Confirme a senha');
    if (vazio != null) return vazio;
    if (valor != senha) return 'As senhas não coincidem';
    return null;
  }

  static String? horario(String? valor) {
    final vazio = obrigatorio(valor, 'Informe o horário');
    if (vazio != null) return vazio;
    if (!RegExp(r'^([01]\d|2[0-3]):[0-5]\d$').hasMatch(valor!.trim())) {
      return 'Use o formato HH:mm (ex.: 18:10)';
    }
    return null;
  }
}
