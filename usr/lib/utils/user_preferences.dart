import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String _languageToLearnKey = 'languageToLearn';
  static const String _proficiencyLevelKey = 'proficiencyLevel';
  static const String _interfaceLanguageKey = 'interfaceLanguage';
  static const String _rememberMeKey = 'rememberMe';
  static const String _emailKey = 'email';
  static const String _passwordKey = 'password';

  static Future<void> saveUserData({
    required String languageToLearn,
    required String proficiencyLevel,
    required String interfaceLanguage,
    required bool rememberMe,
    String? email,
    String? password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageToLearnKey, languageToLearn);
    await prefs.setString(_proficiencyLevelKey, proficiencyLevel);
    await prefs.setString(_interfaceLanguageKey, interfaceLanguage);
    await prefs.setBool(_rememberMeKey, rememberMe);
    if (rememberMe && email != null && password != null) {
      await prefs.setString(_emailKey, email);
      await prefs.setString(_passwordKey, password);
    }
  }

  static Future<Map<String, dynamic>> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'languageToLearn': prefs.getString(_languageToLearnKey) ?? 'German',
      'proficiencyLevel': prefs.getString(_proficiencyLevelKey) ?? 'A1',
      'interfaceLanguage': prefs.getString(_interfaceLanguageKey) ?? 'English',
      'rememberMe': prefs.getBool(_rememberMeKey) ?? false,
      'email': prefs.getString(_emailKey),
      'password': prefs.getString(_passwordKey),
    };
  }

  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_emailKey);
    await prefs.remove(_passwordKey);
    await prefs.setBool(_rememberMeKey, false);
  }
}
