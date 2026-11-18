import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

typedef DadosUsuario = Map<String, String>;

class LoginController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DadosUsuario> login({
    required String email,
    required String senha,
  }) async {
    try {
      final credencial = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: senha,
      );

      final uid = credencial.user!.uid;
      final doc = await _firestore.collection('usuarios').doc(uid).get();
      final dados = doc.data();

      return {
        'uid': uid,
        'nome': dados?['nome'] ?? credencial.user?.displayName ?? 'Aluno',
        'email': dados?['email'] ?? email.trim(),
      };
    } on FirebaseAuthException catch (e) {
      throw _traduzirErroAuth(e.code);
    } catch (_) {
      throw 'Erro inesperado ao realizar login. Tente novamente.';
    }
  }

  String _traduzirErroAuth(String code) {
    switch (code) {
      case 'user-not-found':
      case 'invalid-credential':
        return 'E-mail ou senha inválidos.';
      case 'wrong-password':
        return 'Senha incorreta.';
      case 'invalid-email':
        return 'Formato de e-mail inválido.';
      case 'user-disabled':
        return 'Esta conta foi desativada.';
      case 'too-many-requests':
        return 'Muitas tentativas. Aguarde alguns instantes.';
      default:
        return 'Falha na autenticação ($code).';
    }
  }
}
