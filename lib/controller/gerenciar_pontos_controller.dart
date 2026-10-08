import 'package:flutter/material.dart';
import '../model/ponto_embarque_model.dart';

/// Registrado como singleton no GetIt (veja main.dart): a tela de
/// Gerenciar Pontos e a de Confirmar Presença usam a MESMA lista.
class GerenciarPontosController extends ChangeNotifier {
  final List<PontoEmbarqueModel> _pontos = [
    PontoEmbarqueModel(id: '1', nome: 'Praça Central', horario: '18:10'),
    PontoEmbarqueModel(id: '2', nome: 'Posto de Combustível', horario: '18:20'),
    PontoEmbarqueModel(id: '3', nome: 'Entrada da Cidade', horario: '18:30'),
  ];

  List<PontoEmbarqueModel> get pontos => List.unmodifiable(_pontos);

  /// Retorna null em caso de sucesso, ou a mensagem de erro.
  String? adicionar({required String nome, required String horario}) {
    final nomeLimpo = nome.trim();
    final jaExiste = _pontos.any(
      (p) => p.nome.toLowerCase() == nomeLimpo.toLowerCase(),
    );
    if (jaExiste) return 'Já existe um ponto com este nome.';

    _pontos.add(
      PontoEmbarqueModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        nome: nomeLimpo,
        horario: horario,
      ),
    );
    notifyListeners();
    return null;
  }

  void remover(String id) {
    _pontos.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
