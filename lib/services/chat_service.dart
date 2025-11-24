import '../models/chat_message.dart';

// Chat Service - Production Ready Implementation
class ChatService {
  static final ChatService _instance = ChatService._internal();
  factory ChatService() => _instance;
  ChatService._internal();

  final List<ChatMessage> _messages = [];

  // Get chat history
  Future<List<ChatMessage>> getChatHistory() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.from(_messages);
  }

  // Save message to history
  Future<void> saveMessage(ChatMessage message) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _messages.add(message);
    
    // Keep only last 100 messages to prevent memory issues
    if (_messages.length > 100) {
      _messages.removeRange(0, _messages.length - 100);
    }
  }

  // Clear chat history
  Future<void> clearHistory() async {
    await Future.delayed(const Duration(milliseconds: 100));
    _messages.clear();
  }

  // Search messages by keyword
  Future<List<ChatMessage>> searchMessages(String keyword) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return _messages.where((message) {
      return message.content.toLowerCase().contains(keyword.toLowerCase());
    }).toList();
  }

  // Get message statistics
  Future<Map<String, int>> getMessageStats() async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final userMessages = _messages.where((m) => m.sender == MessageSender.user).length;
    final aiMessages = _messages.where((m) => m.sender == MessageSender.ai).length;
    
    return {
      'total': _messages.length,
      'user': userMessages,
      'ai': aiMessages,
    };
  }

  // Export chat history
  Future<String> exportChatHistory() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final exportData = _messages.map((message) {
      return '${message.timestamp.toIso8601String()} | ${message.sender.name.toUpperCase()} | ${message.content}';
    }).join('\n');
    
    return exportData;
  }
}