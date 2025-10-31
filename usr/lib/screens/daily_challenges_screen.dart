import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyChallengesScreen extends StatefulWidget {
  const DailyChallengesScreen({super.key});

  @override
  State<DailyChallengesScreen> createState() => _DailyChallengesScreenState();
}

class _DailyChallengesScreenState extends State<DailyChallengesScreen> {
  final List<Map<String, dynamic>> _challenges = [
    {'title': 'Learn 5 new words about food', 'completed': false, 'points': 50},
    {'title': 'Have a 5-minute conversation', 'completed': false, 'points': 30},
    {'title': 'Translate 3 sentences', 'completed': false, 'points': 40},
    {'title': 'Listen to pronunciation 10 times', 'completed': false, 'points': 20},
  ];
  int _totalPoints = 0;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      for (int i = 0; i < _challenges.length; i++) {
        _challenges[i]['completed'] = prefs.getBool('challenge_$i') ?? false;
      }
      _totalPoints = prefs.getInt('totalPoints') ?? 0;
    });
  }

  Future<void> _completeChallenge(int index) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _challenges[index]['completed'] = true;
      _totalPoints += _challenges[index]['points'] as int;
    });
    await prefs.setBool('challenge_$index', true);
    await prefs.setInt('totalPoints', _totalPoints);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Challenges'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Points: $_totalPoints', style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _challenges.length,
        itemBuilder: (context, index) {
          final challenge = _challenges[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(challenge['title']),
              subtitle: Text('Points: ${challenge['points']}'),
              trailing: challenge['completed']
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : ElevatedButton(
                      onPressed: () => _completeChallenge(index),
                      child: const Text('Complete'),
                    ),
            ),
          );
        },
      ),
    );
  }
}
