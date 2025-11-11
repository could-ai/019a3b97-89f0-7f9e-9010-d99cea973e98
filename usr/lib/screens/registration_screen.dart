import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedLanguageToLearn;
  String? _selectedProficiencyLevel;
  String? _selectedInterfaceLanguage;
  bool _isLoading = false;

  final List<String> _languages = ['German', 'English', 'Spanish', 'French', 'Italian'];
  final List<String> _proficiencyLevels = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];
  final List<String> _interfaceLanguages = ['English', 'Serbian', 'German'];

  Future<void> _completeRegistration() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Save user preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('languageToLearn', _selectedLanguageToLearn!);
      await prefs.setString('proficiencyLevel', _selectedProficiencyLevel!);
      await prefs.setString('interfaceLanguage', _selectedInterfaceLanguage!);
      await prefs.setBool('hasCompletedRegistration', true);

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome - Setup Your Learning'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 20),
                const Text(
                  'Choose your learning preferences:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Language to Learn',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.language),
                  ),
                  value: _selectedLanguageToLearn,
                  items: _languages.map((String language) {
                    return DropdownMenuItem<String>(
                      value: language,
                      child: Text(language),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedLanguageToLearn = newValue;
                    });
                  },
                  validator: (value) => value == null ? 'Please select a language' : null,
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Proficiency Level',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.school),
                  ),
                  value: _selectedProficiencyLevel,
                  items: _proficiencyLevels.map((String level) {
                    return DropdownMenuItem<String>(
                      value: level,
                      child: Text(level),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedProficiencyLevel = newValue;
                    });
                  },
                  validator: (value) => value == null ? 'Please select a level' : null,
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Interface Language',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.translate),
                  ),
                  value: _selectedInterfaceLanguage,
                  items: _interfaceLanguages.map((String language) {
                    return DropdownMenuItem<String>(
                      value: language,
                      child: Text(language),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedInterfaceLanguage = newValue;
                    });
                  },
                  validator: (value) => value == null ? 'Please select an interface language' : null,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _isLoading ? null : _completeRegistration,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Start Learning', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
