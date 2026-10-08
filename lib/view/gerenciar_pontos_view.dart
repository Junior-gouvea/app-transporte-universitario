import 'package:flutter/material.dart';
import '../utils/validadores.dart';

class GerenciarPontosView extends StatefulWidget {
  const GerenciarPontosView({super.key});

  @override
  State<GerenciarPontosView> createState() => _GerenciarPontosViewState();
}

class _GerenciarPontosViewState extends State<GerenciarPontosView> {
  final List<({String nome, String horario})> _pontos = [
    (nome: 'Praça Central', horario: '18:10'),
    (nome: 'Posto de Combustível', horario: '18:20'),
    (nome: 'Entrada da Cidade', horario: '18:30'),
  ];

  Future<void> _novoPonto() async {
    final resultado = await showDialog<(String, String)>(
      context: context,
      builder: (context) => const _NovoPontoDialog(),
    );
    if (resultado == null || !mounted) return;

    final nome = resultado.$1;
    final jaExiste = _pontos.any(
      (p) => p.nome.toLowerCase() == nome.toLowerCase(),
    );
    if (jaExiste) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Já existe um ponto com este nome.'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    setState(() => _pontos.add((nome: nome, horario: resultado.$2)));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ponto de embarque adicionado!')),
    );
  }

  void _remover(int index) {
    final nome = _pontos[index].nome;
    setState(() => _pontos.removeAt(index));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('"$nome" removido.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pontos de Embarque')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _novoPonto,
        icon: const Icon(Icons.add_location_alt),
        label: const Text('Novo ponto'),
      ),
      body: SafeArea(
        child: _pontos.isEmpty
            ? const Center(child: Text('Nenhum ponto cadastrado.'))
            : ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 90),
                itemCount: _pontos.length,
                itemBuilder: (context, index) {
                  final ponto = _pontos[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.place),
                      title: Text(ponto.nome),
                      subtitle: Text('Horário de saída: ${ponto.horario}'),
                      trailing: IconButton(
                        tooltip: 'Remover ponto',
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => _remover(index),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class _NovoPontoDialog extends StatefulWidget {
  const _NovoPontoDialog();

  @override
  State<_NovoPontoDialog> createState() => _NovoPontoDialogState();
}

class _NovoPontoDialogState extends State<_NovoPontoDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nomeCtrl = TextEditingController();
  final _horarioCtrl = TextEditingController();

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _horarioCtrl.dispose();
    super.dispose();
  }

  void _confirmar() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(context, (_nomeCtrl.text.trim(), _horarioCtrl.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Novo ponto de embarque'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nomeCtrl,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Nome do ponto',
                border: OutlineInputBorder(),
              ),
              validator: (valor) =>
                  Validadores.obrigatorio(valor, 'Informe o nome do ponto'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _horarioCtrl,
              keyboardType: TextInputType.datetime,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _confirmar(),
              decoration: const InputDecoration(
                labelText: 'Horário de saída',
                hintText: 'HH:mm',
                border: OutlineInputBorder(),
              ),
              validator: Validadores.horario,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: _confirmar,
          child: const Text('Adicionar'),
        ),
      ],
    );
  }
}
