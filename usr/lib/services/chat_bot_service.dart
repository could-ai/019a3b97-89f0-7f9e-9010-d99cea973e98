import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:couldai_user_app/services/conversation_history_service.dart';
import 'package:couldai_user_app/services/difficulty_adapter.dart';
import 'package:couldai_user_app/services/badge_system.dart';
import 'package:couldai_user_app/services/progress_tracker.dart';

class ChatBotService {
  static Future<String> generateResponse(String userMessage) async {
    // Save conversation
    final response = await _getMockResponse(userMessage);
    await ConversationHistoryService.saveConversation(userMessage, response);

    // Update progress
    await ProgressTracker.updateProgress('totalConversations', 1);
    await BadgeSystem.checkAndAwardBadges();

    // Get adaptive response
    return await DifficultyAdapter.getAdaptiveResponse(response);
  }

  static Future<String> _getMockResponse(String message) async {
    // Enhanced mock responses
    final lowerMessage = message.toLowerCase();

    if (lowerMessage.contains('hallo') || lowerMessage.contains('hello')) {
      return 'Hallo! Schön dich zu sehen. Wie kann ich dir heute helfen?';
    } else if (lowerMessage.contains('wie geht')) {
      return 'Mir geht es gut, danke! Wie geht es dir?';
    } else if (lowerMessage.contains('essen') || lowerMessage.contains('food')) {
      return 'Essen ist ein wichtiges Thema! Was ist dein Lieblingsessen?';
    } else if (lowerMessage.contains('zahl') || lowerMessage.contains('number')) {
      return 'Zahlen sind wichtig: eins, zwei, drei, vier, fünf...';
    } else if (lowerMessage.contains('farbe') || lowerMessage.contains('color')) {
      return 'Meine Lieblingsfarbe ist blau! Welche Farbe magst du?';
    } else if (lowerMessage.contains('familie') || lowerMessage.contains('family')) {
      return 'Familie ist sehr wichtig. Erzähl mir von deiner Familie!';
    } else {
      // Random responses for variety
      final responses = [
        'Das ist interessant! Erzähl mir mehr davon.',
        'Gut gesagt! Wie würdest du das auf Deutsch sagen?',
        'Perfekt! Lassen Sie uns das üben.',
        'Ausgezeichnet! Hast du Fragen dazu?',
      ];
      return responses[DateTime.now().millisecondsSinceEpoch % responses.length];
    }
  }

  static Future<String> translateLastSentence(String sentence) async {
    await ProgressTracker.updateProgress('totalTranslations', 1);
    // Mock translation
    return 'Übersetzung: $sentence → [Translated to Serbian]';
  }

  static Future<String> getWordHelp(String word) async {
    // Mock word help
    return 'Hilfe für "$word": Bedeutung, Aussprache, Beispiele...';
  }
}
