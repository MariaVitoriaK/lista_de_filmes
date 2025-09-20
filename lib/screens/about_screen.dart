import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sobre")),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "📚 Desenvolvedor:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "👩 Maria Vitória Kuhn - Matrícula: 197960 - Curso: Análise e Desenvolvimento de Sistemas",
            ),
            const SizedBox(height: 20),
            const Text(
              "💡 Projeto feito para a disciplina de Desenvolvimento Mobile III.",
            ),
            const SizedBox(height: 20),
            Center(
              child: Image.asset(
                'assets/meu_cachorro.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
