import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  // Registrar usuário
  Future<bool> register(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString('users') ?? '{}';
    final usersMap = jsonDecode(usersJson) as Map<String, dynamic>;

    if (usersMap.containsKey(user.email)) return false; // usuário já existe

    usersMap[user.email] = user.toJson();
    await prefs.setString('users', jsonEncode(usersMap));
    return true;
  }

  // Login
  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString('users') ?? '{}';
    final usersMap = jsonDecode(usersJson) as Map<String, dynamic>;

    if (!usersMap.containsKey(email)) return false;

    final user = User.fromJson(usersMap[email]);
    if (user.password != password) return false;

    _currentUser = user;
    await prefs.setString('currentUserEmail', email);
    notifyListeners();
    return true;
  }

  // Logout
  Future<void> logout() async {
    _currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('currentUserEmail');
    notifyListeners();
  }

  // Carregar usuário
  Future<void> loadCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('currentUserEmail');
    if (email == null) return;

    final usersJson = prefs.getString('users') ?? '{}';
    final usersMap = jsonDecode(usersJson) as Map<String, dynamic>;

    if (usersMap.containsKey(email)) {
      _currentUser = User.fromJson(usersMap[email]);
      notifyListeners();
    }
  }

  // Atualizar avatar
  Future<void> updateAvatar(String newAvatarUrl) async {
    if (_currentUser == null) return;

    _currentUser = _currentUser!.copyWith(avatarUrl: newAvatarUrl);

    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString('users') ?? '{}';
    final usersMap = jsonDecode(usersJson) as Map<String, dynamic>;

    usersMap[_currentUser!.email] = _currentUser!.toJson();
    await prefs.setString('users', jsonEncode(usersMap));

    notifyListeners();
  }
}
