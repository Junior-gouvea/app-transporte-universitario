import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controller/cadastro_usuario_controller.dart';

class CadastroUsuarioView extends StatefulWidget {
  const CadastroUsuarioView({super.key});

  @override
  State<CadastroUsuarioView> createState() => _CadastroUsuarioViewState();
}

class _CadastroUsuarioViewState extends State<CadastroUsuarioView> {
  final _controller = CadastroUsuarioController();
  final _formKey = GlobalKey<FormState>();
  final _nomeCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _telefoneCtrl = TextEditingController();
  final _senhaCtrl = TextEditingController();
  final _confirmacaoCtrl = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    _nomeCtrl.dispose();
    _emailCtrl.dispose();
    _telefoneCtrl.dispose();
    _senhaCtrl.dispose();
    _confirmacaoCtrl.dispose();
    super.dispose();
  }

  void _cadastrar() {
    // Campos obrigatórios, e-mail válido e senhas iguais (validators do Form)
    if (!_formKey.currentState!.validate()) return;

    final erro = _controller.cadastrar(
      nome: _nomeCtrl.text,
      email: _emailCtrl.text,
      telefone: _telefoneCtrl.text,
      senha: _senhaCtrl.text,
    );

    if (erro != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(erro),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Conta criada com sucesso!')),
    );
    // Após o cadastro o usuário acessa o app (e não volta mais para o login)
    Navigator.pushNamedAndRemoveUntil(context, 'home_aluno', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar conta')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ListenableBuilder(
            listenable: _controller,
            builder: (context, _) {
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _nomeCtrl,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Nome completo',
                        prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(),
                      ),
                      validator: _controller.validarNome,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: _controller.validarEmail,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _telefoneCtrl,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9()\-\s+]')),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Telefone (com DDD)',
                        hintText: '(16) 99999-9999',
                        prefixIcon: Icon(Icons.phone_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: _controller.validarTelefone,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _senhaCtrl,
                      obscureText: _controller.ocultarSenha,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _controller.ocultarSenha
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: _controller.alternarSenha,
                        ),
                      ),
                      validator: _controller.validarSenha,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _confirmacaoCtrl,
                      obscureText: _controller.ocultarConfirmacao,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _cadastrar(),
                      decoration: InputDecoration(
                        labelText: 'Confirmar senha',
                        prefixIcon: const Icon(Icons.lock_reset),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _controller.ocultarConfirmacao
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: _controller.alternarConfirmacao,
                        ),
                      ),
                      validator: (valor) => _controller.validarConfirmacao(
                        valor,
                        _senhaCtrl.text,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _cadastrar,
                        child: const Text(
                          'Criar conta',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
