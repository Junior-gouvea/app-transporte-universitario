class PresencaModel {
  final String? id;
  final String alunoId;
  final String nomeAluno;
  bool vaiNaIda;
  bool vaiNaVolta;
  String pontoEmbarque;
  final String data;

  PresencaModel({
    this.id,
    required this.alunoId,
    required this.nomeAluno,
    this.vaiNaIda = false,
    this.vaiNaVolta = false,
    required this.pontoEmbarque,
    String? data,
  }) : data = data ?? _hojeFormatado();

  static String _hojeFormatado() {
    final agora = DateTime.now();
    final d = agora.day.toString().padLeft(2, '0');
    final m = agora.month.toString().padLeft(2, '0');
    return '$d/$m/${agora.year}';
  }

  Map<String, dynamic> toMap() {
    return {
      'alunoId': alunoId,
      'nomeAluno': nomeAluno,
      'vaiNaIda': vaiNaIda,
      'vaiNaVolta': vaiNaVolta,
      'pontoEmbarque': pontoEmbarque,
      'data': data,
    };
  }

  factory PresencaModel.fromMap(String id, Map<String, dynamic> map) {
    return PresencaModel(
      id: id,
      alunoId: map['alunoId'] ?? '',
      nomeAluno: map['nomeAluno'] ?? '',
      vaiNaIda: map['vaiNaIda'] ?? false,
      vaiNaVolta: map['vaiNaVolta'] ?? false,
      pontoEmbarque: map['pontoEmbarque'] ?? 'Praça Central',
      data: map['data'] ?? _hojeFormatado(),
    );
  }
}