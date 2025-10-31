import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _ttsEnabled = true;
  bool _notificationsEnabled = true;
  String _difficulty = 'Medium';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Text-to-Speech'),
            subtitle: const Text('Enable voice responses from the bot'),
            value: _ttsEnabled,
            onChanged: (value) => setState(() => _ttsEnabled = value),
          ),
          SwitchListTile(
            title: const Text('Notifications'),
            subtitle: const Text('Receive daily challenge reminders'),
            value: _notificationsEnabled,
            onChanged: (value) => setState(() => _notificationsEnabled = value),
          ),
          ListTile(
            title: const Text('Difficulty Level'),
            subtitle: Text('Current: $_difficulty'),
            trailing: DropdownButton<String>(
              value: _difficulty,
              items: ['Easy', 'Medium', 'Hard'].map((level) {
                return DropdownMenuItem(value: level, child: Text(level));
              }).toList(),
              onChanged: (value) => setState(() => _difficulty = value!),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Daily Challenges'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.pushNamed(context, '/challenges'),
          ),
          ListTile(
            title: const Text('Progress Report'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.pushNamed(context, '/progress'),
          ),
          ListTile(
            title: const Text('Offline Dictionary'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.pushNamed(context, '/dictionary'),
          ),
          ListTile(
            title: const Text('Travel Mode'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.pushNamed(context, '/travel'),
          ),
          const Divider(),
          ListTile(
            title: const Text('Logout'),
            trailing: const Icon(Icons.logout),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
