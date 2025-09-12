// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/movie_provider.dart';
import 'providers/settings_provider.dart';

import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/about_screen.dart';
import 'screens/map_screen.dart';

void main() {
  runApp(const ListaDeFilmesApp());
}

class ListaDeFilmesApp extends StatelessWidget {
  const ListaDeFilmesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider()..loadCurrentUser(),
        ),
        ChangeNotifierProvider(create: (_) => MovieProvider()..loadMovies()),
        ChangeNotifierProvider(
          create: (_) => SettingsProvider()..loadSettings(),
        ),
      ],
      child: Consumer<SettingsProvider>(
        builder: (ctx, settings, _) {
          return MaterialApp(
            title: 'Lista de Filmes',
            theme: ThemeData(
              primaryColor: settings.primaryColor,
              colorScheme: ColorScheme.fromSeed(
                seedColor: settings.primaryColor,
              ),
              useMaterial3: true,
            ),
            initialRoute: '/login',
            routes: {
              '/login': (ctx) => const LoginScreen(),
              '/register': (ctx) => const RegisterScreen(),
              '/home': (ctx) => const HomeScreen(),
              '/settings': (ctx) => const SettingsScreen(),
              '/about': (ctx) => const AboutScreen(),
              '/map': (ctx) => const MapScreen(),
            },
          );
        },
      ),
    );
  }
}
