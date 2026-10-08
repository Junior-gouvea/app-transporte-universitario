import 'package:flutter/material.dart';
import '../controller/home_aluno_controller.dart';

class HomeAlunoView extends StatefulWidget {
  const HomeAlunoView({super.key});

  @override
  State<HomeAlunoView> createState() => _HomeAlunoViewState();
}

class _HomeAlunoViewState extends State<HomeAlunoView> {
  final _controller = HomeAlunoController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _abrir(String rota) {
    Navigator.pop(context); // fecha o menu lateral
    Navigator.pushNamed(context, rota);
  }

  void _sair() {
    _controller.sair();
    Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Meu Transporte'),
            actions: [
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () => Navigator.pushNamed(context, 'perfil'),
              ),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(_controller.nome),
                  accountEmail: Text(_controller.email),
                  currentAccountPicture: CircleAvatar(
                    child: Text(
                      _controller.inicial,
                      style: const TextStyle(fontSize: 28),
                    ),
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
                  onTap: () => _abrir('perfil'),
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
                    'Olá, ${_controller.nome}!',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Card(
                    elevation: 3,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Status de Hoje',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text('• Ida: Confirmado (18:10)'),
                          Text('• Volta: Confirmado (22:30)'),
                          Text('• Ponto: Praça Central'),
                        ],
                      ),
                    ),
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
      },
    );
  }
}
