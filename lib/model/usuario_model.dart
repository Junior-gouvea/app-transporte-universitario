class UsuarioModel {
  final String uid;
  final String nome;
  final String email;
  final String telefone;
  final String perfil; // 'aluno' ou 'motorista'
  final DateTime criadoEm;

  UsuarioModel({
    required this.uid,
    required this.nome,
    required this.email,
    required this.telefone,
    this.perfil = 'aluno',
    DateTime? criadoEm,
  }) : criadoEm = criadoEm ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'perfil': perfil,
      'criadoEm': criadoEm.toIso8601String(),
    };
  }

  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel(
      uid: map['uid'] ?? '',
      nome: map['nome'] ?? '',
      email: map['email'] ?? '',
      telefone: map['telefone'] ?? '',
      perfil: map['perfil'] ?? 'aluno',
      criadoEm: DateTime.tryParse(map['criadoEm'] ?? '') ?? DateTime.now(),
    );
  }
}