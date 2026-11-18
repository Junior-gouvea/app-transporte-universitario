import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/ponto_embarque_model.dart';

class GerenciarPontosController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String get _uid => _auth.currentUser?.uid ?? '';

  // Stream em tempo real filtrada pelo usuário logado (RF003 + RF004)
  Stream<List<PontoEmbarqueModel>> streamPontos() {
    return _firestore
        .collection('pontos_embarque')
        .where('uid', isEqualTo: _uid)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PontoEmbarqueModel.fromMap(doc.id, doc.data()))
            .toList());
  }

  Future<void> adicionarPonto({
    required String nome,
    required String horario,
    String referencia = 'Ponto cadastrado pelo usuário',
  }) async {
    if (_uid.isEmpty) throw 'Usuário não autenticado.';

    // Verifica duplicidade para o mesmo usuário
    final existentes = await _firestore
        .collection('pontos_embarque')
        .where('uid', isEqualTo: _uid)
        .get();

    final jaExiste = existentes.docs.any(
      (d) => (d.data()['nome'] as String).toLowerCase() == nome.toLowerCase(),
    );
    if (jaExiste) {
      throw 'Já existe um ponto com este nome.';
    }

    final ponto = PontoEmbarqueModel(
      uid: _uid,
      nome: nome.trim(),
      horario: horario.trim(),
      referencia: referencia,
      ativo: true,
    );

    await _firestore.collection('pontos_embarque').add(ponto.toMap());
  }

  Future<void> removerPonto(String id) async {
    await _firestore.collection('pontos_embarque').doc(id).delete();
  }
}