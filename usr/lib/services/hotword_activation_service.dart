import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HotwordActivationService {
  static const String _hotword = 'hallo bot';

  static Future<void> initialize() async {
    // In a real implementation, this would set up background listening
    // For now, this is a placeholder for future foreground service implementation
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hotwordEnabled', true);
  }

  static Future<bool> isHotwordEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('hotwordEnabled') ?? false;
  }

  static Future<void> setHotwordEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hotwordEnabled', enabled);
  }

  // This would be called when hotword is detected
  static void onHotwordDetected(BuildContext context) {
    // Navigate to chat screen or show overlay
    Navigator.pushNamed(context, '/chat');
  }
}
