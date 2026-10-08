import 'package:flutter/material.dart';
import '../model/viagem_model.dart';

class HistoricoViagensController extends ChangeNotifier {
  // Dados estáticos (mockados) para demonstrar a listagem
  final List<ViagemModel> _viagens = [
    ViagemModel(id: '1', data: '06/10/2026', sentido: 'Volta', ponto: 'Praça Central', horario: '22:30', status: 'Realizada'),
    ViagemModel(id: '2', data: '06/10/2026', sentido: 'Ida', ponto: 'Praça Central', horario: '18:10', status: 'Realizada'),
    ViagemModel(id: '3', data: '05/10/2026', sentido: 'Volta', ponto: 'Praça Central', horario: '22:30', status: 'Cancelada'),
    ViagemModel(id: '4', data: '05/10/2026', sentido: 'Ida', ponto: 'Posto de Combustível', horario: '18:20', status: 'Realizada'),
    ViagemModel(id: '5', data: '02/10/2026', sentido: 'Volta', ponto: 'Praça Central', horario: '22:30', status: 'Realizada'),
    ViagemModel(id: '6', data: '02/10/2026', sentido: 'Ida', ponto: 'Praça Central', horario: '18:10', status: 'Realizada'),
  ];

  List<ViagemModel> get viagens => List.unmodifiable(_viagens);

  int get totalRealizadas =>
      _viagens.where((v) => v.status == 'Realizada').length;
  int get totalCanceladas =>
      _viagens.where((v) => v.status == 'Cancelada').length;
}
