# couldai_user_app

A comprehensive German language learning application with AI-powered chatbot, voice interaction, and gamified learning features.

## Features

### Core Functionality
- **User Authentication**: Login/Registration with language preferences
- **AI ChatBot**: Conversational German learning with voice input/output
- **Voice Commands**: Personalized commands like "Prevod" (translate), "Pomoć" (help), "Bot Off"
- **Hotword Activation**: "Hallo Bot" wake word for hands-free interaction
- **Conversation Memory**: Persistent chat history stored locally

### Learning Tools
- **Adaptive Difficulty**: Automatically adjusts conversation complexity based on user performance
- **Daily Challenges**: Gamified tasks with points and badges system
- **Progress Reports**: Monthly learning analytics and achievements
- **Offline Dictionary**: Built-in vocabulary with search and categories
- **Travel Mode**: Scenario-based learning (airport, restaurant, shopping, hotel)

### Multimedia Features
- **Speech-to-Text**: Voice input with multi-language support
- **Text-to-Speech**: Voice output for bot responses
- **Visual Recognition**: Camera-based object identification in German
- **Offline Mode**: Core features work without internet connection

### Technical Features
- **Cross-platform**: Built with Flutter for Android/iOS deployment
- **Local Storage**: SharedPreferences for offline data persistence
- **Modular Architecture**: Clean separation of services and UI components
- **Ready for Backend**: Structured for easy Firebase/Supabase integration

## Getting Started

1. **Prerequisites**
   - Flutter SDK (^3.7.2)
   - Android Studio or VS Code
   - Android device/emulator for testing

2. **Installation**
   ```bash
   git clone <repository-url>
   cd couldai_user_app
   flutter pub get
   ```

3. **Configuration**
   - For Firebase integration: Add `google-services.json` to `android/app/`
   - For OpenAI API: Add your API key to environment variables
   - For production: Configure signing keys and update version in `pubspec.yaml`

4. **Running the App**
   ```bash
   flutter run
   ```

5. **Building for Release**
   ```bash
   flutter build apk --release
   ```

## Architecture

### Directory Structure
```
lib/
├── main.dart                 # App entry point with routing
├── providers/
│   └── auth_provider.dart    # Authentication state management
├── screens/                  # UI screens
│   ├── login_screen.dart
│   ├── registration_screen.dart
│   ├── chat_screen.dart      # Main chatbot interface
│   ├── home_screen.dart      # Feature navigation hub
│   ├── daily_challenges_screen.dart
│   ├── progress_report_screen.dart
│   ├── offline_dictionary_screen.dart
│   ├── travel_mode_screen.dart
│   └── settings_screen.dart
├── services/                 # Business logic services
│   ├── chat_bot_service.dart
│   ├── conversation_history_service.dart
│   ├── difficulty_adapter.dart
│   ├── badge_system.dart
│   ├── progress_tracker.dart
│   ├── hotword_activation_service.dart
│   └── voice_command_handler.dart
└── utils/
    └── user_preferences.dart
```

### Key Components

- **ChatScreen**: Central hub with voice/text chat, camera integration
- **HomeScreen**: Grid-based navigation to all features
- **Service Layer**: Modular services for specific functionalities
- **Provider Pattern**: State management for authentication and app state

## API Integration Ready

The app is structured to easily integrate with backend services:

- **Firebase Firestore**: For conversation history and user data
- **Firebase Auth**: For user authentication
- **OpenAI API**: For enhanced AI responses
- **Supabase**: Alternative backend option

## Security Notes

- No API keys included in source code
- Local data storage for offline functionality
- Prepared for secure backend integration
- Follow Flutter security best practices

## Contributing

1. Follow Flutter code style guidelines
2. Add tests for new features
3. Update documentation for API changes
4. Ensure cross-platform compatibility

## License

This project is licensed under the MIT License - see the LICENSE file for details.
