import 'package:flutter/material.dart';
import '../controller/lista_motorista_controller.dart';

class ListaMotoristaView extends StatefulWidget {
  const ListaMotoristaView({super.key});

  @override
  State<ListaMotoristaView> createState() => _ListaMotoristaViewState();
}

class _ListaMotoristaViewState extends State<ListaMotoristaView> {
  final _controller = ListaMotoristaController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista do Motorista')),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _controller,
          builder: (context, _) {
            final alunos = _controller.alunosFiltrados;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: _ResumoCard(
                          titulo: 'Ida',
                          total: _controller.totalIda,
                          icone: Icons.arrow_forward,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _ResumoCard(
                          titulo: 'Volta',
                          total: _controller.totalVolta,
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
                    child: SegmentedButton<FiltroSentido>(
                      segments: const [
                        ButtonSegment(
                          value: FiltroSentido.todos,
                          label: Text('Todos'),
                        ),
                        ButtonSegment(
                          value: FiltroSentido.ida,
                          label: Text('Ida'),
                        ),
                        ButtonSegment(
                          value: FiltroSentido.volta,
                          label: Text('Volta'),
                        ),
                      ],
                      selected: {_controller.filtro},
                      onSelectionChanged: (selecao) =>
                          _controller.alterarFiltro(selecao.first),
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
            );
          },
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
