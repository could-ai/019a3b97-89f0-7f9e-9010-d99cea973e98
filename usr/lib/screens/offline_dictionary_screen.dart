import 'package:flutter/material.dart';

class OfflineDictionaryScreen extends StatefulWidget {
  const OfflineDictionaryScreen({super.key});

  @override
  State<OfflineDictionaryScreen> createState() => _OfflineDictionaryScreenState();
}

class _OfflineDictionaryScreenState extends State<OfflineDictionaryScreen> {
  final Map<String, List<String>> _dictionary = {
    'Greetings': ['Hallo - Hello', 'Guten Tag - Good day', 'Auf Wiedersehen - Goodbye'],
    'Food': ['Essen - Food', 'Wasser - Water', 'Brot - Bread', 'Milch - Milk'],
    'Numbers': ['Eins - One', 'Zwei - Two', 'Drei - Three', 'Vier - Four', 'Fünf - Five'],
    'Colors': ['Rot - Red', 'Blau - Blue', 'Grün - Green', 'Gelb - Yellow', 'Schwarz - Black'],
    'Family': ['Mutter - Mother', 'Vater - Father', 'Bruder - Brother', 'Schwester - Sister'],
  };

  String _searchQuery = '';
  String _selectedCategory = 'All';

  List<String> get _filteredPhrases {
    List<String> allPhrases = [];
    _dictionary.forEach((category, phrases) {
      if (_selectedCategory == 'All' || category == _selectedCategory) {
        allPhrases.addAll(phrases);
      }
    });

    if (_searchQuery.isEmpty) {
      return allPhrases;
    }

    return allPhrases.where((phrase) =>
      phrase.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offline Dictionary'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: const InputDecoration(
                hintText: 'Search phrases...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButton<String>(
              value: _selectedCategory,
              items: ['All', ..._dictionary.keys].map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedCategory = value!),
              isExpanded: true,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredPhrases.length,
              itemBuilder: (context, index) {
                final phrase = _filteredPhrases[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ListTile(
                    title: Text(phrase),
                    trailing: IconButton(
                      icon: const Icon(Icons.volume_up),
                      onPressed: () {
                        // In a real app, this would play TTS
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
        ],
      ),
    );
  }
}
