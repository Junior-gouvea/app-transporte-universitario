import 'package:flutter/material.dart';

class _Viagem {
  final String data;
  final String sentido; // 'Ida' ou 'Volta'
  final String ponto;
  final String horario;
  final String status; // 'Realizada' ou 'Cancelada'

  const _Viagem(this.data, this.sentido, this.ponto, this.horario, this.status);
}

class HistoricoViagensView extends StatefulWidget {
  const HistoricoViagensView({super.key});

  @override
  State<HistoricoViagensView> createState() => _HistoricoViagensViewState();
}

class _HistoricoViagensViewState extends State<HistoricoViagensView> {
  // Dados estáticos (mockados) para demonstrar a listagem
  static const List<_Viagem> _viagens = [
    _Viagem('06/10/2026', 'Volta', 'Praça Central', '22:30', 'Realizada'),
    _Viagem('06/10/2026', 'Ida', 'Praça Central', '18:10', 'Realizada'),
    _Viagem('05/10/2026', 'Volta', 'Praça Central', '22:30', 'Cancelada'),
    _Viagem('05/10/2026', 'Ida', 'Posto de Combustível', '18:20', 'Realizada'),
    _Viagem('02/10/2026', 'Volta', 'Praça Central', '22:30', 'Realizada'),
    _Viagem('02/10/2026', 'Ida', 'Praça Central', '18:10', 'Realizada'),
  ];

  @override
  Widget build(BuildContext context) {
    final realizadas = _viagens.where((v) => v.status == 'Realizada').length;
    final canceladas = _viagens.length - realizadas;

    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de Viagens')),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _Resumo(
                        valor: realizadas,
                        rotulo: 'Realizadas',
                        cor: Colors.green.shade700,
                      ),
                      _Resumo(
                        valor: canceladas,
                        rotulo: 'Canceladas',
                        cor: Colors.red.shade700,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                itemCount: _viagens.length,
                itemBuilder: (context, index) {
                  final viagem = _viagens[index];
                  final realizada = viagem.status == 'Realizada';
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Icon(
                          viagem.sentido == 'Ida'
                              ? Icons.arrow_forward
                              : Icons.arrow_back,
                        ),
                      ),
                      title: Text('${viagem.sentido} • ${viagem.data}'),
                      subtitle: Text('${viagem.ponto} • ${viagem.horario}'),
                      trailing: Text(
                        viagem.status,
                        style: TextStyle(
                          color: realizada
                              ? Colors.green.shade700
                              : Colors.red.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Resumo extends StatelessWidget {
  final int valor;
  final String rotulo;
  final Color cor;

  const _Resumo({
    required this.valor,
    required this.rotulo,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$valor',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: cor),
        ),
        Text(rotulo),
      ],
    );
  }
}
