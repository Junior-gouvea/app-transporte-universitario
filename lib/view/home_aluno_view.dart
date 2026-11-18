import 'package:flutter/material.dart';
import '../controller/home_aluno_controller.dart';
import '../model/presenca_model.dart';

class HomeAlunoView extends StatefulWidget {
  const HomeAlunoView({super.key});

  @override
  State<HomeAlunoView> createState() => _HomeAlunoViewState();
}

class _HomeAlunoViewState extends State<HomeAlunoView> {
  final _controller = HomeAlunoController();
  String _nome = 'Aluno';
  String _email = '';
  bool _carregado = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_carregado) return;
    _carregado = true;

    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, String>) {
      _nome = args['nome'] ?? _nome;
      _email = args['email'] ?? '';
    }
    _carregarPerfil();
  }

  Future<void> _carregarPerfil() async {
    final dados = await _controller.carregarDadosUsuario();
    if (!mounted) return;
    setState(() {
      _nome = dados['nome'] ?? _nome;
      _email = dados['email'] ?? _email;
    });
  }

  String get _inicial => _nome.isNotEmpty ? _nome[0].toUpperCase() : '?';

  Future<void> _abrirPerfil() async {
    final novoNome = await Navigator.pushNamed<String>(
      context,
      'perfil',
      arguments: <String, String>{'nome': _nome, 'email': _email},
    );
    if (novoNome != null && mounted) {
      setState(() => _nome = novoNome);
    }
  }

  void _abrir(String rota) {
    Navigator.pop(context);
    Navigator.pushNamed(context, rota);
  }

  Future<void> _sair() async {
    await _controller.sair();
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Transporte'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: _abrirPerfil,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(_nome),
              accountEmail: Text(_email),
              currentAccountPicture: CircleAvatar(
                child: Text(_inicial, style: const TextStyle(fontSize: 28)),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Início'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Meu Perfil'),
              onTap: () {
                Navigator.pop(context);
                _abrirPerfil();
              },
            ),
            ListTile(
              leading: const Icon(Icons.place),
              title: const Text('Gerenciar Pontos'),
              onTap: () => _abrir('gerenciar_pontos'),
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Histórico de Viagens'),
              onTap: () => _abrir('historico_viagens'),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Sobre'),
              onTap: () => _abrir('sobre'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sair'),
              onTap: _sair,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Olá, $_nome!',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              StreamBuilder<PresencaModel?>(
                stream: _controller.streamStatusHoje(),
                builder: (context, snapshot) {
                  final presenca = snapshot.data;
                  final textoIda = presenca == null
                      ? 'Não confirmado'
                      : (presenca.vaiNaIda ? 'Confirmado (18:10)' : 'Não vai');
                  final textoVolta = presenca == null
                      ? 'Não confirmado'
                      : (presenca.vaiNaVolta
                          ? 'Confirmado (22:30)'
                          : 'Não vai');
                  final textoPonto = presenca?.pontoEmbarque ?? 'Praça Central';

                  return Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Status de Hoje',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: LinearProgressIndicator(),
                            )
                          else ...[
                            Text('• Ida: $textoIda'),
                            Text('• Volta: $textoVolta'),
                            Text('• Ponto: $textoPonto'),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.edit_calendar),
                label: const Text('Alterar Confirmação do Dia'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'confirmar_presenca');
                },
              ),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                icon: const Icon(Icons.format_list_bulleted),
                label: const Text('Ver Lista do Motorista'),
                onPressed: () {
                  Navigator.pushNamed(context, 'lista_motorista');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
