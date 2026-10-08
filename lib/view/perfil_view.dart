import 'package:flutter/material.dart';
import '../utils/validadores.dart';

class PerfilView extends StatefulWidget {
  const PerfilView({super.key});

  @override
  State<PerfilView> createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  final _formKey = GlobalKey<FormState>();
  final _nomeCtrl = TextEditingController();
  String _nomeSalvo = 'Aluno';
  String _email = '';
  bool _carregado = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_carregado) return;
    _carregado = true;

    // A Home envia nome e e-mail do usuário como argumento da rota
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, String>) {
      _nomeSalvo = args['nome'] ?? _nomeSalvo;
      _email = args['email'] ?? '';
    }
    _nomeCtrl.text = _nomeSalvo;
  }

  @override
  void dispose() {
    _nomeCtrl.dispose();
    super.dispose();
  }

  void _salvar() {
    // Nome preenchido e com o mínimo de caracteres (validator do Form)
    if (!_formKey.currentState!.validate()) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Perfil atualizado com sucesso!')),
    );
    // Devolve o novo nome para a tela anterior (Home), que passa a usá-lo
    Navigator.pop(context, _nomeCtrl.text.trim());
  }

  void _cancelar() {
    _nomeCtrl.text = _nomeSalvo; // volta para o nome salvo
    _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final inicial = _nomeSalvo.isNotEmpty ? _nomeSalvo[0].toUpperCase() : '?';

    return Scaffold(
      appBar: AppBar(title: const Text('Meu Perfil')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 48,
                    child: Text(inicial, style: const TextStyle(fontSize: 40)),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _nomeSalvo,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nomeCtrl,
                  textCapitalization: TextCapitalization.words,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                  validator: Validadores.nome,
                ),
                const SizedBox(height: 12),
                // E-mail somente para visualização
                TextFormField(
                  initialValue: _email,
                  enabled: false,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    prefixIcon: Icon(Icons.email_outlined),
                    suffixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 50,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    label: const Text('Salvar alterações'),
                    onPressed: _salvar,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  child: OutlinedButton(
                    onPressed: _cancelar,
                    child: const Text('Cancelar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
