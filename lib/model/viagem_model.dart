class ViagemModel {
  final String? id;
  final String uid;
  final String data;
  final String sentido; // 'Ida' ou 'Volta'
  final String ponto;
  final String horario;
  final String status; // 'Realizada' ou 'Cancelada'

  ViagemModel({
    this.id,
    required this.uid,
    required this.data,
    required this.sentido,
    required this.ponto,
    required this.horario,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'data': data,
      'sentido': sentido,
      'ponto': ponto,
      'horario': horario,
      'status': status,
    };
  }

  factory ViagemModel.fromMap(String id, Map<String, dynamic> map) {
    return ViagemModel(
      id: id,
      uid: map['uid'] ?? '',
      data: map['data'] ?? '',
      sentido: map['sentido'] ?? 'Ida',
      ponto: map['ponto'] ?? '',
      horario: map['horario'] ?? '',
      status: map['status'] ?? 'Realizada',
    );
  }
}