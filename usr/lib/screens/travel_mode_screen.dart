import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TravelModeScreen extends StatefulWidget {
  const TravelModeScreen({super.key});

  @override
  State<TravelModeScreen> createState() => _TravelModeScreenState();
}

class _TravelModeScreenState extends State<TravelModeScreen> {
  final List<Map<String, dynamic>> _scenarios = [
    {
      'title': 'At the Airport',
      'description': 'Practice airport conversations',
      'phrases': ['Wo ist der Check-in?', 'Wo ist mein Gate?', 'Ich habe meinen Flug verpasst.'],
    },
    {
      'title': 'At the Restaurant',
      'description': 'Order food and interact with waiters',
      'phrases': ['Die Speisekarte bitte.', 'Ich hätte gerne...', 'Die Rechnung bitte.'],
    },
    {
      'title': 'Shopping',
      'description': 'Practice shopping conversations',
      'phrases': ['Wie viel kostet das?', 'Haben Sie das in Größe M?', 'Kann ich mit Karte zahlen?'],
    },
    {
      'title': 'Hotel Check-in',
      'description': 'Practice hotel interactions',
      'phrases': ['Ich habe eine Reservierung.', 'Wo ist mein Zimmer?', 'Kann ich den Zimmerservice haben?'],
    },
  ];

  int _currentScenarioIndex = 0;
  int _completedScenarios = 0;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _completedScenarios = prefs.getInt('completedScenarios') ?? 0;
    });
  }

  void _nextScenario() {
    setState(() {
      _currentScenarioIndex = (_currentScenarioIndex + 1) % _scenarios.length;
    });
  }

  void _completeScenario() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _completedScenarios++;
    });
    await prefs.setInt('completedScenarios', _completedScenarios);
    _nextScenario();
  }

  @override
  Widget build(BuildContext context) {
    final scenario = _scenarios[_currentScenarioIndex];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Mode'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Completed: $_completedScenarios'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      scenario['title'],
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(scenario['description']),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Useful Phrases:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: (scenario['phrases'] as List<String>).length,
                itemBuilder: (context, index) {
                  final phrase = scenario['phrases'][index];
                  return Card(
                    child: ListTile(
                      title: Text(phrase),
                      trailing: IconButton(
                        icon: const Icon(Icons.volume_up),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Playing: $phrase')),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _nextScenario,
                  child: const Text('Next Scenario'),
                ),
                ElevatedButton(
                  onPressed: _completeScenario,
                  child: const Text('Mark as Completed'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
