// // import 'package:flutter/material.dart';
// // import 'package:uruella_ai/config/app_colors.dart';
// // import 'package:uruella_ai/config/constants.dart';
// // import 'package:uruella_ai/models/chat_message.dart';
// // import 'package:uruella_ai/utils/animations.dart';

// // class ChatBubble extends StatefulWidget {
// //   final ChatMessage message;
// //   final VoidCallback? onReaction;
// //   final bool showReactions;
  
// //   const ChatBubble({
// //     super.key,
// //     required this.message,
// //     this.onReaction,
// //     this.showReactions = true,
// //   });
  
// //   @override
// //   State<ChatBubble> createState() => _ChatBubbleState();
// // }

// // class _ChatBubbleState extends State<ChatBubble> 
// //     with SingleTickerProviderStateMixin {
// //   late AnimationController _animationController;
// //   late Animation<double> _scaleAnimation;
// //   late Animation<double> _fadeAnimation;
  
// //   @override
// //   void initState() {
// //     super.initState();
// //     _animationController = AnimationController(
// //       duration: AppAnimations.medium,
// //       vsync: this,
// //     );
// //     _scaleAnimation = Tween<double>(
// //       begin: 0.8,
// //       end: 1.0,
// //     ).animate(CurvedAnimation(
// //       parent: _animationController,
// //       curve: AppAnimations.easeOutBack,
// //     ));
// //     _fadeAnimation = Tween<double>(
// //       begin: 0.0,
// //       end: 1.0,
// //     ).animate(CurvedAnimation(
// //       parent: _animationController,
// //       curve: Curves.easeIn,
// //     ));
    
// //     _animationController.forward();
// //   }
  
// //   @override
// //   void dispose() {
// //     _animationController.dispose();
// //     super.dispose();
// //   }
  
// //   bool get _isUserMessage => widget.message.sender == MessageSender.user;
// //   bool get _isAiMessage => widget.message.sender == MessageSender.ai;
  
// //   Color _getBubbleColor() {
// //     switch (widget.message.sender) {
// //       case MessageSender.user:
// //         return AppColors.neonPurple.withValues(alpha:0.3);
// //       case MessageSender.ai:
// //         return AppColors.surface;
// //       case MessageSender.system:
// //         return AppColors.oliveGold.withValues(alpha:0.2);
// //     }
// //   }
  
// //   Color _getTextColor() {
// //     switch (widget.message.sender) {
// //       case MessageSender.user:
// //         return AppColors.textPrimary;
// //       case MessageSender.ai:
// //         return AppColors.textPrimary;
// //       case MessageSender.system:
// //         return AppColors.oliveGold;
// //     }
// //   }
  
  
// //   @override
// //   Widget build(BuildContext context) {
// //     return ScaleTransition(
// //       scale: _scaleAnimation,
// //       child: FadeTransition(
// //         opacity: _fadeAnimation,
// //         child: Container(
// //           margin: const EdgeInsets.symmetric(vertical: AppConstants.spacingS),
// //           child: Row(
// //             mainAxisAlignment: _isUserMessage 
// //                 ? MainAxisAlignment.end 
// //                 : MainAxisAlignment.start,
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               if (_isAiMessage) ...[
// //                 _buildAiIcon(),
// //                 const SizedBox(width: AppConstants.spacingS),
// //               ],
// //               Expanded(
// //                 child: Column(
// //                   crossAxisAlignment: _isUserMessage 
// //                       ? CrossAxisAlignment.end 
// //                       : CrossAxisAlignment.start,
// //                   children: [
// //                     Card(
// //                       elevation: 2,
// //                       child: Container(
// //                         padding: const EdgeInsets.all(AppConstants.spacingM),
// //                         decoration: BoxDecoration(
// //                           color: _getBubbleColor(),
// //                           borderRadius: BorderRadius.only(
// //                             topLeft: Radius.circular(_isUserMessage 
// //                                 ? AppConstants.borderRadiusL 
// //                                 : AppConstants.borderRadiusS),
// //                             topRight: Radius.circular(_isUserMessage 
// //                                 ? AppConstants.borderRadiusS 
// //                                 : AppConstants.borderRadiusL),
// //                             bottomLeft: const Radius.circular(AppConstants.borderRadiusL),
// //                             bottomRight: const Radius.circular(AppConstants.borderRadiusL),
// //                           ),
// //                         ),
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             if (widget.message.isProcessing)
// //                               _buildTypingIndicator()
// //                             else
// //                               Text(
// //                                 widget.message.content,
// //                                 style: TextStyle(
// //                                   color: _getTextColor(),
// //                                   fontSize: AppConstants.fontSizeM,
// //                                 ),
// //                               ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
                    
// //                     if (widget.showReactions && widget.message.reactions.isNotEmpty)
// //                       _buildReactions(),
                    
// //                     const SizedBox(height: AppConstants.spacingXS),
                    
// //                     Text(
// //                       _formatTime(widget.message.timestamp),
// //                       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
// //                         color: AppColors.textTertiary,
// //                         fontSize: AppConstants.fontSizeXS,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               if (_isUserMessage) ...[
// //                 const SizedBox(width: AppConstants.spacingS),
// //                 _buildUserIcon(),
// //               ],
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
  
// //   Widget _buildAiIcon() {
// //     return Container(
// //       width: 32,
// //       height: 32,
// //       decoration: const BoxDecoration(
// //         gradient: AppColors.primaryGradient,
// //         shape: BoxShape.circle,
// //       ),
// //       child: const Icon(
// //         Icons.auto_awesome,
// //         color: AppColors.backgroundDark,
// //         size: AppConstants.iconSizeS,
// //       ),
// //     );
// //   }
  
// //   Widget _buildUserIcon() {
// //     return Container(
// //       width: 32,
// //       height: 32,
// //       decoration: const BoxDecoration(
// //         color: AppColors.neonPurple,
// //         shape: BoxShape.circle,
// //       ),
// //       child: const Icon(
// //         Icons.person,
// //         color: AppColors.backgroundDark,
// //         size: AppConstants.iconSizeS,
// //       ),
// //     );
// //   }
  
// //   Widget _buildTypingIndicator() {
// //     return const Row(
// //       mainAxisSize: MainAxisSize.min,
// //       children: [
// //         SizedBox(
// //           width: 20,
// //           height: 20,
// //           child: CircularProgressIndicator(
// //             strokeWidth: 2,
// //             valueColor: AlwaysStoppedAnimation(AppColors.neonCyan),
// //           ),
// //         ),
// //         SizedBox(width: AppConstants.spacingM),
// //         Text(
// //           'AI is thinking...',
// //           style: TextStyle(
// //             color: AppColors.textSecondary,
// //             fontStyle: FontStyle.italic,
// //           ),
// //         ),
// //       ],
// //     );
// //   }
  
// //   Widget _buildReactions() {
// //     return Padding(
// //       padding: const EdgeInsets.only(top: AppConstants.spacingS),
// //       child: Wrap(
// //         spacing: AppConstants.spacingXS,
// //         children: widget.message.reactions.map((reaction) {
// //           return GestureDetector(
// //             onTap: widget.onReaction,
// //             child: Card(
// //               elevation: 1,
// //               child: Container(
// //                 padding: const EdgeInsets.symmetric(
// //                   horizontal: AppConstants.spacingS,
// //                   vertical: AppConstants.spacingXS,
// //                 ),
// //                 child: Row(
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: [
// //                     Text(reaction.emoji),
// //                     const SizedBox(width: AppConstants.spacingXS),
// //                     Text(
// //                       reaction.count.toString(),
// //                       style: const TextStyle(
// //                         color: AppColors.textSecondary,
// //                         fontSize: AppConstants.fontSizeXS,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           );
// //         }).toList(),
// //       ),
// //     );
// //   }
  
// //   String _formatTime(DateTime timestamp) {
// //     return '${timestamp.hour.toString().padLeft(2, '0')}:'
// //            '${timestamp.minute.toString().padLeft(2, '0')}';
// //   }
// // }



// import 'package:flutter/material.dart';
// import 'package:uruella_ai/models/chat_message.dart';

// class ChatBubble extends StatelessWidget {
//   final ChatMessage message;
//   final VoidCallback? onReaction;
//   final bool showReactions;
  
//   const ChatBubble({
//     super.key,
//     required this.message,
//     this.onReaction,
//     this.showReactions = true,
//   });
  
//   bool get _isUserMessage => message.sender == MessageSender.user;
  
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: _isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           if (!_isUserMessage) _buildAiAvatar(),
          
//           const SizedBox(width: 8),
          
//           Flexible(
//             child: Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 // User: Green Gradient | AI: Glass
//                 gradient: _isUserMessage 
//                     ? const LinearGradient(
//                         colors: [Color(0xFF8DA385), Color(0xFF6A7B66)],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ) 
//                     : null,
//                 color: _isUserMessage ? null : Colors.white.withValues(alpha: 0.1),
                
//                 // Border for AI only (Glass effect)
//                 border: _isUserMessage 
//                     ? null 
//                     : Border.all(color: Colors.white.withValues(alpha: 0.2)),
                
//                 borderRadius: BorderRadius.only(
//                   topLeft: const Radius.circular(20),
//                   topRight: const Radius.circular(20),
//                   bottomLeft: Radius.circular(_isUserMessage ? 20 : 4),
//                   bottomRight: Radius.circular(_isUserMessage ? 4 : 20),
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   if (message.isProcessing)
//                     _buildTypingIndicator()
//                   else
//                     Text(
//                       message.content,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 15,
//                         height: 1.4,
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
          
//           if (_isUserMessage) const SizedBox(width: 8),
//         ],
//       ),
//     );
//   }
  
//   Widget _buildAiAvatar() {
//     return Container(
//       width: 32,
//       height: 32,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         shape: BoxShape.circle,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.1),
//             blurRadius: 4,
//           ),
//         ],
//       ),
//       child: const Icon(
//         Icons.auto_awesome,
//         color: Color(0xFF6A7B66), // Vetto Green
//         size: 16,
//       ),
//     );
//   }
  
//   Widget _buildTypingIndicator() {
//     return SizedBox(
//       width: 40,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: List.generate(3, (index) => 
//           Container(
//             width: 6,
//             height: 6,
//             decoration: BoxDecoration(
//               color: Colors.white.withValues(alpha: 0.6),
//               shape: BoxShape.circle,
//             ),
//           )
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:uruella_ai/models/chat_message.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final VoidCallback? onReaction;
  final bool showReactions;
  
  const ChatBubble({
    super.key,
    required this.message,
    this.onReaction,
    this.showReactions = true,
  });
  
  bool get _isUserMessage => message.sender == MessageSender.user;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        // User on Right, AI on Left
        mainAxisAlignment: _isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                // User: Green Gradient | AI: Glass (shows mascot behind it)
                gradient: _isUserMessage 
                    ? const LinearGradient(
                        colors: [Color(0xFF8DA385), Color(0xFF6A7B66)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ) 
                    : null,
                color: _isUserMessage ? null : Colors.white.withValues(alpha: 0.1),
                
                // Border for AI only (Glass effect definition)
                border: _isUserMessage 
                    ? null 
                    : Border.all(color: Colors.white.withValues(alpha: 0.2)),
                
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(_isUserMessage ? 20 : 4),
                  bottomRight: Radius.circular(_isUserMessage ? 4 : 20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (message.isProcessing)
                    _buildTypingIndicator()
                  else
                    Text(
                      message.content,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        height: 1.4,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTypingIndicator() {
    return SizedBox(
      width: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(3, (index) => 
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.6),
              shape: BoxShape.circle,
            ),
          )
        ),
      ),
    );
  }
}