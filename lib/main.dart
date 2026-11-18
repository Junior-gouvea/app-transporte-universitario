import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_preview_plus/device_preview_plus.dart';
import 'firebase_options.dart';

import 'view/login_view.dart';
import 'view/cadastro_usuario_view.dart';
import 'view/perfil_view.dart';
import 'view/recuperar_senha_view.dart';
import 'view/sobre_view.dart';
import 'view/home_aluno_view.dart';
import 'view/confirmar_presenca_view.dart';
import 'view/lista_motorista_view.dart';
import 'view/gerenciar_pontos_view.dart';
import 'view/historico_viagens_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Transporte Universitário',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: 'login',
      routes: {
        'login': (context) => const LoginView(),
        'cadastrar_usuario': (context) => const CadastroUsuarioView(),
        'perfil': (context) => const PerfilView(),
        'recuperar_senha': (context) => const RecuperarSenhaView(),
        'sobre': (context) => const SobreView(),
        'home_aluno': (context) => const HomeAlunoView(),
        'confirmar_presenca': (context) => const ConfirmarPresencaView(),
        'lista_motorista': (context) => const ListaMotoristaView(),
        'gerenciar_pontos': (context) => const GerenciarPontosView(),
        'historico_viagens': (context) => const HistoricoViagensView(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const LoginView(),
        );
      },
    );
  }
}
