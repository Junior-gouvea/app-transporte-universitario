import 'package:flutter/material.dart';
import '../controller/confirmar_presenca_controller.dart';
import '../controller/gerenciar_pontos_controller.dart';
import '../model/ponto_embarque_model.dart';

class ConfirmarPresencaView extends StatefulWidget {
  const ConfirmarPresencaView({super.key});

  @override
  State<ConfirmarPresencaView> createState() => _ConfirmarPresencaViewState();
}

class _ConfirmarPresencaViewState extends State<ConfirmarPresencaView> {
  final _controller = ConfirmarPresencaController();
  final _pontosController = GerenciarPontosController();

  static const List<String> _pontosPadrao = [
    'Praça Central',
    'Posto de Combustível',
    'Entrada da Cidade',
  ];

  @override
  void initState() {
    super.initState();
    _controller.carregarPresencaAtual();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    try {
      await _controller.salvarPresenca();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Presença atualizada com sucesso!'),
        ),
      );
      Navigator.pop(context);
    } catch (erro) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao salvar presença: $erro'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Confirmar Presença'),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Vou na ida'),
                    subtitle: const Text('Saída da cidade para a faculdade'),
                    value: _controller.vaiNaIda,
                    onChanged: _controller.alternarIda,
                  ),
                  const Divider(),
                  SwitchListTile(
                    title: const Text('Vou na volta'),
                    subtitle: const Text('Retorno da faculdade para casa'),
                    value: _controller.vaiNaVolta,
                    onChanged: _controller.alternarVolta,
                  ),
                  const SizedBox(height: 20),
                  StreamBuilder<List<PontoEmbarqueModel>>(
                    stream: _pontosController.streamPontos(),
                    builder: (context, snapshot) {
                      final pontosCadastrados =
                          (snapshot.data ?? []).map((p) => p.nome);
                      final todosPontos = <String>{
                        ..._pontosPadrao,
                        ...pontosCadastrados,
                      }.toList();

                      final valorSelecionado =
                          todosPontos.contains(_controller.pontoEmbarque)
                              ? _controller.pontoEmbarque
                              : todosPontos.first;

                      return InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Ponto de Embarque / Desembarque',
                          border: OutlineInputBorder(),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: valorSelecionado,
                            items: [
                              for (final nome in todosPontos)
                                DropdownMenuItem(
                                    value: nome, child: Text(nome)),
                            ],
                            onChanged: (novoPonto) {
                              if (novoPonto != null) {
                                _controller.alterarPonto(novoPonto);
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _controller.salvando ? null : _salvar,
                      child: _controller.salvando
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Salvar Presença'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
