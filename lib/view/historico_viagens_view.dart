import 'package:flutter/material.dart';
import '../controller/historico_viagens_controller.dart';

class HistoricoViagensView extends StatefulWidget {
  const HistoricoViagensView({super.key});

  @override
  State<HistoricoViagensView> createState() => _HistoricoViagensViewState();
}

class _HistoricoViagensViewState extends State<HistoricoViagensView> {
  final _controller = HistoricoViagensController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de Viagens')),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _controller,
          builder: (context, _) {
            final viagens = _controller.viagens;
            return Column(
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
                            valor: _controller.totalRealizadas,
                            rotulo: 'Realizadas',
                            cor: Colors.green.shade700,
                          ),
                          _Resumo(
                            valor: _controller.totalCanceladas,
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
                    itemCount: viagens.length,
                    itemBuilder: (context, index) {
                      final viagem = viagens[index];
                      final realizada = viagem.status == 'Realizada';
                      final cor =
                          realizada ? Colors.green.shade700 : Colors.red.shade700;
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
                              color: cor,
                              fontWeight: FontWeight.bold,
                            ),
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
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: cor,
          ),
        ),
        Text(rotulo),
      ],
    );
  }
}
