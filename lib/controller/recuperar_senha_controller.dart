import 'package:firebase_auth/firebase_auth.dart';

class RecuperarSenhaController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> enviarEmailRecuperacao(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        throw 'O formato do e-mail informado é inválido.';
      }
      throw 'Não foi possível enviar o e-mail de recuperação.';
    } catch (_) {
      throw 'Erro ao solicitar redefinição de senha.';
    }
  }
}