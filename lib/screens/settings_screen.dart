import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/app_drawer.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _avatarController = TextEditingController();

  @override
  void dispose() {
    _avatarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final user = auth.currentUser;
    final settings = Provider.of<SettingsProvider>(context);

    if (user != null) {
      _avatarController.text = user.avatarUrl ?? "";
      // Preenche campo com avatar atual
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Configurações")),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (user != null) ...[
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                  user.avatarUrl ?? "https://via.placeholder.com/150",
                ),
              ),
              const SizedBox(height: 10),
              Text(user.name, style: const TextStyle(fontSize: 18)),
              Text(user.email, style: const TextStyle(color: Colors.grey)),
              const Divider(),
              TextField(
                controller: _avatarController,
                decoration: const InputDecoration(
                  labelText: "URL da foto de perfil",
                  prefixIcon: Icon(Icons.link),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  auth.updateAvatar(_avatarController.text);
                  setState(() {}); // Atualiza a tela para refletir nova foto
                },
                child: const Text("Salvar foto"),
              ),
              const Divider(),
            ],
            const Text("Alterar Cor Primária"),
            Wrap(
              spacing: 8,
              children:
                  [
                    Colors.blue,
                    Colors.red,
                    Colors.green,
                    Colors.orange,
                    Colors.purple,
                  ].map((color) {
                    return GestureDetector(
                      onTap: () => settings.setPrimaryColor(color),
                      child: CircleAvatar(
                        backgroundColor: color,
                        child: settings.primaryColor == color
                            ? const Icon(Icons.check, color: Colors.white)
                            : null,
                      ),
                    );
                  }).toList(),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                await auth.logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text("Sair"),
            ),
          ],
        ),
      ),
    );
  }
}
