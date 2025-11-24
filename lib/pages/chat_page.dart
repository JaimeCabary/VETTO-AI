
import 'package:flutter/material.dart';
import 'package:vetto_ai/config/app_colors.dart';
import 'package:vetto_ai/config/constants.dart';
import 'package:vetto_ai/models/chat_message.dart';
import 'package:vetto_ai/utils/animations.dart';
import 'package:vetto_ai/widgets/chat_bubble.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  
  @override
  void initState() {
    super.initState();
    _loadInitialMessages();
  }
  
  void _loadInitialMessages() {
    setState(() {
      _messages.addAll([
        ChatMessage(
          id: '1',
          content: 'Hello! I\'m Vetto AI. How can I help you today?',
          sender: MessageSender.ai,
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        ),
        ChatMessage(
          id: '2',
          content: 'Can you help me create a workflow for data processing?',
          sender: MessageSender.user,
          timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
        ),
        ChatMessage(
          id: '3',
          content: 'I\'d be happy to help you set up a data processing workflow! What kind of data are you working with?',
          sender: MessageSender.ai,
          timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
        ),
      ]);
    });
    _scrollToBottom();
  }
  
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: AppAnimations.medium,
          curve: Curves.easeOut,
        );
      }
    });
  }
  
  void _sendMessage() async {
    final text = _textController.text.trim();
    if (text.isEmpty) return;
    
    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: text,
      sender: MessageSender.user,
      timestamp: DateTime.now(),
    );
    
    setState(() {
      _messages.add(userMessage);
      _textController.clear();
      _isLoading = true;
    });
    
    _scrollToBottom();
    
    // Simulate AI response
    await Future.delayed(const Duration(seconds: 1));
    
    final aiMessage = ChatMessage(
      id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
      content: _generateAIResponse(text),
      sender: MessageSender.ai,
      timestamp: DateTime.now(),
    );
    
    setState(() {
      _messages.add(aiMessage);
      _isLoading = false;
    });
    
    _scrollToBottom();
  }
  
  String _generateAIResponse(String userMessage) {
    final responses = [
      'I understand you\'re asking about $userMessage. Let me help you with that.',
      'That\'s an interesting question about $userMessage. Here\'s what I suggest...',
      'Based on your query about $userMessage, I recommend the following approach...',
      'I can help you with $userMessage. Let me create a workflow for that.',
    ];
    return responses[DateTime.now().millisecondsSinceEpoch % responses.length];
  }
  
  void _addReaction(ChatMessage message) {
    // Implementation for adding reactions
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingL,
                vertical: AppConstants.spacingM,
              ),
              decoration: BoxDecoration(
                color: AppColors.backgroundDarker,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      shape: BoxShape.circle,
                      boxShadow: AppColors.neonGlow(AppColors.neonCyan),
                    ),
                    child: const Icon(
                      Icons.auto_awesome,
                      color: AppColors.backgroundDark,
                      size: AppConstants.iconSizeM,
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingM),
                  Text(
                    'Vetto AI Assistant',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.more_vert,
                      color: AppColors.neonCyan,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            
            // Messages
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(AppConstants.spacingL),
                itemCount: _messages.length + (_isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < _messages.length) {
                    final message = _messages[index];
                    return ChatBubble(
                      message: message,
                      onReaction: () => _addReaction(message),
                    );
                  } else {
                    // Typing indicator
                    return ChatBubble(
                      message: ChatMessage(
                        id: 'typing',
                        content: '',
                        sender: MessageSender.ai,
                        timestamp: DateTime.now(),
                        isProcessing: true,
                      ),
                    );
                  }
                },
              ),
            ),
            
            // Input area
            Container(
              padding: const EdgeInsets.all(AppConstants.spacingL),
              decoration: BoxDecoration(
                color: AppColors.backgroundDarker,
                border: Border(
                  top: BorderSide(
                    color: AppColors.surface.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
                        boxShadow: AppColors.neonGlow(AppColors.neonCyan),
                      ),
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          hintText: 'Type your message...',
                          hintStyle: const TextStyle(
                            color: AppColors.textTertiary,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppConstants.spacingL,
                            vertical: AppConstants.spacingM,
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.emoji_emotions,
                              color: AppColors.neonCyan,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingM),
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
                      boxShadow: AppColors.neonGlow(AppColors.neonCyan),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: AppColors.backgroundDark,
                      ),
                      onPressed: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}