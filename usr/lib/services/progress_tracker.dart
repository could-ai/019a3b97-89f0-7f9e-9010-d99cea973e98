import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgressTracker {
  static Future<void> updateProgress(String metric, int value) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getInt(metric) ?? 0;
    await prefs.setInt(metric, current + value);
  }

  static Future<Map<String, int>> getProgress() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'totalConversations': prefs.getInt('totalConversations') ?? 0,
      'totalWordsLearned': prefs.getInt('totalWordsLearned') ?? 0,
      'totalChallenges': prefs.getInt('totalChallenges') ?? 0,
      'totalTranslations': prefs.getInt('totalTranslations') ?? 0,
      'totalScenarios': prefs.getInt('totalScenarios') ?? 0,
      'totalPoints': prefs.getInt('totalPoints') ?? 0,
    };
  }

  static Future<void> resetMonthlyProgress() async {
    final prefs = await SharedPreferences.getInstance();
    // Keep lifetime stats, reset monthly counters
    await prefs.remove('monthlyConversations');
    await prefs.remove('monthlyWordsLearned');
    await prefs.remove('monthlyChallenges');
  }
}
