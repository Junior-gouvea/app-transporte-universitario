class PresencaModel {
  final String alunoId;
  final String nomeAluno;
  bool vaiNaIda;
  bool vaiNaVolta;
  String pontoEmbarque;

  PresencaModel({
    required this.alunoId,
    required this.nomeAluno,
    this.vaiNaIda = false,
    this.vaiNaVolta = false,
    required this.pontoEmbarque,
  });
}