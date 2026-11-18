import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PerfilController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> atualizarNome(String novoNome) async {
    final user = _auth.currentUser;
    if (user == null) throw 'Usuário não autenticado.';

    final nomeLimpo = novoNome.trim();
    await user.updateDisplayName(nomeLimpo);
    await _firestore.collection('usuarios').doc(user.uid).update({
      'nome': nomeLimpo,
    });
  }
}