import 'package:flutter/material.dart';

class AIAssistantScreen extends StatefulWidget {
  const AIAssistantScreen({super.key});

  @override
  State<AIAssistantScreen> createState() => _AIAssistantScreenState();
}

class _AIAssistantScreenState extends State<AIAssistantScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel AI Assistant'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          if (_isTyping)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(width: 8),
                  Text('AI is typing...'),
                ],
              ),
            ),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildMessage(ChatMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: message.isUser ? Colors.red : Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: TextStyle(
                color: message.isUser ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message.time,
              style: TextStyle(
                fontSize: 12,
                color: message.isUser ? Colors.white70 : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Ask me anything about travel...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              onSubmitted: _handleSubmitted,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.send),
            color: Colors.red,
            onPressed: () => _handleSubmitted(_messageController.text),
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    final userMessage = ChatMessage(
      text: text,
      isUser: true,
      time: _getCurrentTime(),
    );

    setState(() {
      _messages.add(userMessage);
      _messageController.clear();
      _isTyping = true;
    });

    // Simulate AI response
    Future.delayed(const Duration(seconds: 1), () {
      final aiResponse = _getAIResponse(text);
      final aiMessage = ChatMessage(
        text: aiResponse,
        isUser: false,
        time: _getCurrentTime(),
      );

      setState(() {
        _messages.add(aiMessage);
        _isTyping = false;
      });
    });
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
  }

  String _getAIResponse(String userMessage) {
    final message = userMessage.toLowerCase();
    
    if (message.contains('hello') || message.contains('hi')) {
      return 'Hello! How can I help you with your travel plans today?';
    } else if (message.contains('weather')) {
      return 'I can help you check the weather for your destination. Please specify which city you\'re interested in.';
    } else if (message.contains('hotel') || message.contains('accommodation')) {
      return 'I can help you find the perfect accommodation. What type of hotel are you looking for? Budget, luxury, or something in between?';
    } else if (message.contains('flight') || message.contains('airline')) {
      return 'I can assist you with flight information. Please let me know your departure and destination cities.';
    } else if (message.contains('visa') || message.contains('passport')) {
      return 'I can provide information about visa requirements. Which country\'s visa information do you need?';
    } else if (message.contains('currency') || message.contains('money')) {
      return 'I can help you with currency conversion and money matters. What specific information do you need?';
    } else if (message.contains('tour') || message.contains('attraction')) {
      return 'I can suggest popular attractions and tours. Which destination are you interested in?';
    } else if (message.contains('food') || message.contains('restaurant')) {
      return 'I can recommend local restaurants and cuisine. What type of food are you interested in?';
    } else if (message.contains('transport') || message.contains('travel')) {
      return 'I can help you with local transportation options. Which city\'s transportation system would you like to know about?';
    } else if (message.contains('thank')) {
      return 'You\'re welcome! Is there anything else I can help you with?';
    } else {
      return 'I\'m here to help with your travel needs! You can ask me about:\n\n'
          '• Weather information\n'
          '• Hotel bookings\n'
          '• Flight details\n'
          '• Visa requirements\n'
          '• Currency conversion\n'
          '• Local attractions\n'
          '• Restaurant recommendations\n'
          '• Transportation options\n\n'
          'What would you like to know?';
    }
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final String time;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.time,
  });
} 