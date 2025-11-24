import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../config/constants.dart';
import '../models/chat_message.dart';
import '../widgets/chat_bubble.dart';

class ChatOverlay extends StatefulWidget {
  final bool isVisible;
  final VoidCallback onClose;
  final VoidCallback onMinimize;

  const ChatOverlay({
    super.key,
    required this.isVisible,
    required this.onClose,
    required this.onMinimize,
  });

  @override
  State<ChatOverlay> createState() => _ChatOverlayState();
}

class _ChatOverlayState extends State<ChatOverlay> with SingleTickerProviderStateMixin {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  bool _isMinimized = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    if (widget.isVisible) {
      _animationController.forward();
      _loadInitialMessages();
    }
  }

  void _loadInitialMessages() {
    setState(() {
      _messages.addAll([
        ChatMessage(
          id: '1',
          content: 'Hi! I\'m here to help. What can I assist you with?',
          sender: MessageSender.ai,
          timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
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
          duration: const Duration(milliseconds: 300),
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
      content: 'I understand you\'re asking about "$text". How can I help you with that?',
      sender: MessageSender.ai,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(aiMessage);
      _isLoading = false;
    });

    _scrollToBottom();
  }

  void _toggleMinimize() {
    setState(() {
      _isMinimized = !_isMinimized;
    });
    widget.onMinimize();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isVisible) return const SizedBox.shrink();

    return Positioned(
      right: 20,
      bottom: 20,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: _isMinimized ? 300 : 400,
            height: _isMinimized ? 60 : 500,
            child: _isMinimized ? _buildMinimizedView() : _buildExpandedView(),
          ),
        ),
      ),
    );
  }

  Widget _buildMinimizedView() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
      ),
      child: Material(
        color: AppColors.surface,
        child: InkWell(
          onTap: _toggleMinimize,
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.spacingM),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: AppColors.backgroundDark,
                    size: 20,
                  ),
                ),
                const SizedBox(width: AppConstants.spacingM),
                const Text(
                  'AI Assistant',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: AppConstants.fontSizeM,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: widget.onClose,
                  color: AppColors.textTertiary,
                  iconSize: AppConstants.iconSizeM,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedView() {
    return Card(
      elevation: 16,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingM),
            decoration: const BoxDecoration(
              color: AppColors.backgroundDarker,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppConstants.borderRadiusL),
                topRight: Radius.circular(AppConstants.borderRadiusL),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: AppColors.backgroundDark,
                    size: 20,
                  ),
                ),
                const SizedBox(width: AppConstants.spacingM),
                const Text(
                  'AI Assistant',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: AppConstants.fontSizeM,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.minimize),
                  onPressed: _toggleMinimize,
                  color: AppColors.textTertiary,
                  iconSize: AppConstants.iconSizeM,
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: widget.onClose,
                  color: AppColors.textTertiary,
                  iconSize: AppConstants.iconSizeM,
                ),
              ],
            ),
          ),

          // Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(AppConstants.spacingM),
              itemCount: _messages.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < _messages.length) {
                  return ChatBubble(message: _messages[index]);
                } else {
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

          // Input Area
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingM),
            decoration: const BoxDecoration(
              color: AppColors.backgroundDarker,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppConstants.borderRadiusL),
                bottomRight: Radius.circular(AppConstants.borderRadiusL),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                    ),
                    child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        hintText: 'Type your message...',
                        hintStyle: TextStyle(color: AppColors.textTertiary),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: AppConstants.spacingM,
                          vertical: AppConstants.spacingM,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                const SizedBox(width: AppConstants.spacingM),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _sendMessage,
                    color: AppColors.backgroundDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}