import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:couldai_user_app/providers/auth_provider.dart';
import 'package:couldai_user_app/screens/chat_screen.dart';
import 'package:couldai_user_app/screens/daily_challenges_screen.dart';
import 'package:couldai_user_app/screens/home_screen.dart';
import 'package:couldai_user_app/screens/offline_dictionary_screen.dart';
import 'package:couldai_user_app/screens/progress_report_screen.dart';
import 'package:couldai_user_app/screens/registration_screen.dart';
import 'package:couldai_user_app/screens/settings_screen.dart';
import 'package:couldai_user_app/screens/travel_mode_screen.dart';
import 'package:couldai_user_app/utils/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final userData = await UserPreferences.loadUserData();
  final bool hasCompletedRegistration = userData['hasCompletedRegistration'] as bool? ?? false;

  runApp(MyApp(
    hasCompletedRegistration: hasCompletedRegistration,
  ));
}

class MyApp extends StatelessWidget {
  final bool hasCompletedRegistration;

  const MyApp({super.key, required this.hasCompletedRegistration});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        title: 'German ChatBot App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: hasCompletedRegistration ? const HomeScreen() : const RegistrationScreen(),
        routes: {
          '/': (context) => hasCompletedRegistration ? const HomeScreen() : const RegistrationScreen(),
          '/register': (context) => const RegistrationScreen(),
          '/chat': (context) => const ChatScreen(),
          '/home': (context) => const HomeScreen(),
          '/challenges': (context) => const DailyChallengesScreen(),
          '/progress': (context) => const ProgressReportScreen(),
          '/dictionary': (context) => const OfflineDictionaryScreen(),
          '/travel': (context) => const TravelModeScreen(),
          '/settings': (context) => const SettingsScreen(),
        },
      ),
    );
  }
}
