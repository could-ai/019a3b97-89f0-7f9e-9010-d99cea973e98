import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String _languageToLearnKey = 'languageToLearn';
  static const String _proficiencyLevelKey = 'proficiencyLevel';
  static const String _interfaceLanguageKey = 'interfaceLanguage';
  static const String _hasCompletedRegistrationKey = 'hasCompletedRegistration';

  static Future<void> saveUserData({
    required String languageToLearn,
    required String proficiencyLevel,
    required String interfaceLanguage,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageToLearnKey, languageToLearn);
    await prefs.setString(_proficiencyLevelKey, proficiencyLevel);
    await prefs.setString(_interfaceLanguageKey, interfaceLanguage);
    await prefs.setBool(_hasCompletedRegistrationKey, true);
  }

  static Future<Map<String, dynamic>> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'languageToLearn': prefs.getString(_languageToLearnKey) ?? 'German',
      'proficiencyLevel': prefs.getString(_proficiencyLevelKey) ?? 'A1',
      'interfaceLanguage': prefs.getString(_interfaceLanguageKey) ?? 'English',
      'hasCompletedRegistration': prefs.getBool(_hasCompletedRegistrationKey) ?? false,
    };
  }

  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_languageToLearnKey);
    await prefs.remove(_proficiencyLevelKey);
    await prefs.remove(_interfaceLanguageKey);
    await prefs.remove(_hasCompletedRegistrationKey);
  }
}
