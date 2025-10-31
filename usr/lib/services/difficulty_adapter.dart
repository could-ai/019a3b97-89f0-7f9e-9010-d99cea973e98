import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DifficultyAdapter {
  static Future<String> getCurrentDifficulty() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('difficulty') ?? 'medium';
  }

  static Future<void> updateDifficulty(String userMessage, bool success) async {
    final prefs = await SharedPreferences.getInstance();
    final currentDifficulty = prefs.getString('difficulty') ?? 'medium';
    final successRate = (prefs.getDouble('successRate') ?? 0.5);

    // Simple adaptive algorithm
    double newSuccessRate = success ? (successRate + 0.1) : (successRate - 0.1);
    newSuccessRate = newSuccessRate.clamp(0.0, 1.0);
    await prefs.setDouble('successRate', newSuccessRate);

    String newDifficulty;
    if (newSuccessRate > 0.8) {
      newDifficulty = 'hard';
    } else if (newSuccessRate < 0.3) {
      newDifficulty = 'easy';
    } else {
      newDifficulty = 'medium';
    }

    await prefs.setString('difficulty', newDifficulty);
  }

  static Future<String> getAdaptiveResponse(String baseResponse) async {
    final difficulty = await getCurrentDifficulty();
    switch (difficulty) {
      case 'easy':
        return '$baseResponse (Einfach)';
      case 'hard':
        return '$baseResponse (Schwierig - Versuchen Sie es!)';
      default:
        return baseResponse;
    }
  }
}
