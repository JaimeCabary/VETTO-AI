class ChatMessage {
  final String id;
  final String content;
  final MessageSender sender;
  final DateTime timestamp;
  final List<MessageReaction> reactions;
  final bool isProcessing;
  final MessageType type;
  
  ChatMessage({
    required this.id,
    required this.content,
    required this.sender,
    required this.timestamp,
    this.reactions = const [],
    this.isProcessing = false,
    this.type = MessageType.text,
  });
}

enum MessageSender {
  user,
  ai,
  system,
}

enum MessageType {
  text,
  suggestion,
  workflow,
  template,
}

class MessageReaction {
  final String emoji;
  final int count;
  
  const MessageReaction({
    required this.emoji,
    this.count = 1,
  });
}