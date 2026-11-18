import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/presenca_model.dart';
import '../model/viagem_model.dart';

class ConfirmarPresencaController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool vaiNaIda = true;
  bool vaiNaVolta = true;
  String pontoEmbarque = 'Praça Central';
  bool salvando = false;

  void alternarIda(bool valor) {
    vaiNaIda = valor;
    notifyListeners();
  }

  void alternarVolta(bool valor) {
    vaiNaVolta = valor;
    notifyListeners();
  }

  void alterarPonto(String novoPonto) {
    pontoEmbarque = novoPonto;
    notifyListeners();
  }

  Future<void> carregarPresencaAtual() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final doc = await _firestore.collection('presencas').doc(user.uid).get();
    if (doc.exists && doc.data() != null) {
      final dados = doc.data()!;
      vaiNaIda = dados['vaiNaIda'] ?? true;
      vaiNaVolta = dados['vaiNaVolta'] ?? true;
      pontoEmbarque = dados['pontoEmbarque'] ?? 'Praça Central';
      notifyListeners();
    }
  }

  Future<void> salvarPresenca() async {
    final user = _auth.currentUser;
    if (user == null) throw 'Usuário não autenticado.';

    salvando = true;
    notifyListeners();

    try {
      final userDoc = await _firestore.collection('usuarios').doc(user.uid).get();
      final nomeAluno =
          userDoc.data()?['nome'] ?? user.displayName ?? user.email ?? 'Aluno';

      final presenca = PresencaModel(
        id: user.uid,
        alunoId: user.uid,
        nomeAluno: nomeAluno,
        vaiNaIda: vaiNaIda,
        vaiNaVolta: vaiNaVolta,
        pontoEmbarque: pontoEmbarque,
      );

      // Salva na coleção 'presencas' (RF003)
      await _firestore
          .collection('presencas')
          .doc(user.uid)
          .set(presenca.toMap());

      // Registra também no histórico da coleção 'viagens' do usuário
      final viagem = ViagemModel(
        uid: user.uid,
        data: presenca.data,
        sentido: vaiNaIda ? 'Ida' : 'Volta',
        ponto: pontoEmbarque,
        horario: vaiNaIda ? '18:10' : '22:30',
        status: (vaiNaIda || vaiNaVolta) ? 'Realizada' : 'Cancelada',
      );
      await _firestore.collection('viagens').add(viagem.toMap());
    } finally {
      salvando = false;
      notifyListeners();
    }
  }
}