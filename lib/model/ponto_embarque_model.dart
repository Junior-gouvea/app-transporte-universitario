class PontoEmbarqueModel {
  final String? id;
  final String uid; // Separação por usuário logado (RF003)
  final String nome;
  final String horario;
  final String referencia;
  final bool ativo;

  PontoEmbarqueModel({
    this.id,
    required this.uid,
    required this.nome,
    required this.horario,
    this.referencia = 'Ponto padrão',
    this.ativo = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'nome': nome,
      'horario': horario,
      'referencia': referencia,
      'ativo': ativo,
    };
  }

  factory PontoEmbarqueModel.fromMap(String id, Map<String, dynamic> map) {
    return PontoEmbarqueModel(
      id: id,
      uid: map['uid'] ?? '',
      nome: map['nome'] ?? '',
      horario: map['horario'] ?? '',
      referencia: map['referencia'] ?? 'Ponto padrão',
      ativo: map['ativo'] ?? true,
    );
  }
}