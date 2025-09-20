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

  void _changeAvatar(BuildContext context, AuthProvider auth) {
    _avatarController.text = auth.currentUser?.avatarUrl ?? "";

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Mudar foto do perfil"),
        content: TextField(
          controller: _avatarController,
          decoration: const InputDecoration(
            labelText: "URL da foto de perfil",
            prefixIcon: Icon(Icons.link),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              auth.updateAvatar(_avatarController.text);
              Navigator.pop(ctx);
              setState(() {});
            },
            child: const Text("Salvar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final user = auth.currentUser;
    final settings = Provider.of<SettingsProvider>(context);

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
                  user.avatarUrl ??
                      "https://cdn.pixabay.com/photo/2023/02/18/11/00/icon-7797704_640.png",
                ),
              ),
              const SizedBox(height: 10),
              Text(user.name, style: const TextStyle(fontSize: 18)),
              Text(user.email, style: const TextStyle(color: Colors.grey)),
              const Divider(),
              ElevatedButton.icon(
                onPressed: () => _changeAvatar(context, auth),
                icon: const Icon(Icons.photo_camera),
                label: const Text("Mudar foto do perfil"),
              ),
              const Divider(),
            ],

            // === Alterar cor primária ===
            const Text("Alterar Cor Primária"),
            Wrap(
              spacing: 8,
              children:
                  [
                    const Color.fromARGB(255, 99, 138, 170),
                    const Color.fromARGB(255, 129, 68, 64),
                    const Color.fromARGB(255, 67, 102, 68),
                    const Color.fromARGB(255, 179, 143, 89),
                    const Color.fromARGB(255, 150, 106, 158),
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
            const SizedBox(height: 20),

            // Tema
            const Text("Tema do Aplicativo"),
            SwitchListTile(
              title: Text(settings.isDarkMode ? "Modo Escuro" : "Modo Claro"),
              value: settings.isDarkMode,
              onChanged: (val) => settings.toggleTheme(),
              secondary: Icon(
                settings.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              ),
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
