import 'package:flutter/material.dart';
import 'package:vetto_ai/models/chat_message.dart';
import 'package:vetto_ai/widgets/glass_card.dart';
import 'package:vetto_ai/widgets/vetto_scaffold.dart';

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
    // Add delays for a "streaming" entrance effect
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() {
        _messages.add(
          ChatMessage(
            id: '1',
            content: 'Hello! I\'m Vetto AI. How can I help you today?',
            sender: MessageSender.ai,
            timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
          ),
        );
      });
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      if (!mounted) return;
      setState(() {
        _messages.add(
           ChatMessage(
            id: '2',
            content: 'Can you help me create a workflow for data processing?',
            sender: MessageSender.user,
            timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
          ),
        );
      });
    });

    Future.delayed(const Duration(milliseconds: 2000), () {
       if (!mounted) return;
       setState(() {
         _messages.add(
           ChatMessage(
            id: '3',
            content: 'I\'d be happy to help! What kind of data are you working with?',
            sender: MessageSender.ai,
            timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
          ),
         );
       });
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
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

    // Simulate AI thinking time
    await Future.delayed(const Duration(milliseconds: 1500));

    final aiMessage = ChatMessage(
      id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
      content: _generateAIResponse(text),
      sender: MessageSender.ai,
      timestamp: DateTime.now(),
    );

    if (mounted) {
      setState(() {
        _messages.add(aiMessage);
        _isLoading = false;
      });
      _scrollToBottom();
    }
  }

  String _generateAIResponse(String userMessage) {
    final responses = [
      'That is a great insight about "$userMessage". Let\'s explore that further.',
      'I can certainly assist with "$userMessage". Here is what I found...',
      'Optimization suggested: I can create an automated workflow for that.',
      'Interesting. Have you considered using a template for this?',
    ];
    return responses[DateTime.now().millisecondsSinceEpoch % responses.length];
  }

  @override
  Widget build(BuildContext context) {
    return VettoScaffold(
      body: Column(
        children: [
          // --- 1. Glass Header ---
          _buildHeader(),

          // --- 2. Messages List ---
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              itemCount: _messages.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < _messages.length) {
                  return _buildMessageBubble(_messages[index]);
                } else {
                  return _buildTypingIndicator();
                }
              },
            ),
          ),

          // --- 3. Floating Glass Input ---
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: Icon(Icons.auto_awesome, color: Color(0xFF6A7B66), size: 20),
              ),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vetto Assistant',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Online • Ready to help',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    final isUser = message.sender == MessageSender.user;
    
    // Message Entrance Animation
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
        ),
              decoration: BoxDecoration(
            // User: Solid Gradient | AI: Glass
            gradient: isUser 
                ? const LinearGradient(
                    colors: [Color(0xFF8DA385), Color(0xFF6A7B66)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ) 
                : null,
            color: isUser ? null : Colors.white.withValues(alpha: 0.1),
            border: isUser ? null : Border.all(color: Colors.white.withValues(alpha: 0.2)),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
              bottomLeft: Radius.circular(isUser ? 20 : 4),
              bottomRight: Radius.circular(isUser ? 4 : 20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.content,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: GlassCard(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        borderRadius: 20,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 12, 
              height: 12, 
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)
            ),
            const SizedBox(width: 10),
            Text(
              'Vetto is thinking...',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        borderRadius: 30,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () {},
            ),
            Expanded(
              child: TextField(
                controller: _textController,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: 'Ask Vetto anything...',
                  hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white, // High contrast send button
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_upward, color: Color(0xFF2F3A2F), size: 20),
                onPressed: _sendMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}