import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceCommandHandler {
  final stt.SpeechToText _speech;
  final Function(String) onCommandRecognized;

  VoiceCommandHandler(this._speech, this.onCommandRecognized);

  Future<void> startListening() async {
    await _speech.listen(
      onResult: (result) {
        if (result.finalResult) {
          _processCommand(result.recognizedWords.toLowerCase());
        }
      },
      listenFor: const Duration(seconds: 10),
      pauseFor: const Duration(seconds: 3),
    );
  }

  void _processCommand(String command) {
    if (command.contains('prevod') || command.contains('translate')) {
      onCommandRecognized('translate');
    } else if (command.contains('pomoć') || command.contains('hilfe') || command.contains('help')) {
      onCommandRecognized('help');
    } else if (command.contains('bot off')) {
      onCommandRecognized('shutdown');
    }
  }

  void stopListening() {
    _speech.stop();
  }
}
