// lib/providers/settings_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  Color _primaryColor = const Color.fromARGB(255, 68, 121, 165); // cor padrão
  bool _isDarkMode = false; // tema padrão: claro

  Color get primaryColor => _primaryColor;
  bool get isDarkMode => _isDarkMode;

  /// 🔹 Carregar configurações salvas
  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    // carregar cor
    final colorValue = prefs.getInt('primaryColor');
    if (colorValue != null) {
      _primaryColor = Color(colorValue);
    }

    // carregar tema
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;

    notifyListeners();
  }

  /// 🔹 Alterar cor primária
  Future<void> setPrimaryColor(Color color) async {
    _primaryColor = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('primaryColor', color.value);
    notifyListeners();
  }

  /// 🔹 Alterar tema (claro <-> escuro)
  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }
}
