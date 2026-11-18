import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/usuario_model.dart';
import '../model/viagem_model.dart';

class CadastroUsuarioController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UsuarioModel> cadastrar({
    required String nome,
    required String email,
    required String telefone,
    required String senha,
  }) async {
    try {
      // 1. Cria usuário no Firebase Authentication
      final credencial = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: senha,
      );

      final uid = credencial.user!.uid;
      await credencial.user!.updateDisplayName(nome.trim());

      // 2. Grava dados adicionais na coleção 'usuarios' (RF002)
      final usuario = UsuarioModel(
        uid: uid,
        nome: nome.trim(),
        email: email.trim(),
        telefone: telefone.trim(),
      );

      await _firestore.collection('usuarios').doc(uid).set(usuario.toMap());

      // 3. Cria registro inicial de boas-vindas no histórico do usuário
      final viagemInicial = ViagemModel(
        uid: uid,
        data: _hojeFormatado(),
        sentido: 'Ida',
        ponto: 'Praça Central',
        horario: '18:10',
        status: 'Realizada',
      );
      await _firestore.collection('viagens').add(viagemInicial.toMap());

      return usuario;
    } on FirebaseAuthException catch (e) {
      throw _traduzirErro(e.code);
    } catch (_) {
      throw 'Erro ao criar conta. Verifique sua conexão e tente novamente.';
    }
  }

  String _hojeFormatado() {
    final agora = DateTime.now();
    return '${agora.day.toString().padLeft(2, '0')}/'
        '${agora.month.toString().padLeft(2, '0')}/${agora.year}';
  }

  String _traduzirErro(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'Este e-mail já está cadastrado.';
      case 'weak-password':
        return 'A senha é muito fraca (mínimo 6 caracteres).';
      case 'invalid-email':
        return 'E-mail inválido.';
      default:
        return 'Não foi possível cadastrar ($code).';
    }
  }
}