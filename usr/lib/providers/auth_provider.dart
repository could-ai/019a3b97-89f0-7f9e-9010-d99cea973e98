import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  // Mock authentication provider
  // In a real app, this would handle Firebase Auth

  bool _isAuthenticated = false;
  String? _userId;

  bool get isAuthenticated => _isAuthenticated;
  String? get userId => _userId;

  Future<void> signIn(String email, String password) async {
    // Mock sign in
    await Future.delayed(const Duration(seconds: 1));
    _isAuthenticated = true;
    _userId = 'mock_user_id';
    notifyListeners();
  }

  Future<void> signUp(String email, String password, Map<String, dynamic> userData) async {
    // Mock sign up
    await Future.delayed(const Duration(seconds: 1));
    _isAuthenticated = true;
    _userId = 'mock_user_id';
    notifyListeners();
  }

  void signOut() {
    _isAuthenticated = false;
    _userId = null;
    notifyListeners();
  }
}
