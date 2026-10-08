import 'package:flutter/material.dart';
import '../model/presenca_model.dart';

enum _Filtro { todos, ida, volta }

class ListaMotoristaView extends StatefulWidget {
  const ListaMotoristaView({super.key});

  @override
  State<ListaMotoristaView> createState() => _ListaMotoristaViewState();
}

class _ListaMotoristaViewState extends State<ListaMotoristaView> {
  // Dados estáticos (mockados) para demonstrar a listagem
  final List<PresencaModel> _alunos = [
    PresencaModel(alunoId: '1', nomeAluno: 'Ana Souza', vaiNaIda: true, vaiNaVolta: true, pontoEmbarque: 'Praça Central'),
    PresencaModel(alunoId: '2', nomeAluno: 'Bruno Lima', vaiNaIda: true, vaiNaVolta: false, pontoEmbarque: 'Posto de Combustível'),
    PresencaModel(alunoId: '3', nomeAluno: 'Carla Mendes', vaiNaIda: true, vaiNaVolta: true, pontoEmbarque: 'Entrada da Cidade'),
    PresencaModel(alunoId: '4', nomeAluno: 'Diego Rocha', vaiNaIda: false, vaiNaVolta: true, pontoEmbarque: 'Praça Central'),
    PresencaModel(alunoId: '5', nomeAluno: 'Elisa Prado', vaiNaIda: true, vaiNaVolta: true, pontoEmbarque: 'Posto de Combustível'),
    PresencaModel(alunoId: '6', nomeAluno: 'Felipe Castro', vaiNaIda: false, vaiNaVolta: true, pontoEmbarque: 'Entrada da Cidade'),
  ];

  _Filtro _filtro = _Filtro.todos;

  List<PresencaModel> get _alunosFiltrados {
    switch (_filtro) {
      case _Filtro.ida:
        return _alunos.where((a) => a.vaiNaIda).toList();
      case _Filtro.volta:
        return _alunos.where((a) => a.vaiNaVolta).toList();
      case _Filtro.todos:
        return _alunos;
    }
  }

  @override
  Widget build(BuildContext context) {
    final alunos = _alunosFiltrados;
    final totalIda = _alunos.where((a) => a.vaiNaIda).length;
    final totalVolta = _alunos.where((a) => a.vaiNaVolta).length;

    return Scaffold(
      appBar: AppBar(title: const Text('Lista do Motorista')),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Row(
                children: [
                  Expanded(
                    child: _ResumoCard(
                      titulo: 'Ida',
                      total: totalIda,
                      icone: Icons.arrow_forward,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ResumoCard(
                      titulo: 'Volta',
                      total: totalVolta,
                      icone: Icons.arrow_back,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: SegmentedButton<_Filtro>(
                  segments: const [
                    ButtonSegment(value: _Filtro.todos, label: Text('Todos')),
                    ButtonSegment(value: _Filtro.ida, label: Text('Ida')),
                    ButtonSegment(value: _Filtro.volta, label: Text('Volta')),
                  ],
                  selected: {_filtro},
                  onSelectionChanged: (selecao) =>
                      setState(() => _filtro = selecao.first),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: alunos.isEmpty
                  ? const Center(child: Text('Nenhum aluno confirmado.'))
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                      itemCount: alunos.length,
                      itemBuilder: (context, index) {
                        final aluno = alunos[index];
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(aluno.nomeAluno[0]),
                            ),
                            title: Text(aluno.nomeAluno),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Embarque: ${aluno.pontoEmbarque}'),
                                const SizedBox(height: 4),
                                Wrap(
                                  spacing: 6,
                                  children: [
                                    if (aluno.vaiNaIda)
                                      const Chip(
                                        visualDensity: VisualDensity.compact,
                                        avatar: Icon(Icons.arrow_forward, size: 16),
                                        label: Text('Ida'),
                                      ),
                                    if (aluno.vaiNaVolta)
                                      const Chip(
                                        visualDensity: VisualDensity.compact,
                                        avatar: Icon(Icons.arrow_back, size: 16),
                                        label: Text('Volta'),
                                      ),
                                  ],
                                ),
                              ],
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

class _ResumoCard extends StatelessWidget {
  final String titulo;
  final int total;
  final IconData icone;

  const _ResumoCard({
    required this.titulo,
    required this.total,
    required this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icone, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 4),
            Text(
              '$total',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text('Passageiros ($titulo)'),
          ],
        ),
      ),
    );
  }
}
