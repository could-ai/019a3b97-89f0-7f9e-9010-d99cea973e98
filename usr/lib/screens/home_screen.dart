import 'package:flutter/material.dart';
import 'package:couldai_user_app/screens/daily_challenges_screen.dart';
import 'package:couldai_user_app/screens/progress_report_screen.dart';
import 'package:couldai_user_app/screens/offline_dictionary_screen.dart';
import 'package:couldai_user_app/screens/travel_mode_screen.dart';
import 'package:couldai_user_app/screens/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('German ChatBot App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            ),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildFeatureCard(
            context,
            'ChatBot',
            Icons.chat,
            Colors.blue,
            () => Navigator.pushNamed(context, '/chat'),
          ),
          _buildFeatureCard(
            context,
            'Daily Challenges',
            Icons.star,
            Colors.orange,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DailyChallengesScreen()),
            ),
          ),
          _buildFeatureCard(
            context,
            'Progress Report',
            Icons.bar_chart,
            Colors.green,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProgressReportScreen()),
            ),
          ),
          _buildFeatureCard(
            context,
            'Offline Dictionary',
            Icons.book,
            Colors.purple,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OfflineDictionaryScreen()),
            ),
          ),
          _buildFeatureCard(
            context,
            'Travel Mode',
            Icons.flight,
            Colors.red,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TravelModeScreen()),
            ),
          ),
          _buildFeatureCard(
            context,
            'Settings',
            Icons.settings,
            Colors.grey,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
