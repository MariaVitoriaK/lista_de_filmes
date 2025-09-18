// lib/screens/about_screen.dart
import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sobre")),
      drawer: const AppDrawer(),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "📚 Desenvolvedores:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "👩 Vitória - Matrícula: 12345 - Curso: Ciência da Computação",
            ),
            SizedBox(height: 20),
            Text(
              "💡 Projeto feito para a disciplina de Desenvolvimento Mobile.",
            ),
          ],
        ),
      ),
    );
  }
}
