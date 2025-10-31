import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BadgeSystem {
  static const List<Map<String, dynamic>> _badges = [
    {'id': 'first_conversation', 'title': 'First Steps', 'description': 'Completed your first conversation', 'icon': Icons.chat, 'requirement': 1},
    {'id': 'five_conversations', 'title': 'Chat Enthusiast', 'description': 'Completed 5 conversations', 'icon': Icons.forum, 'requirement': 5},
    {'id': 'ten_challenges', 'title': 'Challenge Master', 'description': 'Completed 10 daily challenges', 'icon': Icons.star, 'requirement': 10},
    {'id': 'translator', 'title': 'Translator', 'description': 'Used translation feature 20 times', 'icon': Icons.translate, 'requirement': 20},
    {'id': 'traveler', 'title': 'World Traveler', 'description': 'Completed 5 travel scenarios', 'icon': Icons.flight, 'requirement': 5},
  ];

  static Future<List<Map<String, dynamic>>> getEarnedBadges() async {
    final prefs = await SharedPreferences.getInstance();
    final earnedBadgeIds = prefs.getStringList('earnedBadges') ?? [];
    return _badges.where((badge) => earnedBadgeIds.contains(badge['id'])).toList();
  }

  static Future<List<Map<String, dynamic>>> getAvailableBadges() async {
    final prefs = await SharedPreferences.getInstance();
    final earnedBadgeIds = prefs.getStringList('earnedBadges') ?? [];
    return _badges.where((badge) => !earnedBadgeIds.contains(badge['id'])).toList();
  }

  static Future<void> checkAndAwardBadges() async {
    final prefs = await SharedPreferences.getInstance();
    final conversations = prefs.getInt('totalConversations') ?? 0;
    final challenges = prefs.getInt('totalChallenges') ?? 0;
    final translations = prefs.getInt('totalTranslations') ?? 0;
    final scenarios = prefs.getInt('totalScenarios') ?? 0;

    final earnedBadgeIds = prefs.getStringList('earnedBadges') ?? [];
    final newBadges = <String>[];

    for (final badge in _badges) {
      if (!earnedBadgeIds.contains(badge['id'])) {
        bool earned = false;
        switch (badge['id']) {
          case 'first_conversation':
          case 'five_conversations':
            earned = conversations >= badge['requirement'];
            break;
          case 'ten_challenges':
            earned = challenges >= badge['requirement'];
            break;
          case 'translator':
            earned = translations >= badge['requirement'];
            break;
          case 'traveler':
            earned = scenarios >= badge['requirement'];
            break;
        }
        if (earned) {
          newBadges.add(badge['id']);
        }
      }
    }

    if (newBadges.isNotEmpty) {
      earnedBadgeIds.addAll(newBadges);
      await prefs.setStringList('earnedBadges', earnedBadgeIds);
    }
  }
}
