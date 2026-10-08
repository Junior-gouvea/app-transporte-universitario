import 'package:flutter/material.dart';
import '../controller/perfil_cotroller.dart';

class PerfilView extends StatefulWidget {
  const PerfilView({super.key});

  @override
  State<PerfilView> createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  final _controller = PerfilCotroller();
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nomeCtrl;

  @override
  void initState() {
    super.initState();
    _nomeCtrl = TextEditingController(text: _controller.nome);
  }

  @override
  void dispose() {
    _controller.dispose();
    _nomeCtrl.dispose();
    super.dispose();
  }

  void _salvar() {
    // Nome preenchido e com o mínimo de caracteres (validator do Form)
    if (!_formKey.currentState!.validate()) return;

    _controller.salvarNome(_nomeCtrl.text);
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Perfil atualizado com sucesso!')),
    );
  }

  void _cancelar() {
    _nomeCtrl.text = _controller.nome; // volta para o nome salvo
    _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        // Regra de negócio: somente usuários autenticados acessam o perfil
        if (!_controller.autenticado) {
          return Scaffold(
            appBar: AppBar(title: const Text('Meu Perfil')),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Você precisa estar logado para ver o perfil.'),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(
                        context,
                        'login',
                        (route) => false,
                      ),
                      child: const Text('Ir para o login'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

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
                        child: Text(
                          _controller.inicial,
                          style: const TextStyle(fontSize: 40),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _controller.nome,
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
                      validator: _controller.validarNome,
                    ),
                    const SizedBox(height: 12),
                    // E-mail somente para visualização
                    TextFormField(
                      initialValue: _controller.email,
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
      },
    );
  }
}
