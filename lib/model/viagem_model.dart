class ViagemModel {
  final String id;
  final String data;
  final String sentido; // 'Ida' ou 'Volta'
  final String ponto;
  final String horario;
  final String status; // 'Realizada' ou 'Cancelada'

  ViagemModel({
    required this.id,
    required this.data,
    required this.sentido,
    required this.ponto,
    required this.horario,
    required this.status,
  });
}
