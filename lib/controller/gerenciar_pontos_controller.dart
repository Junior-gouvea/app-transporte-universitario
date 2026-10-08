import 'package:flutter/material.dart';
import '../model/ponto_embarque_model.dart';

class GerenciarPontosController extends ChangeNotifier {
  final List<PontoEmbarqueModel> _pontos = [
    PontoEmbarqueModel(id: '1', nome: 'Praça Central', horario: '18:10'),
    PontoEmbarqueModel(id: '2', nome: 'Posto de Combustível', horario: '18:20'),
    PontoEmbarqueModel(id: '3', nome: 'Entrada da Cidade', horario: '18:30'),
  ];

  List<PontoEmbarqueModel> get pontos => List.unmodifiable(_pontos);

  void adicionar({required String nome, required String horario}) {
    _pontos.add(
      PontoEmbarqueModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        nome: nome,
        horario: horario,
      ),
    );
    notifyListeners();
  }

  void remover(String id) {
    _pontos.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
