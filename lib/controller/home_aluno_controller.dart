import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/presenca_model.dart';

typedef DadosPerfil = Map<String, String>;
typedef MapaDinamico = Map<String, dynamic>;

class HomeAlunoController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get usuarioAtual => _auth.currentUser;

  Future<DadosPerfil> carregarDadosUsuario() async {
    final user = _auth.currentUser;
    if (user == null) return {'nome': 'Aluno', 'email': ''};

    final doc = await _firestore.collection('usuarios').doc(user.uid).get();
    final dados = doc.data();

    return {
      'nome': dados?['nome'] ?? user.displayName ?? 'Aluno',
      'email': dados?['email'] ?? user.email ?? '',
    };
  }

  Stream<PresencaModel?> streamStatusHoje() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return const Stream.empty();

    return _firestore.collection('presencas').doc(uid).snapshots().map((doc) =>
        doc.exists ? PresencaModel.fromMap(doc.id, doc.data()!) : null);
  }

  Stream<List<MapaDinamico>> streamHistoricoViagens() {
    final uid = _auth.currentUser?.uid ?? '';
    return _firestore
        .collection('viagens')
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.data()).toList());
  }

  Future<void> sair() async {
    await _auth.signOut();
  }
}
