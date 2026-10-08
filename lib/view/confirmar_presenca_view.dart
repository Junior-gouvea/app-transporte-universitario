import 'package:flutter/material.dart';
import '../controller/confirmar_presenca_controller.dart';

class ConfirmarPresencaView extends StatefulWidget {
  const ConfirmarPresencaView({super.key});

  @override
  State<ConfirmarPresencaView> createState() => _ConfirmarPresencaViewState();
}

class _ConfirmarPresencaViewState extends State<ConfirmarPresencaView> {
  final _controller = ConfirmarPresencaController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ListenableBuilder escuta o controller e remove o listener sozinho
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        final semPontos = _controller.pontoEmbarque == null;
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
                  // Itens vêm dos pontos cadastrados em Gerenciar Pontos
                  InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Ponto de Embarque / Desembarque',
                      border: OutlineInputBorder(),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _controller.pontoEmbarque,
                        hint: const Text('Nenhum ponto cadastrado'),
                        items: [
                          for (final nome in _controller.nomesPontos)
                            DropdownMenuItem(value: nome, child: Text(nome)),
                        ],
                        onChanged: (novoPonto) {
                          if (novoPonto != null) {
                            _controller.alterarPonto(novoPonto);
                          }
                        },
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: semPontos
                          ? null
                          : () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Presença atualizada com sucesso!'),
                                ),
                              );
                              Navigator.pop(context);
                            },
                      child: const Text('Salvar Presença'),
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
