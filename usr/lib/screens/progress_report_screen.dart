import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgressReportScreen extends StatefulWidget {
  const ProgressReportScreen({super.key});

  @override
  State<ProgressReportScreen> createState() => _ProgressReportScreenState();
}

class _ProgressReportScreenState extends State<ProgressReportScreen> {
  int _totalConversations = 0;
  int _totalWordsLearned = 0;
  int _totalPoints = 0;
  double _averageDifficulty = 1.0;

  @override
  void initState() {
    super.initState();
    _loadProgressData();
  }

  Future<void> _loadProgressData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _totalConversations = prefs.getInt('totalConversations') ?? 0;
      _totalWordsLearned = prefs.getInt('totalWordsLearned') ?? 0;
      _totalPoints = prefs.getInt('totalPoints') ?? 0;
      _averageDifficulty = prefs.getDouble('averageDifficulty') ?? 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Progress Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Learning Progress',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildProgressItem('Total Conversations', _totalConversations.toString()),
                    _buildProgressItem('Words Learned', _totalWordsLearned.toString()),
                    _buildProgressItem('Points Earned', _totalPoints.toString()),
                    _buildProgressItem('Average Difficulty', _averageDifficulty.toStringAsFixed(1)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Keep up the great work!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
