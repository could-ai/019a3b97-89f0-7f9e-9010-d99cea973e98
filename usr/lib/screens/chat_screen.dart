import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:couldai_user_app/services/chat_bot_service.dart';
import 'package:couldai_user_app/services/conversation_history_service.dart';
import 'package:couldai_user_app/services/difficulty_adapter.dart';
import 'package:couldai_user_app/services/progress_tracker.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final history = await ConversationHistoryService.getConversationHistory();
    if (mounted) {
      setState(() {
        // Map history to a format the UI can use.
        for (var conv in history) {
          if (conv['userMessage'] != null && conv['botResponse'] != null) {
            _messages.add({
              'user': conv['userMessage']!,
              'bot': conv['botResponse']!,
            });
          }
        }
      });
    }
  }

  Future<void> _sendMessage() async {
    if (_controller.text.isEmpty) return;

    final userMessage = _controller.text;
    

    setState(() {
      _isLoading = true;
      _messages.add({'user': userMessage, 'bot': '...'});
    });
     _controller.clear();

    try {
      final botResponse = await ChatBotService.generateResponse(userMessage);
      if(mounted){
        setState(() {
          _messages.last['bot'] = botResponse;
        });
      }
    } catch (e) {
      if(mounted){
        setState(() {
          _messages.last['bot'] = 'Error: Could not get response.';
        });
      }
    } finally {
      if(mounted){
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with Bot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        margin: const EdgeInsets.only(bottom: 8.0, left: 40.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(message['user'] ?? ''),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        margin: const EdgeInsets.only(bottom: 8.0, right: 40.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(message['bot'] ?? ''),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          if (_isLoading) const LinearProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
