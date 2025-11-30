// // import 'dart:async';
// // import 'dart:io';
// // import 'dart:ui';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:file_picker/file_picker.dart';
// // import 'package:flutter_svg/svg.dart';
// // import 'package:speech_to_text/speech_to_text.dart' as stt;
// // import 'package:permission_handler/permission_handler.dart';
// // import 'package:uruella_ai/models/chat_message.dart';
// // import 'package:uruella_ai/services/ai_service.dart';
// // import 'package:uruella_ai/services/offline_storage_service.dart';
// // import 'package:uruella_ai/widgets/glass_card.dart';

// // class ChatPage extends StatefulWidget {
// //   const ChatPage({super.key});

// //   @override
// //   State<ChatPage> createState() => _ChatPageState();
// // }

// // class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
// //   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
// //   List<ChatMessage> _messages = [];
// //   final List<Map<String, String>> _apiHistory = []; 
  
// //   final TextEditingController _textController = TextEditingController();
// //   final ScrollController _scrollController = ScrollController();
// //   final AIService _aiService = AIService();
// //   final OfflineStorageService _storageService = OfflineStorageService();
  
// //   // Voice Input
// //   final stt.SpeechToText _speech = stt.SpeechToText();
// //   bool _isListening = false;

// //   bool _isLoading = false;
// //   String _currentChatTitle = "New Chat";
  
// //   late AnimationController _bgController;
// //   late Animation<double> _doodleMoveAnimation;

// //   @override
// //   void initState() {
// //     super.initState();
    
// //     _bgController = AnimationController(
// //       duration: const Duration(seconds: 6),
// //       vsync: this,
// //     )..repeat(reverse: true);
    
// //     _doodleMoveAnimation = Tween<double>(begin: -10.0, end: 10.0).animate(
// //       CurvedAnimation(parent: _bgController, curve: Curves.easeInOut),
// //     );

// //     _initServices();
// //   }

// //   Future<void> _initServices() async {
// //     await _aiService.initialize();
// //     await _storageService.initialize();
// //     if (mounted) {
// //       _loadPersistedChat(); 
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     _bgController.dispose();
// //     _textController.dispose();
// //     _scrollController.dispose();
// //     super.dispose();
// //   }

// //   // --- PERSISTENCE ---

// //   Future<void> _loadPersistedChat() async {
// //     // 1. Load Messages
// //     final savedMessages = await _storageService.getChatMessages();
// //     // 2. Load Title
// //     final savedTitle = await _storageService.getData('chat_title');
    
// //     if (!mounted) return;

// //     if (savedMessages.isNotEmpty) {
// //       setState(() {
// //         // Restore Title
// //         if (savedTitle != null && savedTitle is String) {
// //           _currentChatTitle = savedTitle;
// //         }

// //         _messages = savedMessages.map((m) {
// //           return ChatMessage(
// //             id: m['id'] ?? DateTime.now().toString(),
// //             content: m['content'] ?? '',
// //             sender: m['sender'] == 'user' ? MessageSender.user : MessageSender.ai,
// //             timestamp: DateTime.parse(m['timestamp'] ?? DateTime.now().toIso8601String()),
// //           );
// //         }).toList();
        
// //         _apiHistory.clear();
// //         for (var msg in _messages) {
// //           _apiHistory.add({
// //             'role': msg.sender == MessageSender.user ? 'user' : 'model',
// //             'content': msg.content
// //           });
// //         }
// //       });
      
// //       // Scroll to bottom after rendering
// //       Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
// //     } else {
// //       // Only load welcome message if truly empty
// //       _loadWelcomeMessage();
// //     }
// //   }

// //   Future<void> _saveChat() async {
// //     // Save Messages
// //     final messagesToSave = _messages.map((m) => {
// //       'id': m.id,
// //       'content': m.content,
// //       'sender': m.sender == MessageSender.user ? 'user' : 'ai',
// //       'timestamp': m.timestamp.toIso8601String(),
// //     }).toList();
    
// //     await _storageService.saveChatMessages(messagesToSave);
    
// //     // Save Title
// //     await _storageService.saveData('chat_title', _currentChatTitle);
// //   }

// //   void _loadWelcomeMessage() {
// //     if (_messages.isNotEmpty) return;
// //     if (mounted) {
// //       setState(() {
// //         _messages.add(ChatMessage(
// //           id: 'init',
// //           content: 'Hello! I\'m Uruella AI. Ready to build. What\'s the task?',
// //           sender: MessageSender.ai,
// //           timestamp: DateTime.now(),
// //         ));
// //       });
// //     }
// //   }

// //   void _scrollToBottom() {
// //     if (_scrollController.hasClients) {
// //       _scrollController.animateTo(
// //         _scrollController.position.maxScrollExtent + 100, // Add offset to ensure bottom
// //         duration: const Duration(milliseconds: 300),
// //         curve: Curves.easeOut,
// //       );
// //     }
// //   }

// //   // --- ACTIONS ---

// //   void _handleNewChat() async {
// //     await _storageService.clearChat();
// //     // Clear title storage too
// //     await _storageService.saveData('chat_title', "New Chat");

// //     if (!mounted) return;
    
// //     setState(() {
// //       _messages.clear();
// //       _apiHistory.clear();
// //       _currentChatTitle = "New Chat";
// //       _isLoading = false;
// //     });
    
// //     _loadWelcomeMessage();
    
// //     if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
// //       Navigator.of(context).pop();
// //     }
// //   }

// //   Future<void> _handleFileUpload() async {
// //     try {
// //       await Permission.storage.request();
      
// //       FilePickerResult? result = await FilePicker.platform.pickFiles();

// //       if (result != null && result.files.single.path != null) {
// //         File file = File(result.files.single.path!);
// //         String fileName = result.files.single.name;
        
// //         if (!mounted) return;

// //         // 1. Show user file message
// //         final fileMsg = ChatMessage(
// //           id: DateTime.now().millisecondsSinceEpoch.toString(),
// //           content: "📎 Uploaded File: $fileName",
// //           sender: MessageSender.user,
// //           timestamp: DateTime.now(),
// //         );

// //         setState(() {
// //           _messages.add(fileMsg);
// //           _isLoading = true;
// //         });
// //         _scrollToBottom();
// //         _saveChat();

// //         // 2. Read Content
// //         String fileContent = "[Binary File]";
// //         try {
// //            fileContent = await file.readAsString();
// //         } catch (e) {
// //            fileContent = "[Image/Binary Data - Text analysis skipped]";
// //         }

// //         // 3. Process with AI
// //         final prompt = "I have uploaded a file named '$fileName'. Content:\n\n$fileContent\n\nPlease analyze this.";
// //         _apiHistory.add({'role': 'user', 'content': prompt});
        
// //         final responseText = await _aiService.processMessage(prompt, history: _apiHistory);

// //         if (mounted) {
// //           final aiMsg = ChatMessage(
// //             id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
// //             content: responseText,
// //             sender: MessageSender.ai,
// //             timestamp: DateTime.now(),
// //           );

// //           setState(() {
// //             _messages.add(aiMsg);
// //             _apiHistory.add({'role': 'model', 'content': responseText});
// //             _isLoading = false;
// //           });
// //           _scrollToBottom();
// //           _saveChat();
// //         }
// //       }
// //     } catch (e) {
// //       if (mounted) {
// //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //           content: Text("File Error: $e"),
// //           backgroundColor: Colors.redAccent,
// //         ));
// //       }
// //     }
// //   }

// //   void _handleVoiceInput() async {
// //     // Ensure permissions
// //     var status = await Permission.microphone.request();
// //     if (status.isDenied) {
// //        if (mounted) {
// //          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
// //            content: Text("Microphone permission denied"),
// //            backgroundColor: Colors.redAccent,
// //          ));
// //        }
// //        return;
// //     }

// //     if (!_isListening) {
// //       bool available = await _speech.initialize(
// //         onStatus: (status) => debugPrint('Voice Status: $status'),
// //         onError: (errorNotification) => debugPrint('Voice Error: $errorNotification'),
// //       );

// //       if (!mounted) return;

// //       if (available) {
// //         setState(() => _isListening = true);
// //         _speech.listen(
// //           onResult: (result) {
// //             setState(() {
// //               _textController.text = result.recognizedWords;
// //             });
// //           },
// //         );
// //       } else {
// //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
// //           content: Text("Speech recognition unavailable"),
// //           backgroundColor: Colors.redAccent,
// //         ));
// //       }
// //     } else {
// //       setState(() => _isListening = false);
// //       _speech.stop();
// //     }
// //   }

// //   void _openExpandedInput() {
// //     Navigator.of(context).push(PageRouteBuilder(
// //       pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
// //         backgroundColor: const Color(0xFF121212), // Match app background
// //         appBar: AppBar(
// //           backgroundColor: Colors.transparent,
// //           elevation: 0,
// //           leading: IconButton(
// //             icon: const Icon(Icons.close, color: Colors.white70),
// //             onPressed: () => Navigator.pop(context),
// //           ),
// //           actions: [
// //             Padding(
// //               padding: const EdgeInsets.only(right: 16.0),
// //               child: TextButton(
// //                 onPressed: () {
// //                   Navigator.pop(context);
// //                   if (_textController.text.isNotEmpty) _sendMessage();
// //                 },
// //                 style: TextButton.styleFrom(
// //                   backgroundColor: Colors.white,
// //                   foregroundColor: Colors.black,
// //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// //                 ),
// //                 child: const Text("Send", style: TextStyle(fontWeight: FontWeight.bold)),
// //               ),
// //             )
// //           ],
// //         ),
// //         body: Container(
// //           width: double.infinity,
// //           height: double.infinity,
// //           padding: const EdgeInsets.all(24),
// //           child: TextField(
// //             controller: _textController,
// //             maxLines: null,
// //             autofocus: true,
// //             style: const TextStyle(
// //               color: Colors.white, 
// //               fontSize: 18, 
// //               height: 1.6, 
// //               fontWeight: FontWeight.w400
// //             ),
// //             cursorColor: Colors.white,
// //             decoration: const InputDecoration(
// //               hintText: "Type your full prompt here...",
// //               hintStyle: TextStyle(color: Colors.white24),
// //               border: InputBorder.none,
// //             ),
// //           ),
// //         ),
// //       ),
// //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
// //         return SlideTransition(
// //           position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(animation),
// //           child: child,
// //         );
// //       },
// //     ));
// //   }

// //   void _sendMessage() async {
// //     final text = _textController.text.trim();
// //     if (text.isEmpty) return;

// //     final userMessage = ChatMessage(
// //       id: DateTime.now().millisecondsSinceEpoch.toString(),
// //       content: text,
// //       sender: MessageSender.user,
// //       timestamp: DateTime.now(),
// //     );

// //     // Only summarize if it's the FIRST user message (excluding welcome msg)
// //     if (_messages.length <= 1) {
// //       _aiService.summarizeChat(text).then((title) {
// //         if (mounted) {
// //           setState(() => _currentChatTitle = title);
// //           _saveChat(); // Save new title immediately
// //         }
// //       });
// //     }

// //     setState(() {
// //       _messages.add(userMessage);
// //       _apiHistory.add({'role': 'user', 'content': text});
// //       _textController.clear();
// //       _isLoading = true;
// //     });

// //     _scrollToBottom();
// //     _saveChat();

// //     final responseText = await _aiService.processMessage(text, history: _apiHistory);

// //     if (mounted) {
// //       final aiMessage = ChatMessage(
// //         id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
// //         content: responseText,
// //         sender: MessageSender.ai,
// //         timestamp: DateTime.now(),
// //       );

// //       setState(() {
// //         _messages.add(aiMessage);
// //         _apiHistory.add({'role': 'model', 'content': responseText});
// //         _isLoading = false;
// //       });
// //       _scrollToBottom();
// //       _saveChat();
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       key: _scaffoldKey,
// //       backgroundColor: const Color(0xFF121212), // Premium Matte Charcoal
// //       extendBodyBehindAppBar: true,
// //       drawer: _buildGlassSidebar(), 
// //       body: Stack(
// //         children: [
// //           _buildBackground(),
// //           _buildFloatingDoodles(),
// //           // Global Blur
// //           BackdropFilter(
// //             filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
// //             child: Container(color: Colors.transparent),
// //           ),
// //           SafeArea(
// //             child: Column(
// //               children: [
// //                 _buildHeader(), 
// //                 Expanded(
// //                   child: Stack(
// //                     children: [
// //                       // The List
// //                       ListView.builder(
// //                         controller: _scrollController,
// //                         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
// //                         itemCount: _messages.length + (_isLoading ? 1 : 0),
// //                         itemBuilder: (context, index) {
// //                           if (index < _messages.length) {
// //                             return _buildMessageRow(_messages[index]);
// //                           } else {
// //                             return _buildTypingIndicatorRow();
// //                           }
// //                         },
// //                       ),
                      
// //                       // Removed Suggestions Block here
// //                     ],
// //                   ),
// //                 ),
// //                 _buildInputArea(),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   // --- WIDGETS ---

// //   // Removed _buildEmptyStateSuggestions and _buildSuggestionChip widgets

// //   Widget _buildBackground() {
// //     return Container(
// //       decoration: const BoxDecoration(
// //         gradient: RadialGradient(
// //           center: Alignment.topLeft,
// //           radius: 1.5,
// //           colors: [
// //              Color(0xFF1E1E1E), // Spotlight
// //              Color(0xFF121212), // Obsidian
// //              Colors.black,
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildFloatingDoodles() {
// //     return Positioned(
// //       top: 100,
// //       right: -50,
// //       child: AnimatedBuilder(
// //         animation: _doodleMoveAnimation,
// //         builder: (context, child) => Transform.translate(
// //           offset: Offset(0, _doodleMoveAnimation.value),
// //           child: Opacity(
// //             opacity: 0.03,
// //             child: SvgPicture.asset(
// //               'assets/images/undraw_chat_qmyo.svg',
// //               width: 300,
// //               placeholderBuilder: (_) => const SizedBox(width: 300, height: 200),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   // --- SIDEBAR (Premium Glass) ---
// //   Widget _buildGlassSidebar() {
// //     return Drawer(
// //       backgroundColor: Colors.transparent,
// //       width: MediaQuery.of(context).size.width * 0.80,
// //       child: Stack(
// //         children: [
// //           BackdropFilter(
// //             filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
// //             child: Container(
// //               decoration: BoxDecoration(
// //                 color: const Color(0xFF121212).withValues(alpha: 0.90),
// //                 border: Border(right: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
// //               ),
// //             ),
// //           ),
// //           Column(
// //             children: [
// //               Container(
// //                 padding: const EdgeInsets.fromLTRB(24, 60, 24, 30),
// //                 decoration: BoxDecoration(
// //                   border: Border(bottom: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
// //                 ),
// //                 child: Row(
// //                   children: [
// //                     // LOGO ONLY (Consolidated Branding)
// //                     Container(
// //                       width: 42, height: 42,
// //                       padding: const EdgeInsets.all(2),
// //                       decoration: BoxDecoration(
// //                         shape: BoxShape.circle,
// //                         border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
// //                       ),
// //                       child: ClipOval(
// //                         child: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
// //                       ),
// //                     ),
// //                     const SizedBox(width: 16),
// //                     Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         const Text('URUELLA AI', 
// //                           style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: 1.0)
// //                         ),
// //                         Text('Premium Eco-System', 
// //                           style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 10, fontWeight: FontWeight.w500)
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               const SizedBox(height: 20),
// //               Expanded(
// //                 child: ListView(
// //                   padding: EdgeInsets.zero,
// //                   children: [
// //                     _buildSidebarItem(Icons.add, 'New Chat', isHighlight: true, onTap: _handleNewChat),
// //                     const Divider(color: Colors.white10, indent: 20, endIndent: 20),
// //                     Padding(
// //                       padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
// //                       child: Text("HISTORY", 
// //                         style: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2),
// //                       ),
// //                     ),
// //                     _buildSidebarItem(Icons.chat_bubble_outline, _currentChatTitle, onTap: (){ Navigator.pop(context); }),
// //                     const SizedBox(height: 20),
// //                     const Divider(color: Colors.white10, indent: 20, endIndent: 20),
// //                     _buildSidebarItem(Icons.folder_open, 'My Files', onTap: (){}),
// //                     _buildSidebarItem(Icons.settings, 'Settings', onTap: (){}),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildSidebarItem(IconData icon, String title, {bool isHighlight = false, required VoidCallback onTap}) {
// //     return Material(
// //       color: Colors.transparent,
// //       child: InkWell(
// //         onTap: onTap,
// //         splashColor: Colors.white.withValues(alpha: 0.05),
// //         highlightColor: Colors.transparent,
// //         child: Container(
// //           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
// //           decoration: isHighlight ? BoxDecoration(
// //             color: Colors.white.withValues(alpha: 0.05),
// //             border: const Border(left: BorderSide(color: Colors.white, width: 2)),
// //           ) : null,
// //           child: Row(
// //             children: [
// //               Icon(icon, color: isHighlight ? Colors.white : Colors.white54, size: 18),
// //               const SizedBox(width: 16),
// //               Expanded(
// //                 child: Text(title, 
// //                   style: TextStyle(
// //                     color: isHighlight ? Colors.white : Colors.white54, 
// //                     fontSize: 13, 
// //                     fontWeight: isHighlight ? FontWeight.w600 : FontWeight.normal
// //                   ),
// //                   overflow: TextOverflow.ellipsis,
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   // --- HEADER ---
// //   Widget _buildHeader() {
// //     return Container(
// //       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
// //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //       decoration: BoxDecoration(
// //         color: Colors.white.withValues(alpha: 0.02),
// //         borderRadius: BorderRadius.circular(20),
// //         border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
// //       ),
// //       child: Row(
// //         children: [
// //           IconButton(
// //             icon: const Icon(Icons.menu, color: Colors.white54),
// //             onPressed: () => _scaffoldKey.currentState?.openDrawer(),
// //           ),
// //           const SizedBox(width: 12),
// //           const Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(
// //                 'URUELLA A i',
// //                 style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
// //               ),
// //               Text(
// //                 'Online • Active',
// //                 style: TextStyle(color: Colors.white38, fontSize: 11),
// //               ),
// //             ],
// //           ),
// //           const Spacer(),
// //           // NEW CHAT ICON (Create/Edit style instead of Plus)
// //           IconButton(
// //             icon: const Icon(Icons.edit_square, color: Colors.white70), // Changed to Edit Square
// //             onPressed: _handleNewChat,
// //             tooltip: 'New Chat',
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   // --- MESSAGES ---

// //   Widget _buildMessageRow(ChatMessage message) {
// //     final isUser = message.sender == MessageSender.user;
// //     return Padding(
// //       padding: const EdgeInsets.only(bottom: 20),
// //       child: Row(
// //         mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
// //         crossAxisAlignment: CrossAxisAlignment.end,
// //         children: [
// //           if (!isUser) ...[
// //             _buildAvatar(isUser: false),
// //             const SizedBox(width: 8),
// //           ],
// //           Flexible(child: _buildMessageBubble(message, isUser)),
// //           if (isUser) ...[
// //             const SizedBox(width: 8),
// //             _buildAvatar(isUser: true),
// //           ],
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildAvatar({required bool isUser}) {
// //     return Container(
// //       width: 32, height: 32,
// //       decoration: BoxDecoration(
// //         shape: BoxShape.circle,
// //         border: Border.all(
// //           color: Colors.white.withValues(alpha: 0.2),
// //           width: 1.0,
// //         ),
// //       ),
// //       child: CircleAvatar(
// //         radius: 14,
// //         backgroundColor: Colors.transparent,
// //         child: isUser 
// //           ? const Icon(Icons.person, color: Colors.white70, size: 16)
// //           : Image.asset('assets/images/logo.png', fit: BoxFit.cover),
// //       ),
// //     );
// //   }

// //   Widget _buildMessageBubble(ChatMessage message, bool isUser) {
// //     return Container(
// //       constraints: const BoxConstraints(maxWidth: 280),
// //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //       decoration: BoxDecoration(
// //         gradient: isUser
// //             ? const LinearGradient(
// //                 colors: [Color(0xFF333333), Color(0xFF1A1A1A)], 
// //                 begin: Alignment.topLeft,
// //                 end: Alignment.bottomRight,
// //               )
// //             : null,
// //         color: isUser ? null : Colors.white.withValues(alpha: 0.05),
// //         borderRadius: BorderRadius.only(
// //           topLeft: const Radius.circular(20),
// //           topRight: const Radius.circular(20),
// //           // FIXED CURVE: Bottom Left for AI, Bottom Right for User
// //           bottomLeft: isUser ? const Radius.circular(20) : const Radius.circular(4), 
// //           bottomRight: isUser ? const Radius.circular(4) : const Radius.circular(20), 
// //         ),
// //         border: Border.all(
// //           color: Colors.white.withValues(alpha: 0.08),
// //         ),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           if (isUser)
// //             Text(
// //               message.content,
// //               style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.4),
// //             )
// //           else
// //             _renderSmartAIContent(message.content),

// //           const SizedBox(height: 4),
// //           Text(
// //             '${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}',
// //             style: TextStyle(
// //               color: Colors.white.withValues(alpha: 0.3),
// //               fontSize: 10,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _renderSmartAIContent(String content) {
// //     List<Widget> widgets = [];
// //     final parts = content.split('```');
    
// //     for (int i = 0; i < parts.length; i++) {
// //       String part = parts[i];
// //       if (part.trim().isEmpty) continue;

// //       if (i % 2 == 1) {
// //         // CODE BLOCK
// //         String language = 'Code';
// //         String code = part;
// //         if (part.contains('\n')) {
// //           final firstLineEnd = part.indexOf('\n');
// //           language = part.substring(0, firstLineEnd).trim();
// //           if (language.isEmpty) language = "Terminal";
// //           code = part.substring(firstLineEnd + 1).trim();
// //         }

// //         widgets.add(Container(
// //           margin: const EdgeInsets.symmetric(vertical: 8),
// //           decoration: BoxDecoration(
// //             color: const Color(0xFF000000),
// //             borderRadius: BorderRadius.circular(8),
// //             border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
// //           ),
// //           child: Column(
// //             children: [
// //               Container(
// //                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
// //                 decoration: BoxDecoration(
// //                   color: Colors.white.withValues(alpha: 0.05),
// //                   borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
// //                 ),
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     Text(language.toUpperCase(), style: const TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold)),
// //                     GestureDetector(
// //                       onTap: () {
// //                         Clipboard.setData(ClipboardData(text: code));
// //                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
// //                           content: Text("Copied!"),
// //                           duration: Duration(milliseconds: 800),
// //                           backgroundColor: Color(0xFF1E1E1E),
// //                         ));
// //                       },
// //                       child: const Icon(Icons.copy, size: 14, color: Colors.white54),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.all(12),
// //                 child: SingleChildScrollView(
// //                   scrollDirection: Axis.horizontal,
// //                   child: Text(code, 
// //                     style: const TextStyle(fontFamily: 'monospace', color: Color(0xFFD4D4D4), fontSize: 12)
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ));
// //       } else {
// //         widgets.add(_renderRichText(part));
// //       }
// //     }
// //     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
// //   }

// //   Widget _renderRichText(String text) {
// //     if (text.trim().startsWith('###')) {
// //       return Padding(
// //         padding: const EdgeInsets.symmetric(vertical: 8),
// //         child: Text(
// //           text.replaceAll('#', '').trim(),
// //           style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.5),
// //         ),
// //       );
// //     }

// //     List<InlineSpan> spans = [];
// //     final split = text.split('**');
    
// //     for (int i = 0; i < split.length; i++) {
// //       if (i % 2 == 1) {
// //         spans.add(TextSpan(
// //           text: split[i], 
// //           style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
// //         ));
// //       } else {
// //         spans.add(TextSpan(
// //           text: split[i],
// //           style: const TextStyle(color: Colors.white, height: 1.4, fontSize: 15)
// //         ));
// //       }
// //     }

// //     return RichText(text: TextSpan(children: spans));
// //   }

// //   Widget _buildTypingIndicatorRow() {
// //     return Padding(
// //       padding: const EdgeInsets.only(bottom: 20),
// //       child: Row(
// //         crossAxisAlignment: CrossAxisAlignment.end,
// //         children: [
// //           _buildAvatar(isUser: false),
// //           const SizedBox(width: 8),
// //           Container(
// //             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //             decoration: BoxDecoration(
// //               color: Colors.white.withValues(alpha: 0.05),
// //               borderRadius: const BorderRadius.only(
// //                 topLeft: Radius.circular(20), topRight: Radius.circular(20),
// //                 bottomRight: Radius.circular(20), bottomLeft: Radius.circular(4),
// //               ),
// //               border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
// //             ),
// //             child: const SizedBox(
// //               width: 16, height: 16,
// //               child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white54),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   // --- INPUT AREA ---

// //   Widget _buildInputArea() {
// //     return Padding(
// //       padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
// //       child: GlassCard(
// //         opacity: 0.03, 
// //         borderRadius: 35,
// //         child: Container(
// //           padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
// //           decoration: BoxDecoration(
// //             border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
// //             borderRadius: BorderRadius.circular(35),
// //           ),
// //           child: Row(
// //             crossAxisAlignment: CrossAxisAlignment.end, 
// //             children: [
// //               // FULLSCREEN TOGGLE
// //               IconButton(
// //                 icon: const Icon(Icons.fullscreen, color: Colors.white54), 
// //                 onPressed: _openExpandedInput,
// //                 tooltip: "Full Screen Editor",
// //               ),
              
// //               IconButton(
// //                 icon: const Icon(Icons.attach_file, color: Colors.white54), 
// //                 onPressed: _handleFileUpload,
// //                 tooltip: "Add File",
// //               ),
              
// //               Expanded(
// //                 child: TextField(
// //                   controller: _textController,
// //                   style: const TextStyle(color: Colors.white),
// //                   cursorColor: Colors.white, 
// //                   minLines: 1,
// //                   maxLines: 5, 
// //                   decoration: InputDecoration(
// //                     filled: false, // TRANSPARENT
// //                     hintText: 'Ask Uruella...',
// //                     hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
// //                     border: InputBorder.none,
// //                     enabledBorder: InputBorder.none,
// //                     focusedBorder: InputBorder.none,
// //                     contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
// //                   ),
// //                 ),
// //               ),
              
// //               if (_textController.text.isEmpty)
// //                  IconButton(
// //                   icon: Icon(_isListening ? Icons.mic : Icons.mic_none, color: _isListening ? Colors.redAccent : Colors.white54),
// //                   onPressed: _handleVoiceInput,
// //                 ),

// //               Container(
// //                 margin: const EdgeInsets.all(2),
// //                 decoration: const BoxDecoration(
// //                   shape: BoxShape.circle,
// //                   color: Colors.white,
// //                 ),
// //                 child: IconButton(
// //                   icon: const Icon(Icons.arrow_upward_rounded, color: Colors.black, size: 20),
// //                   onPressed: _sendMessage,
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }



// import 'dart:async';
// import 'dart:io';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:permission_handler/permission_handler.dart';
// import 'package:just_audio/just_audio.dart';

// // Project Imports
// import 'package:uruella_ai/models/chat_message.dart'; 
// import 'package:uruella_ai/services/ai_service.dart';
// import 'package:uruella_ai/services/offline_storage_service.dart';
// import 'package:uruella_ai/widgets/glass_card.dart';
// import 'package:uruella_ai/routes/app_routes.dart';

// // Helper Extension for Color opacity (Fixed for correct non-recursive call)
// extension ColorExtension on Color {
//   Color withValues({double? alpha}) {
//     if (alpha == null) return this;
//     return withOpacity(alpha); 
//   }
// }

// // Placeholder classes (ensure these are replaced by your actual files)
// enum MessageSender { user, ai }
// class ChatMessage {
//   final String id;
//   final String content;
//   final MessageSender sender;
//   final DateTime timestamp;
//   ChatMessage({required this.id, required this.content, required this.sender, required this.timestamp});
// }
// class OfflineStorageService {
//   Future<void> initialize() async {}
//   Future<List<Map<String, dynamic>>> getChatMessages() async => [];
//   Future<void> saveChatMessages(List<Map<String, dynamic>> messages) async {}
//   Future<dynamic> getData(String key) async => null;
//   Future<void> saveData(String key, dynamic value) async {}
//   Future<void> clearChat() async {}
// }
// class GlassCard extends StatelessWidget {
//   final Widget child;
//   final double opacity;
//   final double borderRadius;
//   const GlassCard({super.key, required this.child, this.opacity = 0.0, this.borderRadius = 0.0});
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(borderRadius),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//         child: Container(
//           color: Colors.black.withValues(alpha: opacity), 
//           child: child,
//         ),
//       ),
//     );
//   }
// }
// class AppRoutes {
//   static const String settings = '/settings';
//   static const String workflows = '/workflows';
// }


// class ChatPage extends StatefulWidget {
//   const ChatPage({super.key});

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
//   List<ChatMessage> _messages = [];
//   final List<Map<String, String>> _apiHistory = []; 
  
//   final TextEditingController _textController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   final AIService _aiService = AIService(); 
//   final OfflineStorageService _storageService = OfflineStorageService();
  
//   final stt.SpeechToText _speech = stt.SpeechToText();
//   bool _isListening = false; // Note: VS Code suggests making this 'final' but it must be mutable for listening toggle
  
//   bool _isLoading = false;
//   String _currentChatTitle = "New Chat";
  
//   PlatformFile? _uploadedFile; 
//   Uint8List? _fileBytes; 

//   late AnimationController _bgController;
//   late Animation<double> _doodleMoveAnimation;

//   final AudioPlayer _audioPlayer = AudioPlayer();
//   bool _isVoiceModeEnabled = false;
  
//   // HISTORY MANAGEMENT
//   final TextEditingController _searchController = TextEditingController();
//   List<String> _chatHistoryTitles = []; 


//   @override
//   void initState() {
//     super.initState();
    
//     _bgController = AnimationController(
//       duration: const Duration(seconds: 6),
//       vsync: this,
//     )..repeat(reverse: true);
    
//     _doodleMoveAnimation = Tween<double>(begin: -10.0, end: 10.0).animate(
//       CurvedAnimation(parent: _bgController, curve: Curves.easeInOut),
//     );

//     _initServices();
//     _textController.addListener(() {
//       if (mounted) setState(() {});
//     });
//     _searchController.addListener(_filterChatHistory);
//   }

//   Future<void> _initServices() async {
//     await _aiService.initialize();
//     await _storageService.initialize();
//     if (mounted) {
//       _loadPersistedChat(); 
//       _loadChatHistoryTitles();
//     }
//   }

//   @override
//   void dispose() {
//     _bgController.dispose();
//     _textController.dispose();
//     _scrollController.dispose();
//     _audioPlayer.dispose(); 
//     _searchController.dispose();
//     super.dispose();
//   }

//   // ------------------------------------
//   // --- PERSISTENCE & HISTORY METHODS ---
//   // ------------------------------------

//   Future<void> _loadChatHistoryTitles() async {
//     if (!mounted) return;
//     setState(() {
//       // Simulate fetching a list of chat titles from storage
//       _chatHistoryTitles = ['Today\'s Chat (Current)', 'Old Project Plan', 'Marketing Strategy Draft'];
//       _chatHistoryTitles.insert(0, _currentChatTitle);
//       _chatHistoryTitles = _chatHistoryTitles.toSet().toList(); 
//     });
//   }

//   void _filterChatHistory() {
//     setState(() {
//       _loadChatHistoryTitles(); 
//       if (_searchController.text.isNotEmpty) {
//         final query = _searchController.text.toLowerCase();
//         _chatHistoryTitles = _chatHistoryTitles.where((title) => title.toLowerCase().contains(query)).toList();
//       }
//     });
//   }
  
//   // ⭐️ FIX: Missing _loadWelcomeMessage ⭐️
//   void _loadWelcomeMessage() {
//     if (_messages.isNotEmpty) return;
//     if (mounted) {
//       setState(() {
//         _messages.add(ChatMessage(
//           id: 'init',
//           content: 'Hello! I\'m Uruella AI. Ready to build. What\'s the task?',
//           sender: MessageSender.ai,
//           timestamp: DateTime.now(),
//         ));
//       });
//     }
//   }

//   Future<void> _loadPersistedChat() async {
//     final savedMessages = await _storageService.getChatMessages();
//     final savedTitle = await _storageService.getData('chat_title');
    
//     if (!mounted) return;

//     if (savedMessages.isNotEmpty) {
//       setState(() {
//         if (savedTitle != null && savedTitle is String) {
//           _currentChatTitle = savedTitle;
//         }

//         _messages = savedMessages.map((m) {
//           return ChatMessage(
//             id: m['id'] ?? DateTime.now().toString(),
//             content: m['content'] ?? '',
//             sender: m['sender'] == 'user' ? MessageSender.user : MessageSender.ai,
//             timestamp: DateTime.parse(m['timestamp'] ?? DateTime.now().toIso8601String()),
//           );
//         }).toList();

//         _apiHistory.clear();
//         for (var msg in _messages.where((m) => m.id != 'init')) { 
//            _apiHistory.add({
//              'role': msg.sender == MessageSender.user ? 'user' : 'model',
//              'content': msg.content
//            });
//         }
//       });
      
//       Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
//     } else {
//       _loadWelcomeMessage();
//     }
//   }

//   // ⭐️ FIX: Missing _saveChat ⭐️
//   Future<void> _saveChat() async {
//     final messagesToSave = _messages.map((m) => {
//       'id': m.id,
//       'content': m.content,
//       'sender': m.sender == MessageSender.user ? 'user' : 'ai',
//       'timestamp': m.timestamp.toIso8601String(),
//     }).toList();
    
//     await _storageService.saveChatMessages(messagesToSave);
//     await _storageService.saveData('chat_title', _currentChatTitle);
//   }

//   // ------------------------------------
//   // --- AUDIO & VOICE METHODS ---
//   // ------------------------------------
  
//   Future<void> _playSendSound() async {
//     try {
//       await _audioPlayer.setAsset('assets/sounds/send.mp3');
//       await _audioPlayer.play();
//     } catch (e) {
//       debugPrint("Error playing send sound: $e");
//     }
//   }

//   Future<void> _playReceiveSound() async {
//     try {
//       await _audioPlayer.setAsset('assets/sounds/receive.mp3');
//       await _audioPlayer.play();
//     } catch (e) {
//       debugPrint("Error playing receive sound: $e");
//     }
//   }

//   Future<void> _speakResponse(String text) async {
//     // We play the receive sound as a proxy for 'speaking'.
//     await _playReceiveSound();
    
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text("AI is speaking... (Simulated TTS)"),
//         duration: Duration(seconds: 1),
//         backgroundColor: Color(0xFFB5A642),
//       ));
//     }
//   }

//   // ------------------------------------
//   // --- USER INTERACTION METHODS ---
//   // ------------------------------------

//   void _scrollToBottom() {
//     if (_scrollController.hasClients) {
//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent + 100,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     }
//   }
  
//   void _handleNewChat() async {
//     await _saveChat(); 
//     await _storageService.clearChat();
//     await _storageService.saveData('chat_title', "New Chat");
//     _loadChatHistoryTitles();

//     if (!mounted) return;
    
//     setState(() {
//       _messages.clear();
//       _apiHistory.clear();
//       _currentChatTitle = "New Chat";
//       _isLoading = false;
//       _uploadedFile = null;
//       _fileBytes = null;
//     });
    
//     _loadWelcomeMessage();
    
//     if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
//       Navigator.of(context).pop();
//     }
//   }
  
//   // ⭐️ FIX: Missing _handleFileUpload ⭐️
//   Future<void> _handleFileUpload() async {
//     try {
//       await Permission.storage.request();
      
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['pdf', 'csv', 'xlsx', 'png', 'jpg', 'jpeg', 'txt'], 
//       );

//       if (result != null && result.files.single.path != null) {
//         PlatformFile file = result.files.single;
        
//         Uint8List? bytes;
//         if (file.size < 10 * 1024 * 1024 && ['png', 'jpg', 'jpeg'].contains(file.extension?.toLowerCase())) { 
//             bytes = File(file.path!).readAsBytesSync();
//         }

//         if (!mounted) return;

//         setState(() {
//           _uploadedFile = file;
//           _fileBytes = bytes;
//         });

//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text("File loaded: ${file.name} (Ready to send)"),
//             backgroundColor: const Color(0xFFB5A642),
//         ));
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text("File Error: $e"),
//           backgroundColor: Colors.redAccent,
//         ));
//       }
//     }
//   }
  
//   // ⭐️ FIX: Missing _handlePause ⭐️
//   void _handlePause() {
//     setState(() {
//       _isLoading = false;
//     });
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//       content: Text("Response paused. Tap Send to continue."),
//       backgroundColor: Colors.white12,
//     ));
//   }
  
//   // ⭐️ FIX: Missing _handleVoiceInput ⭐️
//   void _handleVoiceInput() async {
//     var status = await Permission.microphone.request();
//     if (status.isDenied) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text("Microphone permission denied"),
//           backgroundColor: Colors.redAccent,
//         ));
//       }
//       return;
//     }

//     if (!_isListening) {
//       bool available = await _speech.initialize(
//         onStatus: (status) => debugPrint('Voice Status: $status'),
//         onError: (errorNotification) => debugPrint('Voice Error: $errorNotification'),
//       );

//       if (!mounted) return;

//       if (available) {
//         setState(() => _isListening = true);
//         _speech.listen(
//           onResult: (result) {
//             setState(() {
//               _textController.text = result.recognizedWords;
//             });
//           },
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text("Speech recognition unavailable"),
//           backgroundColor: Colors.redAccent,
//         ));
//       }
//     } else {
//       setState(() => _isListening = false);
//       _speech.stop();
//     }
//   }

//   // ⭐️ FIX: Missing _openExpandedInput ⭐️
//   void _openExpandedInput() {
//     Navigator.of(context).push(PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
//         backgroundColor: const Color(0xFF000000), 
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           leading: IconButton(
//             icon: const Icon(Icons.close, color: Colors.white70),
//             onPressed: () => Navigator.pop(context),
//           ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 16.0),
//               child: TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   if (_textController.text.isNotEmpty) _sendMessage();
//                 },
//                 style: TextButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   foregroundColor: Colors.black,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)), 
//                 ),
//                 child: const Text("SEND", style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0.5)),
//               ),
//             )
//           ],
//         ),
//         body: Container(
//           width: double.infinity,
//           height: double.infinity,
//           padding: const EdgeInsets.all(24),
//           child: TextField(
//             controller: _textController,
//             maxLines: null,
//             autofocus: true,
//             style: const TextStyle(
//               color: Colors.white, 
//               fontSize: 18, 
//               height: 1.6, 
//               fontWeight: FontWeight.w400
//             ),
//             cursorColor: Colors.white,
//             decoration: InputDecoration(
//               hintText: "Type your full prompt here...",
//               hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
//               border: InputBorder.none,
//             ),
//           ),
//         ),
//       ),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         return SlideTransition(
//           position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(animation),
//           child: child,
//         );
//       },
//     ));
//   }

//   void _sendMessage() async {
//     final text = _textController.text.trim();
//     final hasFile = _uploadedFile != null;
//     if (text.isEmpty && !hasFile) return;

//     // 1. Prepare User UI Message and API Prompt
//     String userContent = text;
//     if (hasFile) {
//       userContent = "📎 Uploaded File: ${_uploadedFile!.name}${text.isNotEmpty ? ' | Prompt: $text' : ''}";
//     }
//     final apiPrompt = text.isEmpty && hasFile ? "Analyze the uploaded file: ${_uploadedFile!.name}" : text;

//     final userMessage = ChatMessage(
//       id: DateTime.now().millisecondsSinceEpoch.toString(),
//       content: userContent,
//       sender: MessageSender.user,
//       timestamp: DateTime.now(),
//     );
    
//     final fileBytesForStream = _fileBytes;

//     // 2. Initial UI update & History update + Send Sound
//     await _playSendSound();
//     setState(() {
//       _messages.add(userMessage);
//       _apiHistory.add({'role': 'user', 'content': apiPrompt}); 
//       _textController.clear();
//       _uploadedFile = null; 
//       _fileBytes = null;
//       _isLoading = true;
//     });

//     _scrollToBottom();
//     _saveChat();

//     // Summarize chat for title only if it's the FIRST actual user message
//     if (_messages.length <= 2 && _messages.first.id == 'init') {
//       _aiService.summarizeChat(text).then((title) {
//         if (mounted) {
//           setState(() => _currentChatTitle = title);
//           _saveChat(); 
//         }
//       });
//     }

//     // 3. Start the streaming generation
//     final stream = _aiService.processMessageStream(apiPrompt, history: _apiHistory, imageBytes: fileBytesForStream);
    
//     final aiMessageId = (DateTime.now().millisecondsSinceEpoch + 1).toString();
    
//     // Add an empty AI message to the list to hold the incoming stream
//     setState(() {
//       _messages.add(ChatMessage(
//         id: aiMessageId,
//         content: '', 
//         sender: MessageSender.ai,
//         timestamp: DateTime.now(),
//       ));
//     });

//     String fullResponse = '';
//     // 4. Consume the stream and update the last message in real-time
//     await for (var chunk in stream) {
//       if (mounted && _isLoading) {
//         fullResponse += chunk;
//         setState(() {
//           final index = _messages.indexWhere((m) => m.id == aiMessageId);
//           if (index != -1) {
//             final updatedMessage = ChatMessage(
//               id: _messages[index].id,
//               content: fullResponse, 
//               sender: MessageSender.ai,
//               timestamp: _messages[index].timestamp,
//             );
//             _messages[index] = updatedMessage; 
//           }
//         });
//         _scrollToBottom();
//       } else if (!_isLoading) {
//         break; 
//       }
//     }

//     // 5. Final state cleanup + Receive Sound/Voice
//     if (mounted) {
//       if (_isVoiceModeEnabled && fullResponse.isNotEmpty) {
//         await _speakResponse(fullResponse);
//       } else {
//         await _playReceiveSound();
//       }

//       setState(() {
//         _isLoading = false;
//         if (fullResponse.isNotEmpty) {
//           _apiHistory.add({'role': 'model', 'content': fullResponse});
//         }
//         _saveChat(); 
//       });
//     }
//   }

//   // ------------------------------------
//   // --- WIDGET BUILDER METHODS ---
//   // ------------------------------------

//   // ⭐️ FIX: Missing _buildAvatar ⭐️
//   Widget _buildAvatar({required bool isUser}) {
//     return Container(
//       width: 32, height: 32,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(
//           color: Colors.white.withValues(alpha: 0.2),
//           width: 1.0,
//         ),
//       ),
//       child: CircleAvatar(
//         radius: 14,
//         backgroundColor: Colors.transparent,
//         child: isUser 
//           ? const Icon(Icons.person, color: Colors.white70, size: 16)
//           : Image.asset('assets/images/logo.png', fit: BoxFit.cover),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       decoration: BoxDecoration(
//         color: Colors.white.withValues(alpha: 0.02),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
//       ),
//       child: Row(
//         children: [
//           IconButton(
//             icon: const Icon(Icons.menu, color: Colors.white54),
//             onPressed: () => _scaffoldKey.currentState?.openDrawer(),
//             tooltip: 'Chat History',
//           ),
          
//           // ⭐️ FIX: Back button navigates to AppRoutes.workflows ⭐️
//           IconButton(
//             icon: const Icon(Icons.arrow_back, color: Colors.white54),
//             onPressed: () => Navigator.of(context).pushNamed(AppRoutes.workflows),
//             tooltip: 'Back to Workflows',
//           ),
          
//           const SizedBox(width: 12),
          
//           const Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'URUELLA A i',
//                 style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
//               ),
//               Text(
//                 'Offline • Active', 
//                 style: TextStyle(color: Colors.white38, fontSize: 11),
//               ),
//             ],
//           ),
//           const Spacer(),
          
//           // AI Voice Mode Toggle
//           Tooltip(
//             message: _isVoiceModeEnabled ? "AI Voice Mode: ON" : "AI Voice Mode: OFF",
//             child: IconButton(
//               icon: Icon(
//                 _isVoiceModeEnabled ? Icons.volume_up : Icons.volume_off, 
//                 color: _isVoiceModeEnabled ? const Color(0xFF00C7F9) : Colors.white54,
//               ),
//               onPressed: () {
//                 setState(() {
//                   _isVoiceModeEnabled = !_isVoiceModeEnabled;
//                 });
//               },
//             ),
//           ),

//           IconButton(
//             icon: const Icon(Icons.edit_square, color: Colors.white70),
//             onPressed: _handleNewChat,
//             tooltip: 'New Chat',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFilePreview(PlatformFile file) {
//      return Container(
//        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//        margin: const EdgeInsets.only(bottom: 8),
//        decoration: BoxDecoration(
//          color: const Color(0xFFB5A642).withValues(alpha: 0.1),
//          borderRadius: BorderRadius.circular(8),
//        ),
//        child: Row(
//          mainAxisSize: MainAxisSize.min,
//          children: [
//            Icon(Icons.insert_drive_file, color: Colors.white.withValues(alpha: 0.7), size: 16),
//            const SizedBox(width: 8),
//            Flexible(
//              child: Text(
//                file.name,
//                style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12),
//                overflow: TextOverflow.ellipsis,
//              ),
//            ),
//            IconButton(
//              onPressed: () => setState(() { _uploadedFile = null; _fileBytes = null; }),
//              icon: Icon(Icons.close, size: 14, color: Colors.white.withValues(alpha: 0.5)),
//            )
//          ],
//        ),
//      );
//   }

//   Widget _buildReactionFooter(ChatMessage message) {
//     if (message.content.trim().isEmpty) return const SizedBox.shrink(); 

//     return Padding(
//       padding: const EdgeInsets.only(top: 8, left: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           GestureDetector(
//             onTap: () { 
//               Clipboard.setData(ClipboardData(text: message.content)); 
//               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                 content: const Text("Copied AI response!", style: TextStyle(color: Colors.black, fontSize: 12)),
//                 duration: const Duration(milliseconds: 800),
//                 backgroundColor: Colors.white.withValues(alpha: 0.9), 
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//               ));
//             },
//             child: Icon(Icons.copy_outlined, size: 14, color: Colors.white.withValues(alpha: 0.3)),
//           ),
//           const SizedBox(width: 12),
//           Icon(Icons.thumb_up_alt_outlined, size: 14, color: Colors.white.withValues(alpha: 0.3)),
//           const SizedBox(width: 12),
//           Icon(Icons.share_outlined, size: 14, color: Colors.white.withValues(alpha: 0.3)),
//           const SizedBox(width: 12),
//           Icon(Icons.select_all, size: 14, color: Colors.white.withValues(alpha: 0.3)),
//         ],
//       ),
//     );
//   }

//   Widget _buildMessageBubble(ChatMessage message, bool isUser) {
//     return Container(
//       constraints: const BoxConstraints(maxWidth: 280),
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       decoration: BoxDecoration(
//         gradient: isUser
//             ? const LinearGradient(
//                 colors: [Color(0xFF333333), Color(0xFF1A1A1A)], 
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               )
//             : null,
//         color: isUser ? null : Colors.white.withValues(alpha: 0.05),
//         borderRadius: BorderRadius.only(
//           topLeft: const Radius.circular(20),
//           topRight: const Radius.circular(20),
//           bottomLeft: isUser ? const Radius.circular(20) : const Radius.circular(4), 
//           bottomRight: isUser ? const Radius.circular(4) : const Radius.circular(20), 
//         ),
//         border: Border.all(
//           color: Colors.white.withValues(alpha: 0.08),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (isUser && message.content.startsWith('📎 Uploaded File:'))
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   message.content.split('|')[0],
//                   style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontStyle: FontStyle.italic, fontSize: 13),
//                 ),
//                 if (message.content.split('|').length > 1)
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8.0),
//                     child: Text(
//                       message.content.split('|')[1].trim().replaceAll('Prompt: ', ''), 
//                       style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.4),
//                     ),
//                   ),
//               ],
//             )
//           else if (isUser)
//             Text(
//               message.content,
//               style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.4),
//             )
//           else
//             _renderSmartAIContent(message.content),

//           const SizedBox(height: 4),
//           Text(
//             '${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}',
//             style: TextStyle(
//               color: Colors.white.withValues(alpha: 0.3),
//               fontSize: 10,
//             ),
//           ),
//         ],
//       ),
//     );
//   }


//   Widget _buildMessageRow(ChatMessage message) {
//     final isUser = message.sender == MessageSender.user;
//     final isStreaming = !isUser && _isLoading && message.content.isEmpty; 

//     return Padding(
//       padding: const EdgeInsets.only(bottom: 20),
//       child: Row(
//         mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           if (!isUser) ...[
//             _buildAvatar(isUser: false),
//             const SizedBox(width: 8),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 isStreaming ? _buildTypingIndicatorContent() : _buildMessageBubble(message, isUser),
//                 if (!isStreaming) _buildReactionFooter(message),
//               ],
//             ),
//           ],

//           if (isUser) ...[
//             Flexible(child: _buildMessageBubble(message, isUser)),
//             const SizedBox(width: 8),
//             _buildAvatar(isUser: true),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget _buildTypingIndicatorContent() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       constraints: const BoxConstraints(maxWidth: 280),
//       decoration: BoxDecoration(
//         color: Colors.white.withValues(alpha: 0.05),
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(20), topRight: Radius.circular(20),
//           bottomRight: Radius.circular(20), bottomLeft: Radius.circular(4),
//         ),
//         border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
//       ),
//       child: const SizedBox(
//         width: 16, height: 16,
//         child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white54),
//       ),
//     );
//   }

//   Widget _buildInputArea() {
//     final bool sendDisabled = _isLoading || (_textController.text.trim().isEmpty && _uploadedFile == null);
    
//     final double bottomPadding = MediaQuery.of(context).padding.bottom == 0 ? 20 : MediaQuery.of(context).padding.bottom;
    
//     return Positioned(
//       bottom: 0,
//       left: 0,
//       right: 0,
//       child: Padding(
//         padding: EdgeInsets.fromLTRB(16, 0, 16, bottomPadding), 
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
//           decoration: BoxDecoration(
//             color: const Color(0xFF1E1E1E), 
//             border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
//             borderRadius: BorderRadius.circular(35),
//           ),
//           child: Column(
//             children: [
//               if (_uploadedFile != null)
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
//                   child: _buildFilePreview(_uploadedFile!),
//                 ),

//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.end, 
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.fullscreen, color: Colors.white54), 
//                     onPressed: _openExpandedInput,
//                     tooltip: "Full Screen Editor",
//                   ),
                  
//                   IconButton(
//                     icon: const Icon(Icons.attach_file, color: Colors.white54), 
//                     onPressed: _handleFileUpload,
//                     tooltip: "Add File",
//                   ),
                  
//                   Expanded(
//                     child: TextField(
//                       controller: _textController,
//                       onChanged: (value) => setState(() {}),
//                       style: const TextStyle(color: Colors.white),
//                       cursorColor: Colors.white, 
//                       minLines: 1,
//                       maxLines: 5, 
//                       decoration: InputDecoration(
//                         filled: false, 
//                         hintText: 'Ask Uruella...',
//                         hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
//                         border: InputBorder.none,
//                         enabledBorder: InputBorder.none,
//                         focusedBorder: InputBorder.none,
//                         contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
//                       ),
//                     ),
//                   ),
                  
//                   if (_textController.text.isEmpty && _uploadedFile == null)
//                       IconButton(
//                       icon: Icon(_isListening ? Icons.mic : Icons.mic_none, color: _isListening ? Colors.redAccent : Colors.white54),
//                       onPressed: _handleVoiceInput,
//                     ),

//                   Container(
//                     margin: const EdgeInsets.all(2),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: sendDisabled ? Colors.white.withValues(alpha: 0.3) : Colors.white,
//                     ),
//                     child: IconButton(
//                       icon: Icon(
//                         _isLoading ? Icons.pause : Icons.arrow_upward_rounded, 
//                         color: _isLoading ? Colors.white : Colors.black, 
//                         size: 20
//                       ),
//                       onPressed: _isLoading ? _handlePause : (sendDisabled ? null : _sendMessage),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _renderSmartAIContent(String content) {
//     List<Widget> widgets = [];
//     final parts = content.split('```');
    
//     for (int i = 0; i < parts.length; i++) {
//       String part = parts[i];
//       if (part.trim().isEmpty) continue;

//       if (i % 2 == 1) {
//         // CODE BLOCK
//         String language = 'Code';
//         String code = part;
//         if (part.contains('\n')) {
//           final firstLineEnd = part.indexOf('\n');
//           language = part.substring(0, firstLineEnd).trim();
//           if (language.isEmpty) language = "Terminal";
//           code = part.substring(firstLineEnd + 1).trim();
//         }

//         widgets.add(Container(
//           margin: const EdgeInsets.symmetric(vertical: 8),
//           decoration: BoxDecoration(
//             color: const Color(0xFF000000),
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withValues(alpha: 0.05),
//                   borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(language.toUpperCase(), style: const TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold)),
//                     GestureDetector(
//                       onTap: () {
//                         Clipboard.setData(ClipboardData(text: code));
//                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                           content: Text("Copied!"),
//                           duration: Duration(milliseconds: 800),
//                           backgroundColor: Color(0xFF1E1E1E),
//                         ));
//                       },
//                       child: const Icon(Icons.copy, size: 14, color: Colors.white54),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Text(code, 
//                     style: const TextStyle(fontFamily: 'monospace', color: Color(0xFFD4D4D4), fontSize: 12)
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ));
//       } else {
//         widgets.add(_renderRichText(part));
//       }
//     }
//     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
//   }

//   Widget _renderRichText(String text) {
//     if (text.trim().startsWith('#')) {
//       int hashCount = text.split(' ').first.length;
//       double fontSize = 20.0 - (hashCount * 2);
//       fontSize = fontSize < 14 ? 14 : fontSize;

//       return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8),
//         child: Text(
//           text.replaceAll(RegExp(r'^#+\s*'), '').trim(),
//           style: TextStyle(color: Colors.white, fontSize: fontSize, fontWeight: FontWeight.bold, letterSpacing: 0.5),
//         ),
//       );
//     }
    
//     List<InlineSpan> spans = [];
//     final split = text.split('**');
    
//     for (int i = 0; i < split.length; i++) {
//       if (i % 2 == 1) {
//         spans.add(TextSpan(
//           text: split[i], 
//           style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
//         ));
//       } else {
//         spans.add(TextSpan(
//           text: split[i],
//           style: const TextStyle(color: Colors.white, height: 1.4, fontSize: 15)
//         ));
//       }
//     }

//     return RichText(text: TextSpan(children: spans));
//   }


//   Widget _buildBackground() {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: RadialGradient(
//           center: Alignment.topLeft,
//           radius: 1.5,
//           colors: [
//               Color(0xFF1E1E1E), 
//               Color(0xFF121212),
//               Colors.black,
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFloatingDoodles() {
//     return Positioned(
//       top: 100,
//       right: -50,
//       child: AnimatedBuilder(
//         animation: _doodleMoveAnimation,
//         builder: (context, child) => Transform.translate(
//           offset: Offset(0, _doodleMoveAnimation.value),
//           child: Opacity(
//             opacity: 0.03,
//             child: SvgPicture.asset(
//               'assets/images/undraw_chat_qmyo.svg',
//               width: 300,
//               placeholderBuilder: (_) => const SizedBox(width: 300, height: 200),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildGlassSidebar() {
//     return Drawer(
//       backgroundColor: Colors.transparent,
//       width: MediaQuery.of(context).size.width * 0.80,
//       child: Stack(
//         children: [
//           BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: const Color(0xFF121212).withValues(alpha: 0.90),
//                 border: Border(right: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
//               ),
//             ),
//           ),
//           Column(
//             children: [
//               Container(
//                 padding: const EdgeInsets.fromLTRB(24, 60, 24, 30),
//                 decoration: BoxDecoration(
//                   border: Border(bottom: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween, 
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           width: 42, height: 42,
//                           padding: const EdgeInsets.all(2),
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
//                           ),
//                           child: ClipOval(
//                              child: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         const Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('URUELLA AI', 
//                               style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: 1.0)
//                             ),
//                             Text('Premium Eco-System', 
//                               style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.w500)
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.close, color: Colors.white70),
//                       onPressed: () => Navigator.pop(context),
//                     )
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
//                 child: TextField(
//                   controller: _searchController,
//                   style: const TextStyle(color: Colors.white),
//                   cursorColor: Colors.white,
//                   decoration: InputDecoration(
//                     hintText: 'Search chats...',
//                     hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.4)),
//                     prefixIcon: Icon(Icons.search, color: Colors.white.withValues(alpha: 0.6)),
//                     filled: true,
//                     fillColor: Colors.white.withValues(alpha: 0.05),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide.none,
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(vertical: 0),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: ListView(
//                   padding: EdgeInsets.zero,
//                   children: [
//                     _buildSidebarItem(Icons.add, 'New Chat', isHighlight: true, onTap: _handleNewChat),
//                     const Divider(color: Colors.white10, indent: 20, endIndent: 20),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
//                       child: Text("HISTORY", 
//                         style: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2),
//                       ),
//                     ),
//                     ..._chatHistoryTitles.map((title) {
//                       return _buildSidebarItem(
//                         Icons.chat_bubble_outline, 
//                         title, 
//                         isHighlight: title == _currentChatTitle, 
//                         onTap: (){ Navigator.pop(context); }
//                       );
//                     }).toList(),
//                     const SizedBox(height: 20),
//                     const Divider(color: Colors.white10, indent: 20, endIndent: 20),
//                     _buildSidebarItem(Icons.folder_open, 'My Files', onTap: (){}),
//                     _buildSidebarItem(Icons.settings, 'Settings', onTap: (){ 
//                       Navigator.pop(context);
//                       Navigator.of(context).pushNamed(AppRoutes.settings);
//                     }),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSidebarItem(IconData icon, String title, {bool isHighlight = false, required VoidCallback onTap}) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: onTap,
//         splashColor: Colors.white.withValues(alpha: 0.05),
//         highlightColor: Colors.transparent,
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//           decoration: isHighlight ? BoxDecoration(
//             color: Colors.white.withValues(alpha: 0.05),
//             border: const Border(left: BorderSide(color: Colors.white, width: 2)),
//           ) : null,
//           child: Row(
//             children: [
//               Icon(icon, color: isHighlight ? Colors.white : Colors.white54, size: 18),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Text(title, 
//                   style: TextStyle(
//                     color: isHighlight ? Colors.white : Colors.white54, 
//                     fontSize: 13, 
//                     fontWeight: isHighlight ? FontWeight.w600 : FontWeight.normal
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     const double inputAreaRoughHeight = 70.0;
//     final double bottomSystemPadding = MediaQuery.of(context).padding.bottom;
//     final double inputAreaOffset = inputAreaRoughHeight + bottomSystemPadding + 20;

//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: const Color(0xFF000000), 
//       extendBodyBehindAppBar: true,
//       drawer: _buildGlassSidebar(), 
//       body: Stack(
//         children: [
//           _buildBackground(),
//           _buildFloatingDoodles(),
//           BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//             child: Container(color: Colors.transparent),
//           ),
          
//           SafeArea(
//             child: Column(
//               children: [
//                 _buildHeader(), 
//                 Expanded(
//                   child: ListView.builder(
//                     controller: _scrollController,
//                     padding: EdgeInsets.fromLTRB(16, 20, 16, inputAreaOffset), 
//                     itemCount: _messages.length, 
//                     itemBuilder: (context, index) {
//                       return _buildMessageRow(_messages[index]);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
          
//           _buildInputArea(),
//         ],
//       ),
//     );
//   }
// }




import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
import 'package:just_audio/just_audio.dart';

// Project Imports
// import 'package:uruella_ai/models/chat_message.dart'; 
import 'package:uruella_ai/services/ai_service.dart';
// import 'package:uruella_ai/services/offline_storage_service.dart';
// import 'package:uruella_ai/widgets/glass_card.dart';
// import 'package:uruella_ai/routes/app_routes.dart';


// Helper Extension for Color opacity (Fixed for correct non-recursive call)
extension ColorExtension on Color {
  Color withValues({double? alpha}) {
    if (alpha == null) return this;
    return withValues(alpha:alpha); 
  }
}

// Placeholder classes (Ensure these are defined in your actual files, used here for scope reference)
enum MessageSender { user, ai }
class ChatMessage {
  final String id;
  final String content;
  final MessageSender sender;
  final DateTime timestamp;
  ChatMessage({required this.id, required this.content, required this.sender, required this.timestamp});
}
class OfflineStorageService {
  Future<void> initialize() async {}
  Future<List<Map<String, dynamic>>> getChatMessages() async => [];
  Future<void> saveChatMessages(List<Map<String, dynamic>> messages) async {}
  Future<dynamic> getData(String key) async => null;
  Future<void> saveData(String key, dynamic value) async {}
  Future<void> clearChat() async {}
}
class GlassCard extends StatelessWidget {
  final Widget child;
  final double opacity;
  final double borderRadius;
  const GlassCard({super.key, required this.child, this.opacity = 0.0, this.borderRadius = 0.0});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          color: Colors.black.withValues(alpha: opacity), 
          child: child,
        ),
      ),
    );
  }
}
class AppRoutes {
  static const String settings = '/settings';
  static const String workflows = '/workflows';
}


class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  List<ChatMessage> _messages = [];
  final List<Map<String, String>> _apiHistory = []; 
  
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final AIService _aiService = AIService(); 
  final OfflineStorageService _storageService = OfflineStorageService();
  
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  
  bool _isLoading = false;
  String _currentChatTitle = "New Chat";
  
  PlatformFile? _uploadedFile; 
  Uint8List? _fileBytes; 

  late AnimationController _bgController;
  late Animation<double> _doodleMoveAnimation;

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isVoiceModeEnabled = false;
  
  final TextEditingController _searchController = TextEditingController();
  List<String> _chatHistoryTitles = []; 


  @override
  void initState() {
    super.initState();
    
    _bgController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat(reverse: true);
    
    _doodleMoveAnimation = Tween<double>(begin: -10.0, end: 10.0).animate(
      CurvedAnimation(parent: _bgController, curve: Curves.easeInOut),
    );

    _initServices();
    _textController.addListener(() {
      if (mounted) setState(() {});
    });
    _searchController.addListener(_filterChatHistory);
  }

  Future<void> _initServices() async {
    await _aiService.initialize();
    await _storageService.initialize();
    if (mounted) {
      _loadPersistedChat(); 
      _loadChatHistoryTitles();
    }
  }

  @override
  void dispose() {
    _bgController.dispose();
    _textController.dispose();
    _scrollController.dispose();
    _audioPlayer.dispose(); 
    _searchController.dispose();
    super.dispose();
  }

  // ------------------------------------
  // --- PERSISTENCE & HISTORY METHODS ---
  // ------------------------------------

  Future<void> _loadChatHistoryTitles() async {
    if (!mounted) return;
    setState(() {
      _chatHistoryTitles = ['Today\'s Chat (Current)', 'Old Project Plan', 'Marketing Strategy Draft'];
      _chatHistoryTitles.insert(0, _currentChatTitle);
      _chatHistoryTitles = _chatHistoryTitles.toSet().toList(); 
    });
  }

  void _filterChatHistory() {
    setState(() {
      _loadChatHistoryTitles(); 
      if (_searchController.text.isNotEmpty) {
        final query = _searchController.text.toLowerCase();
        _chatHistoryTitles = _chatHistoryTitles.where((title) => title.toLowerCase().contains(query)).toList();
      }
    });
  }
  
  void _loadWelcomeMessage() {
    if (_messages.isNotEmpty) return;
    if (mounted) {
      setState(() {
        _messages.add(ChatMessage(
          id: 'init',
          content: 'Hello! I\'m Uruella AI. Ready to build. What\'s the task?',
          sender: MessageSender.ai,
          timestamp: DateTime.now(),
        ));
      });
    }
  }

  Future<void> _loadPersistedChat() async {
    final savedMessages = await _storageService.getChatMessages();
    final savedTitle = await _storageService.getData('chat_title');
    
    if (!mounted) return;

    if (savedMessages.isNotEmpty) {
      setState(() {
        if (savedTitle != null && savedTitle is String) {
          _currentChatTitle = savedTitle;
        }

        _messages = savedMessages.map((m) {
          return ChatMessage(
            id: m['id'] ?? DateTime.now().toString(),
            content: m['content'] ?? '',
            sender: m['sender'] == 'user' ? MessageSender.user : MessageSender.ai,
            timestamp: DateTime.parse(m['timestamp'] ?? DateTime.now().toIso8601String()),
          );
        }).toList();

        _apiHistory.clear();
        for (var msg in _messages.where((m) => m.id != 'init')) { 
           _apiHistory.add({
             'role': msg.sender == MessageSender.user ? 'user' : 'model',
             'content': msg.content
           });
        }
      });
      
      Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
    } else {
      _loadWelcomeMessage();
    }
  }

  Future<void> _saveChat() async {
    final messagesToSave = _messages.map((m) => {
      'id': m.id,
      'content': m.content,
      'sender': m.sender == MessageSender.user ? 'user' : 'ai',
      'timestamp': m.timestamp.toIso8601String(),
    }).toList();
    
    await _storageService.saveChatMessages(messagesToSave);
    await _storageService.saveData('chat_title', _currentChatTitle);
  }

  // ------------------------------------
  // --- AUDIO & VOICE METHODS ---
  // ------------------------------------
  
  // ⭐️ FIX: Ensuring play/stop sequence is correct for assets ⭐️
  Future<void> _playSendSound() async {
    try {
      await _audioPlayer.stop(); // Stop any currently playing audio
      await _audioPlayer.setAsset('assets/sounds/send.mp3');
      await _audioPlayer.play();
    } catch (e) {
      debugPrint("Error playing send sound: $e");
    }
  }

  Future<void> _playReceiveSound() async {
    try {
      await _audioPlayer.stop(); // Stop any currently playing audio
      await _audioPlayer.setAsset('assets/sounds/receive.mp3');
      await _audioPlayer.play();
    } catch (e) {
      debugPrint("Error playing receive sound: $e");
    }
  }

  // ⭐️ FIX: Production-ready "speak" logic ⭐️
  Future<void> _speakResponse(String text) async {
    // Uses the receive.mp3 as the confirmation sound, 
    // replacing the need for a separate TTS service implementation for this demo.
    await _playReceiveSound();
    
    // Optional: Could display a smaller, discreet notification
  }

  // ------------------------------------
  // --- USER INTERACTION METHODS ---
  // ------------------------------------

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 100,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
  
  void _handleNewChat() async {
    await _saveChat(); 
    await _storageService.clearChat();
    await _storageService.saveData('chat_title', "New Chat");
    _loadChatHistoryTitles();

    if (!mounted) return;
    
    setState(() {
      _messages.clear();
      _apiHistory.clear();
      _currentChatTitle = "New Chat";
      _isLoading = false;
      _uploadedFile = null;
      _fileBytes = null;
    });
    
    _loadWelcomeMessage();
    
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      Navigator.of(context).pop();
    }
  }
  
  Future<void> _handleFileUpload() async {
    try {
      await Permission.storage.request();
      
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'csv', 'xlsx', 'png', 'jpg', 'jpeg', 'txt'], 
      );

      if (result != null && result.files.single.path != null) {
        PlatformFile file = result.files.single;
        
        Uint8List? bytes;
        if (file.size < 10 * 1024 * 1024 && ['png', 'jpg', 'jpeg'].contains(file.extension?.toLowerCase())) { 
            bytes = File(file.path!).readAsBytesSync();
        }

        if (!mounted) return;

        setState(() {
          _uploadedFile = file;
          _fileBytes = bytes;
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("File loaded: ${file.name} (Ready to send)"),
            backgroundColor: const Color(0xFFB5A642),
        ));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("File Error: $e"),
          backgroundColor: Colors.redAccent,
        ));
      }
    }
  }
  
  void _handlePause() {
    setState(() {
      _isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Response paused. Tap Send to continue."),
      backgroundColor: Colors.white12,
    ));
  }
  
  void _handleVoiceInput() async {
    var status = await Permission.microphone.request();
    if (status.isDenied) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Microphone permission denied"),
          backgroundColor: Colors.redAccent,
        ));
      }
      return;
    }

    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) => debugPrint('Voice Status: $status'),
        onError: (errorNotification) => debugPrint('Voice Error: $errorNotification'),
      );

      if (!mounted) return;

      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) {
            setState(() {
              _textController.text = result.recognizedWords;
            });
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Speech recognition unavailable"),
          backgroundColor: Colors.redAccent,
        ));
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  void _openExpandedInput() {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
        backgroundColor: const Color(0xFF000000), 
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.white70),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (_textController.text.isNotEmpty) _sendMessage();
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)), 
                ),
                child: const Text("SEND", style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0.5)),
              ),
            )
          ],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(24),
          child: TextField(
            controller: _textController,
            maxLines: null,
            autofocus: true,
            style: const TextStyle(
              color: Colors.white, 
              fontSize: 18, 
              height: 1.6, 
              fontWeight: FontWeight.w400
            ),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              hintText: "Type your full prompt here...",
              hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(animation),
          child: child,
        );
      },
    ));
  }

  void _sendMessage() async {
    final text = _textController.text.trim();
    final hasFile = _uploadedFile != null;
    if (text.isEmpty && !hasFile) return;

    // 1. Prepare User UI Message and API Prompt
    String userContent = text;
    if (hasFile) {
      userContent = "📎 Uploaded File: ${_uploadedFile!.name}${text.isNotEmpty ? ' | Prompt: $text' : ''}";
    }
    final apiPrompt = text.isEmpty && hasFile ? "Analyze the uploaded file: ${_uploadedFile!.name}" : text;

    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: userContent,
      sender: MessageSender.user,
      timestamp: DateTime.now(),
    );
    
    final fileBytesForStream = _fileBytes;

    // 2. Initial UI update & History update + Send Sound
    await _playSendSound();
    setState(() {
      _messages.add(userMessage);
      _apiHistory.add({'role': 'user', 'content': apiPrompt}); 
      _textController.clear();
      _uploadedFile = null; 
      _fileBytes = null;
      _isLoading = true;
    });

    _scrollToBottom();
    _saveChat();

    // Summarize chat for title only if it's the FIRST actual user message
    if (_messages.length <= 2 && _messages.first.id == 'init') {
      _aiService.summarizeChat(text).then((title) {
        if (mounted) {
          setState(() => _currentChatTitle = title);
          _saveChat(); 
        }
      });
    }

    // 3. Start the streaming generation
    final stream = _aiService.processMessageStream(apiPrompt, history: _apiHistory, imageBytes: fileBytesForStream);
    
    final aiMessageId = (DateTime.now().millisecondsSinceEpoch + 1).toString();
    
    // Add an empty AI message to the list to hold the incoming stream
    setState(() {
      _messages.add(ChatMessage(
        id: aiMessageId,
        content: '', 
        sender: MessageSender.ai,
        timestamp: DateTime.now(),
      ));
    });

    String fullResponse = '';
    // 4. Consume the stream and update the last message in real-time (Typing Effect)
    await for (var chunk in stream) {
      if (mounted && _isLoading) {
        fullResponse += chunk;
        setState(() {
          final index = _messages.indexWhere((m) => m.id == aiMessageId);
          if (index != -1) {
            final updatedMessage = ChatMessage(
              id: _messages[index].id,
              content: fullResponse, 
              sender: MessageSender.ai,
              timestamp: _messages[index].timestamp,
            );
            _messages[index] = updatedMessage; 
          }
        });
        _scrollToBottom();
      } else if (!_isLoading) {
        break; 
      }
    }

    // 5. Final state cleanup + Receive Sound/Voice (AFTER TYPING IS COMPLETE)
    if (mounted) {
      if (_isVoiceModeEnabled && fullResponse.isNotEmpty) {
        // Voice mode enabled: play speech sound
        await _speakResponse(fullResponse);
      } else {
        // Voice mode disabled: play click sound
        await _playReceiveSound();
      }

      setState(() {
        _isLoading = false;
        if (fullResponse.isNotEmpty) {
          _apiHistory.add({'role': 'model', 'content': fullResponse});
        }
        _saveChat(); 
      });
    }
  }

  // ------------------------------------
  // --- WIDGET BUILDER METHODS ---
  // ------------------------------------

  Widget _buildAvatar({required bool isUser}) {
    return Container(
      width: 32, height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1.0,
        ),
      ),
      child: CircleAvatar(
        radius: 14,
        backgroundColor: Colors.transparent,
        child: isUser 
          ? const Icon(Icons.person, color: Colors.white70, size: 16)
          : Image.asset('assets/images/logo.png', fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white54),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            tooltip: 'Chat History',
          ),
          
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white54),
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.workflows),
            tooltip: 'Back to Workflows',
          ),
          
          const SizedBox(width: 12),
          
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'URUELLA A i',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                'Offline • Active', 
                style: TextStyle(color: Colors.white38, fontSize: 11),
              ),
            ],
          ),
          const Spacer(),
          
          // AI Voice Mode Toggle
          Tooltip(
            message: _isVoiceModeEnabled ? "AI Voice Mode: ON" : "AI Voice Mode: OFF",
            child: IconButton(
              icon: Icon(
                _isVoiceModeEnabled ? Icons.volume_up : Icons.volume_off, 
                color: _isVoiceModeEnabled ? const Color(0xFF00C7F9) : Colors.white54,
              ),
              onPressed: () {
                setState(() {
                  _isVoiceModeEnabled = !_isVoiceModeEnabled;
                });
              },
            ),
          ),

          IconButton(
            icon: const Icon(Icons.edit_square, color: Colors.white70),
            onPressed: _handleNewChat,
            tooltip: 'New Chat',
          ),
        ],
      ),
    );
  }

  Widget _buildFilePreview(PlatformFile file) {
     return Container(
       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
       margin: const EdgeInsets.only(bottom: 8),
       decoration: BoxDecoration(
         color: const Color(0xFFB5A642).withValues(alpha: 0.1),
         borderRadius: BorderRadius.circular(8),
       ),
       child: Row(
         mainAxisSize: MainAxisSize.min,
         children: [
           Icon(Icons.insert_drive_file, color: Colors.white.withValues(alpha: 0.7), size: 16),
           const SizedBox(width: 8),
           Flexible(
             child: Text(
               file.name,
               style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12),
               overflow: TextOverflow.ellipsis,
             ),
           ),
           IconButton(
             onPressed: () => setState(() { _uploadedFile = null; _fileBytes = null; }),
             icon: Icon(Icons.close, size: 14, color: Colors.white.withValues(alpha: 0.5)),
           )
         ],
       ),
     );
  }

  Widget _buildReactionFooter(ChatMessage message) {
    if (message.content.trim().isEmpty) return const SizedBox.shrink(); 

    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () { 
              Clipboard.setData(ClipboardData(text: message.content)); 
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text("Copied AI response!", style: TextStyle(color: Colors.black, fontSize: 12)),
                duration: const Duration(milliseconds: 800),
                backgroundColor: Colors.white.withValues(alpha: 0.9), 
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ));
            },
            child: Icon(Icons.copy_outlined, size: 14, color: Colors.white.withValues(alpha: 0.3)),
          ),
          const SizedBox(width: 12),
          Icon(Icons.thumb_up_alt_outlined, size: 14, color: Colors.white.withValues(alpha: 0.3)),
          const SizedBox(width: 12),
          Icon(Icons.share_outlined, size: 14, color: Colors.white.withValues(alpha: 0.3)),
          const SizedBox(width: 12),
          Icon(Icons.select_all, size: 14, color: Colors.white.withValues(alpha: 0.3)),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message, bool isUser) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 280),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: isUser
            ? const LinearGradient(
                colors: [Color(0xFF333333), Color(0xFF1A1A1A)], 
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: isUser ? null : Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: isUser ? const Radius.circular(20) : const Radius.circular(4), 
          bottomRight: isUser ? const Radius.circular(4) : const Radius.circular(20), 
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isUser && message.content.startsWith('📎 Uploaded File:'))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.content.split('|')[0],
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontStyle: FontStyle.italic, fontSize: 13),
                ),
                if (message.content.split('|').length > 1)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      message.content.split('|')[1].trim().replaceAll('Prompt: ', ''), 
                      style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.4),
                    ),
                  ),
              ],
            )
          else if (isUser)
            Text(
              message.content,
              style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.4),
            )
          else
            _renderSmartAIContent(message.content),

          const SizedBox(height: 4),
          Text(
            '${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.3),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildMessageRow(ChatMessage message) {
    final isUser = message.sender == MessageSender.user;
    final isStreaming = !isUser && _isLoading && message.content.isEmpty; 

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            _buildAvatar(isUser: false),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isStreaming ? _buildTypingIndicatorContent() : _buildMessageBubble(message, isUser),
                if (!isStreaming) _buildReactionFooter(message),
              ],
            ),
          ],

          if (isUser) ...[
            Flexible(child: _buildMessageBubble(message, isUser)),
            const SizedBox(width: 8),
            _buildAvatar(isUser: true),
          ],
        ],
      ),
    );
  }

  Widget _buildTypingIndicatorContent() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      constraints: const BoxConstraints(maxWidth: 280),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20),
          bottomRight: Radius.circular(20), bottomLeft: Radius.circular(4),
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: const SizedBox(
        width: 16, height: 16,
        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white54),
      ),
    );
  }

  Widget _buildInputArea() {
    final bool sendDisabled = _isLoading || (_textController.text.trim().isEmpty && _uploadedFile == null);
    
    final double bottomPadding = MediaQuery.of(context).padding.bottom == 0 ? 20 : MediaQuery.of(context).padding.bottom;
    
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, bottomPadding), 
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E), 
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            borderRadius: BorderRadius.circular(35),
          ),
          child: Column(
            children: [
              if (_uploadedFile != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
                  child: _buildFilePreview(_uploadedFile!),
                ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.end, 
                children: [
                  IconButton(
                    icon: const Icon(Icons.fullscreen, color: Colors.white54), 
                    onPressed: _openExpandedInput,
                    tooltip: "Full Screen Editor",
                  ),
                  
                  IconButton(
                    icon: const Icon(Icons.attach_file, color: Colors.white54), 
                    onPressed: _handleFileUpload,
                    tooltip: "Add File",
                  ),
                  
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      onChanged: (value) => setState(() {}),
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white, 
                      minLines: 1,
                      maxLines: 5, 
                      decoration: InputDecoration(
                        filled: false, 
                        hintText: 'Ask Uruella...',
                        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      ),
                    ),
                  ),
                  
                  if (_textController.text.isEmpty && _uploadedFile == null)
                      IconButton(
                      icon: Icon(_isListening ? Icons.mic : Icons.mic_none, color: _isListening ? Colors.redAccent : Colors.white54),
                      onPressed: _handleVoiceInput,
                    ),

                  Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: sendDisabled ? Colors.white.withValues(alpha: 0.3) : Colors.white,
                    ),
                    child: IconButton(
                      icon: Icon(
                        _isLoading ? Icons.pause : Icons.arrow_upward_rounded, 
                        color: _isLoading ? Colors.white : Colors.black, 
                        size: 20
                      ),
                      onPressed: _isLoading ? _handlePause : (sendDisabled ? null : _sendMessage),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderSmartAIContent(String content) {
    List<Widget> widgets = [];
    final parts = content.split('```');
    
    for (int i = 0; i < parts.length; i++) {
      String part = parts[i];
      if (part.trim().isEmpty) continue;

      if (i % 2 == 1) {
        // CODE BLOCK
        String language = 'Code';
        String code = part;
        if (part.contains('\n')) {
          final firstLineEnd = part.indexOf('\n');
          language = part.substring(0, firstLineEnd).trim();
          if (language.isEmpty) language = "Terminal";
          code = part.substring(firstLineEnd + 1).trim();
        }

        widgets.add(Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF000000),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(language.toUpperCase(), style: const TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: code));
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Copied!"),
                          duration: Duration(milliseconds: 800),
                          backgroundColor: Color(0xFF1E1E1E),
                        ));
                      },
                      child: const Icon(Icons.copy, size: 14, color: Colors.white54),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(code, 
                    style: const TextStyle(fontFamily: 'monospace', color: Color(0xFFD4D4D4), fontSize: 12)
                  ),
                ),
              ),
            ],
          ),
        ));
      } else {
        widgets.add(_renderRichText(part));
      }
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
  }

  Widget _renderRichText(String text) {
    if (text.trim().startsWith('#')) {
      int hashCount = text.split(' ').first.length;
      double fontSize = 20.0 - (hashCount * 2);
      fontSize = fontSize < 14 ? 14 : fontSize;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          text.replaceAll(RegExp(r'^#+\s*'), '').trim(),
          style: TextStyle(color: Colors.white, fontSize: fontSize, fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
      );
    }
    
    List<InlineSpan> spans = [];
    final split = text.split('**');
    
    for (int i = 0; i < split.length; i++) {
      if (i % 2 == 1) {
        spans.add(TextSpan(
          text: split[i], 
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
        ));
      } else {
        spans.add(TextSpan(
          text: split[i],
          style: const TextStyle(color: Colors.white, height: 1.4, fontSize: 15)
        ));
      }
    }

    return RichText(text: TextSpan(children: spans));
  }


  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topLeft,
          radius: 1.5,
          colors: [
              Color(0xFF1E1E1E), 
              Color(0xFF121212),
              Colors.black,
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingDoodles() {
    return Positioned(
      top: 100,
      right: -50,
      child: AnimatedBuilder(
        animation: _doodleMoveAnimation,
        builder: (context, child) => Transform.translate(
          offset: Offset(0, _doodleMoveAnimation.value),
          child: Opacity(
            opacity: 0.03,
            child: SvgPicture.asset(
              'assets/images/undraw_chat_qmyo.svg',
              width: 300,
              placeholderBuilder: (_) => const SizedBox(width: 300, height: 200),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassSidebar() {
    return Drawer(
      backgroundColor: Colors.transparent,
      width: MediaQuery.of(context).size.width * 0.80,
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF121212).withValues(alpha: 0.90),
                border: Border(right: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(24, 60, 24, 30),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 42, height: 42,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                          ),
                          child: ClipOval(
                             child: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('URUELLA AI', 
                              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: 1.0)
                            ),
                            Text('Premium Eco-System', 
                              style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.w500)
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white70),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: 'Search chats...',
                    hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.4)),
                    prefixIcon: Icon(Icons.search, color: Colors.white.withValues(alpha: 0.6)),
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.05),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildSidebarItem(Icons.add, 'New Chat', isHighlight: true, onTap: _handleNewChat),
                    const Divider(color: Colors.white10, indent: 20, endIndent: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
                      child: Text("HISTORY", 
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                      ),
                    ),
                    ...(_chatHistoryTitles).map((title) {
                      return _buildSidebarItem(
                        Icons.chat_bubble_outline, 
                        title, 
                        isHighlight: title == _currentChatTitle, 
                        onTap: (){ Navigator.pop(context); }
                      );
                    }),
                    const SizedBox(height: 20),
                    const Divider(color: Colors.white10, indent: 20, endIndent: 20),
                    _buildSidebarItem(Icons.folder_open, 'My Files', onTap: (){}),
                    _buildSidebarItem(Icons.settings, 'Settings', onTap: (){ 
                      Navigator.pop(context);
                      Navigator.of(context).pushNamed(AppRoutes.settings);
                    }),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String title, {bool isHighlight = false, required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.white.withValues(alpha: 0.05),
        highlightColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: isHighlight ? BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            border: const Border(left: BorderSide(color: Colors.white, width: 2)),
          ) : null,
          child: Row(
            children: [
              Icon(icon, color: isHighlight ? Colors.white : Colors.white54, size: 18),
              const SizedBox(width: 16),
              Expanded(
                child: Text(title, 
                  style: TextStyle(
                    color: isHighlight ? Colors.white : Colors.white54, 
                    fontSize: 13, 
                    fontWeight: isHighlight ? FontWeight.w600 : FontWeight.normal
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double inputAreaRoughHeight = 70.0;
    final double bottomSystemPadding = MediaQuery.of(context).padding.bottom;
    final double inputAreaOffset = inputAreaRoughHeight + bottomSystemPadding + 20;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF000000), 
      extendBodyBehindAppBar: true,
      drawer: _buildGlassSidebar(), 
      body: Stack(
        children: [
          _buildBackground(),
          _buildFloatingDoodles(),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(color: Colors.transparent),
          ),
          
          SafeArea(
            child: Column(
              children: [
                _buildHeader(), 
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.fromLTRB(16, 20, 16, inputAreaOffset), 
                    itemCount: _messages.length, 
                    itemBuilder: (context, index) {
                      return _buildMessageRow(_messages[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
          
          _buildInputArea(),
        ],
      ),
    );
  }
}