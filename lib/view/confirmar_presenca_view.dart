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
  void initState() {
    super.initState();
    // Escuta as alterações no controller para atualizar a interface
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
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
                onChanged: (val) => _controller.alternarIda(val),
              ),
              const Divider(),
              SwitchListTile(
                title: const Text('Vou na volta'),
                subtitle: const Text('Retorno da faculdade para casa'),
                value: _controller.vaiNaVolta,
                onChanged: (val) => _controller.alternarVolta(val),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
              initialValue: _controller.pontoEmbarque,   // antes: value:
              decoration: const InputDecoration(
                  labelText: 'Ponto de Embarque / Desembarque',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'Praça Central', child: Text('Praça Central')),
                  DropdownMenuItem(value: 'Posto de Combustível', child: Text('Posto de Combustível')),
                  DropdownMenuItem(value: 'Entrada da Cidade', child: Text('Entrada da Cidade')),
                ],
                onChanged: (novoPonto) {
                  if (novoPonto != null) _controller.alterarPonto(novoPonto);
                },
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Presença atualizada com sucesso!')),
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
  }
}