import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConversationHistoryService {
  static const String _conversationsKey = 'conversations';

  static Future<void> saveConversation(String userMessage, String botResponse) async {
    final prefs = await SharedPreferences.getInstance();
    final conversations = prefs.getStringList(_conversationsKey) ?? [];
    final timestamp = DateTime.now().toIso8601String();
    final conversationEntry = '$timestamp|$userMessage|$botResponse';
    conversations.add(conversationEntry);
    await prefs.setStringList(_conversationsKey, conversations);
  }

  static Future<List<Map<String, String>>> getConversationHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final conversations = prefs.getStringList(_conversationsKey) ?? [];
    return conversations.map((entry) {
      final parts = entry.split('|');
      return {
        'timestamp': parts[0],
        'userMessage': parts[1],
        'botResponse': parts[2],
      };
    }).toList();
  }

  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_conversationsKey);
  }
}
