// import 'dart:async';
// import 'dart:io';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:permission_handler/permission_handler.dart';
// import 'package:vetto_ai/models/chat_message.dart';
// import 'package:vetto_ai/services/ai_service.dart';
// import 'package:vetto_ai/services/offline_storage_service.dart';
// import 'package:vetto_ai/widgets/glass_card.dart';

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
  
//   // Voice Input
//   final stt.SpeechToText _speech = stt.SpeechToText();
//   bool _isListening = false;

//   bool _isLoading = false;
//   String _currentChatTitle = "New Chat";
  
//   late AnimationController _bgController;
//   late Animation<double> _doodleMoveAnimation;

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
//   }

//   Future<void> _initServices() async {
//     await _aiService.initialize();
//     await _storageService.initialize();
//     if (mounted) {
//       _loadPersistedChat(); 
//     }
//   }

//   @override
//   void dispose() {
//     _bgController.dispose();
//     _textController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   // --- PERSISTENCE ---

//   Future<void> _loadPersistedChat() async {
//     // 1. Load Messages
//     final savedMessages = await _storageService.getChatMessages();
//     // 2. Load Title
//     final savedTitle = await _storageService.getData('chat_title');
    
//     if (!mounted) return;

//     if (savedMessages.isNotEmpty) {
//       setState(() {
//         // Restore Title
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
//         for (var msg in _messages) {
//           _apiHistory.add({
//             'role': msg.sender == MessageSender.user ? 'user' : 'model',
//             'content': msg.content
//           });
//         }
//       });
      
//       // Scroll to bottom after rendering
//       Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
//     } else {
//       // Only load welcome message if truly empty
//       _loadWelcomeMessage();
//     }
//   }

//   Future<void> _saveChat() async {
//     // Save Messages
//     final messagesToSave = _messages.map((m) => {
//       'id': m.id,
//       'content': m.content,
//       'sender': m.sender == MessageSender.user ? 'user' : 'ai',
//       'timestamp': m.timestamp.toIso8601String(),
//     }).toList();
    
//     await _storageService.saveChatMessages(messagesToSave);
    
//     // Save Title
//     await _storageService.saveData('chat_title', _currentChatTitle);
//   }

//   void _loadWelcomeMessage() {
//     if (_messages.isNotEmpty) return;
//     if (mounted) {
//       setState(() {
//         _messages.add(ChatMessage(
//           id: 'init',
//           content: 'Hello! I\'m Vetto AI. Ready to build. What\'s the task?',
//           sender: MessageSender.ai,
//           timestamp: DateTime.now(),
//         ));
//       });
//     }
//   }

//   void _scrollToBottom() {
//     if (_scrollController.hasClients) {
//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent + 100, // Add offset to ensure bottom
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     }
//   }

//   // --- ACTIONS ---

//   void _handleNewChat() async {
//     await _storageService.clearChat();
//     // Clear title storage too
//     // (Assuming saveData overwrites, or you might want a clearKey method, 
//     // but setting it to "New Chat" works for next load)
//     await _storageService.saveData('chat_title', "New Chat");

//     if (!mounted) return;
    
//     setState(() {
//       _messages.clear();
//       _apiHistory.clear();
//       _currentChatTitle = "New Chat";
//       _isLoading = false;
//     });
    
//     _loadWelcomeMessage();
    
//     if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
//       Navigator.of(context).pop();
//     }
//   }

//   Future<void> _handleFileUpload() async {
//     try {
//       await Permission.storage.request();
      
//       FilePickerResult? result = await FilePicker.platform.pickFiles();

//       if (result != null && result.files.single.path != null) {
//         File file = File(result.files.single.path!);
//         String fileName = result.files.single.name;
        
//         if (!mounted) return;

//         // 1. Show user file message
//         final fileMsg = ChatMessage(
//           id: DateTime.now().millisecondsSinceEpoch.toString(),
//           content: "📎 Uploaded File: $fileName",
//           sender: MessageSender.user,
//           timestamp: DateTime.now(),
//         );

//         setState(() {
//           _messages.add(fileMsg);
//           _isLoading = true;
//         });
//         _scrollToBottom();
//         _saveChat();

//         // 2. Read Content
//         String fileContent = "[Binary File]";
//         try {
//            fileContent = await file.readAsString();
//         } catch (e) {
//            fileContent = "[Image/Binary Data - Text analysis skipped]";
//         }

//         // 3. Process with AI
//         final prompt = "I have uploaded a file named '$fileName'. Content:\n\n$fileContent\n\nPlease analyze this.";
//         _apiHistory.add({'role': 'user', 'content': prompt});
        
//         final responseText = await _aiService.processMessage(prompt, history: _apiHistory);

//         if (mounted) {
//           final aiMsg = ChatMessage(
//             id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
//             content: responseText,
//             sender: MessageSender.ai,
//             timestamp: DateTime.now(),
//           );

//           setState(() {
//             _messages.add(aiMsg);
//             _apiHistory.add({'role': 'model', 'content': responseText});
//             _isLoading = false;
//           });
//           _scrollToBottom();
//           _saveChat();
//         }
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

//   void _handleVoiceInput() async {
//     // Ensure permissions
//     var status = await Permission.microphone.request();
//     if (status.isDenied) {
//        if (mounted) {
//          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//            content: Text("Microphone permission denied"),
//            backgroundColor: Colors.redAccent,
//          ));
//        }
//        return;
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

//   void _openExpandedInput() {
//     Navigator.of(context).push(PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
//         backgroundColor: const Color(0xFF121212), // Match app background
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
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                 ),
//                 child: const Text("Send", style: TextStyle(fontWeight: FontWeight.bold)),
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
//             decoration: const InputDecoration(
//               hintText: "Type your full prompt here...",
//               hintStyle: TextStyle(color: Colors.white24),
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

//   void _handleSuggestionClick(String prompt) {
//     _textController.text = prompt;
//     _sendMessage();
//   }

//   void _sendMessage() async {
//     final text = _textController.text.trim();
//     if (text.isEmpty) return;

//     final userMessage = ChatMessage(
//       id: DateTime.now().millisecondsSinceEpoch.toString(),
//       content: text,
//       sender: MessageSender.user,
//       timestamp: DateTime.now(),
//     );

//     // Only summarize if it's the FIRST user message (excluding welcome msg)
//     if (_messages.length <= 1) {
//       _aiService.summarizeChat(text).then((title) {
//         if (mounted) {
//           setState(() => _currentChatTitle = title);
//           _saveChat(); // Save new title immediately
//         }
//       });
//     }

//     setState(() {
//       _messages.add(userMessage);
//       _apiHistory.add({'role': 'user', 'content': text});
//       _textController.clear();
//       _isLoading = true;
//     });

//     _scrollToBottom();
//     _saveChat();

//     final responseText = await _aiService.processMessage(text, history: _apiHistory);

//     if (mounted) {
//       final aiMessage = ChatMessage(
//         id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
//         content: responseText,
//         sender: MessageSender.ai,
//         timestamp: DateTime.now(),
//       );

//       setState(() {
//         _messages.add(aiMessage);
//         _apiHistory.add({'role': 'model', 'content': responseText});
//         _isLoading = false;
//       });
//       _scrollToBottom();
//       _saveChat();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: const Color(0xFF121212), // Premium Matte Charcoal
//       extendBodyBehindAppBar: true,
//       drawer: _buildGlassSidebar(), 
//       body: Stack(
//         children: [
//           _buildBackground(),
//           _buildFloatingDoodles(),
//           // Global Blur
//           BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//             child: Container(color: Colors.transparent),
//           ),
//           SafeArea(
//             child: Column(
//               children: [
//                 _buildHeader(), 
//                 Expanded(
//                   child: Stack(
//                     children: [
//                       // The List
//                       ListView.builder(
//                         controller: _scrollController,
//                         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//                         itemCount: _messages.length + (_isLoading ? 1 : 0),
//                         itemBuilder: (context, index) {
//                           if (index < _messages.length) {
//                             return _buildMessageRow(_messages[index]);
//                           } else {
//                             return _buildTypingIndicatorRow();
//                           }
//                         },
//                       ),
                      
//                       // Suggestions: ONLY show if messages list is basically empty (just welcome msg)
//                       if (_messages.length <= 1 && !_isLoading)
//                         _buildEmptyStateSuggestions(),
//                     ],
//                   ),
//                 ),
//                 _buildInputArea(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // --- WIDGETS ---

//   Widget _buildEmptyStateSuggestions() {
//     return Center(
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Clean suggestions: No Emojis in text, distinct Icons
//             _buildSuggestionChip("Draft Proposal", "Write a business proposal...", Icons.edit_note),
//             _buildSuggestionChip("Create Image", "Generate a concept art idea...", Icons.image_outlined),
//             _buildSuggestionChip("Debug Code", "Fix this Flutter widget...", Icons.code),
//             _buildSuggestionChip("Analyze Data", "Summarize this text...", Icons.analytics_outlined),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSuggestionChip(String title, String subtitle, IconData icon) {
//     return GestureDetector(
//       onTap: () => _handleSuggestionClick(subtitle),
//       child: Container(
//         width: 280,
//         margin: const EdgeInsets.symmetric(vertical: 6),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//         decoration: BoxDecoration(
//           color: Colors.white.withValues(alpha: 0.03), // Very subtle fill
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
//         ),
//         child: Row(
//           children: [
//             // Icon Only
//             Icon(icon, color: Colors.white70, size: 20),
//             const SizedBox(width: 16),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Clean Text (No Emoji)
//                 Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
//                 Text(subtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 11)),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBackground() {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: RadialGradient(
//           center: Alignment.topLeft,
//           radius: 1.5,
//           colors: [
//              Color(0xFF1E1E1E), // Spotlight
//              Color(0xFF121212), // Obsidian
//              Colors.black,
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

//   // --- SIDEBAR (Premium Glass) ---
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
//                   children: [
//                     // LOGO ONLY (Consolidated Branding)
//                     Container(
//                       width: 42, height: 42,
//                       padding: const EdgeInsets.all(2),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
//                       ),
//                       child: ClipOval(
//                         child: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text('VETTO AI', 
//                           style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: 1.0)
//                         ),
//                         Text('Premium Eco-System', 
//                           style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 10, fontWeight: FontWeight.w500)
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
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
//                     _buildSidebarItem(Icons.chat_bubble_outline, _currentChatTitle, onTap: (){ Navigator.pop(context); }),
//                     const SizedBox(height: 20),
//                     const Divider(color: Colors.white10, indent: 20, endIndent: 20),
//                     _buildSidebarItem(Icons.folder_open, 'My Files', onTap: (){}),
//                     _buildSidebarItem(Icons.settings, 'Settings', onTap: (){}),
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

//   // --- HEADER ---
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
//           ),
//           const SizedBox(width: 12),
//           const Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Vetto Assistant',
//                 style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
//               ),
//               Text(
//                 'Online • Active',
//                 style: TextStyle(color: Colors.white38, fontSize: 11),
//               ),
//             ],
//           ),
//           const Spacer(),
//           // NEW CHAT ICON (Create/Edit style instead of Plus)
//           IconButton(
//             icon: const Icon(Icons.edit_square, color: Colors.white70), // Changed to Edit Square
//             onPressed: _handleNewChat,
//             tooltip: 'New Chat',
//           ),
//         ],
//       ),
//     );
//   }

//   // --- MESSAGES ---

//   Widget _buildMessageRow(ChatMessage message) {
//     final isUser = message.sender == MessageSender.user;
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 20),
//       child: Row(
//         mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           if (!isUser) ...[
//             _buildAvatar(isUser: false),
//             const SizedBox(width: 8),
//           ],
//           Flexible(child: _buildMessageBubble(message, isUser)),
//           if (isUser) ...[
//             const SizedBox(width: 8),
//             _buildAvatar(isUser: true),
//           ],
//         ],
//       ),
//     );
//   }

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
//           // FIXED CURVE: Bottom Left for AI, Bottom Right for User
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
//           if (isUser)
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
//     if (text.trim().startsWith('###')) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8),
//         child: Text(
//           text.replaceAll('#', '').trim(),
//           style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.5),
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

//   Widget _buildTypingIndicatorRow() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 20),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           _buildAvatar(isUser: false),
//           const SizedBox(width: 8),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             decoration: BoxDecoration(
//               color: Colors.white.withValues(alpha: 0.05),
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(20), topRight: Radius.circular(20),
//                 bottomRight: Radius.circular(20), bottomLeft: Radius.circular(4),
//               ),
//               border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
//             ),
//             child: const SizedBox(
//               width: 16, height: 16,
//               child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white54),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // --- INPUT AREA ---

//   Widget _buildInputArea() {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
//       child: GlassCard(
//         opacity: 0.03, 
//         borderRadius: 35,
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
//             borderRadius: BorderRadius.circular(35),
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.end, 
//             children: [
//               // FULLSCREEN TOGGLE
//               IconButton(
//                 icon: const Icon(Icons.fullscreen, color: Colors.white54), 
//                 onPressed: _openExpandedInput,
//                 tooltip: "Full Screen Editor",
//               ),
              
//               IconButton(
//                 icon: const Icon(Icons.attach_file, color: Colors.white54), 
//                 onPressed: _handleFileUpload,
//                 tooltip: "Add File",
//               ),
              
//               Expanded(
//                 child: TextField(
//                   controller: _textController,
//                   style: const TextStyle(color: Colors.white),
//                   cursorColor: Colors.white, 
//                   minLines: 1,
//                   maxLines: 5, 
//                   decoration: InputDecoration(
//                     filled: false, // TRANSPARENT
//                     hintText: 'Ask Vetto...',
//                     hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
//                     border: InputBorder.none,
//                     enabledBorder: InputBorder.none,
//                     focusedBorder: InputBorder.none,
//                     contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
//                   ),
//                 ),
//               ),
              
//               if (_textController.text.isEmpty)
//                  IconButton(
//                   icon: Icon(_isListening ? Icons.mic : Icons.mic_none, color: _isListening ? Colors.redAccent : Colors.white54),
//                   onPressed: _handleVoiceInput,
//                 ),

//               Container(
//                 margin: const EdgeInsets.all(2),
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.white,
//                 ),
//                 child: IconButton(
//                   icon: const Icon(Icons.arrow_upward_rounded, color: Colors.black, size: 20),
//                   onPressed: _sendMessage,
//                 ),
//               ),
//             ],
//           ),
//         ),
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
import 'package:vetto_ai/models/chat_message.dart';
import 'package:vetto_ai/services/ai_service.dart';
import 'package:vetto_ai/services/offline_storage_service.dart';
import 'package:vetto_ai/widgets/glass_card.dart';

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
  
  // Voice Input
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;

  bool _isLoading = false;
  String _currentChatTitle = "New Chat";
  
  late AnimationController _bgController;
  late Animation<double> _doodleMoveAnimation;

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
  }

  Future<void> _initServices() async {
    await _aiService.initialize();
    await _storageService.initialize();
    if (mounted) {
      _loadPersistedChat(); 
    }
  }

  @override
  void dispose() {
    _bgController.dispose();
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // --- PERSISTENCE ---

  Future<void> _loadPersistedChat() async {
    // 1. Load Messages
    final savedMessages = await _storageService.getChatMessages();
    // 2. Load Title
    final savedTitle = await _storageService.getData('chat_title');
    
    if (!mounted) return;

    if (savedMessages.isNotEmpty) {
      setState(() {
        // Restore Title
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
        for (var msg in _messages) {
          _apiHistory.add({
            'role': msg.sender == MessageSender.user ? 'user' : 'model',
            'content': msg.content
          });
        }
      });
      
      // Scroll to bottom after rendering
      Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
    } else {
      // Only load welcome message if truly empty
      _loadWelcomeMessage();
    }
  }

  Future<void> _saveChat() async {
    // Save Messages
    final messagesToSave = _messages.map((m) => {
      'id': m.id,
      'content': m.content,
      'sender': m.sender == MessageSender.user ? 'user' : 'ai',
      'timestamp': m.timestamp.toIso8601String(),
    }).toList();
    
    await _storageService.saveChatMessages(messagesToSave);
    
    // Save Title
    await _storageService.saveData('chat_title', _currentChatTitle);
  }

  void _loadWelcomeMessage() {
    if (_messages.isNotEmpty) return;
    if (mounted) {
      setState(() {
        _messages.add(ChatMessage(
          id: 'init',
          content: 'Hello! I\'m Vetto AI. Ready to build. What\'s the task?',
          sender: MessageSender.ai,
          timestamp: DateTime.now(),
        ));
      });
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 100, // Add offset to ensure bottom
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  // --- ACTIONS ---

  void _handleNewChat() async {
    await _storageService.clearChat();
    // Clear title storage too
    await _storageService.saveData('chat_title', "New Chat");

    if (!mounted) return;
    
    setState(() {
      _messages.clear();
      _apiHistory.clear();
      _currentChatTitle = "New Chat";
      _isLoading = false;
    });
    
    _loadWelcomeMessage();
    
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _handleFileUpload() async {
    try {
      await Permission.storage.request();
      
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null && result.files.single.path != null) {
        File file = File(result.files.single.path!);
        String fileName = result.files.single.name;
        
        if (!mounted) return;

        // 1. Show user file message
        final fileMsg = ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          content: "📎 Uploaded File: $fileName",
          sender: MessageSender.user,
          timestamp: DateTime.now(),
        );

        setState(() {
          _messages.add(fileMsg);
          _isLoading = true;
        });
        _scrollToBottom();
        _saveChat();

        // 2. Read Content
        String fileContent = "[Binary File]";
        try {
           fileContent = await file.readAsString();
        } catch (e) {
           fileContent = "[Image/Binary Data - Text analysis skipped]";
        }

        // 3. Process with AI
        final prompt = "I have uploaded a file named '$fileName'. Content:\n\n$fileContent\n\nPlease analyze this.";
        _apiHistory.add({'role': 'user', 'content': prompt});
        
        final responseText = await _aiService.processMessage(prompt, history: _apiHistory);

        if (mounted) {
          final aiMsg = ChatMessage(
            id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
            content: responseText,
            sender: MessageSender.ai,
            timestamp: DateTime.now(),
          );

          setState(() {
            _messages.add(aiMsg);
            _apiHistory.add({'role': 'model', 'content': responseText});
            _isLoading = false;
          });
          _scrollToBottom();
          _saveChat();
        }
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

  void _handleVoiceInput() async {
    // Ensure permissions
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
        backgroundColor: const Color(0xFF121212), // Match app background
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text("Send", style: TextStyle(fontWeight: FontWeight.bold)),
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
            decoration: const InputDecoration(
              hintText: "Type your full prompt here...",
              hintStyle: TextStyle(color: Colors.white24),
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
    if (text.isEmpty) return;

    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: text,
      sender: MessageSender.user,
      timestamp: DateTime.now(),
    );

    // Only summarize if it's the FIRST user message (excluding welcome msg)
    if (_messages.length <= 1) {
      _aiService.summarizeChat(text).then((title) {
        if (mounted) {
          setState(() => _currentChatTitle = title);
          _saveChat(); // Save new title immediately
        }
      });
    }

    setState(() {
      _messages.add(userMessage);
      _apiHistory.add({'role': 'user', 'content': text});
      _textController.clear();
      _isLoading = true;
    });

    _scrollToBottom();
    _saveChat();

    final responseText = await _aiService.processMessage(text, history: _apiHistory);

    if (mounted) {
      final aiMessage = ChatMessage(
        id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
        content: responseText,
        sender: MessageSender.ai,
        timestamp: DateTime.now(),
      );

      setState(() {
        _messages.add(aiMessage);
        _apiHistory.add({'role': 'model', 'content': responseText});
        _isLoading = false;
      });
      _scrollToBottom();
      _saveChat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF121212), // Premium Matte Charcoal
      extendBodyBehindAppBar: true,
      drawer: _buildGlassSidebar(), 
      body: Stack(
        children: [
          _buildBackground(),
          _buildFloatingDoodles(),
          // Global Blur
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(color: Colors.transparent),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(), 
                Expanded(
                  child: Stack(
                    children: [
                      // The List
                      ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                        itemCount: _messages.length + (_isLoading ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < _messages.length) {
                            return _buildMessageRow(_messages[index]);
                          } else {
                            return _buildTypingIndicatorRow();
                          }
                        },
                      ),
                      
                      // Removed Suggestions Block here
                    ],
                  ),
                ),
                _buildInputArea(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGETS ---

  // Removed _buildEmptyStateSuggestions and _buildSuggestionChip widgets

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topLeft,
          radius: 1.5,
          colors: [
             Color(0xFF1E1E1E), // Spotlight
             Color(0xFF121212), // Obsidian
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

  // --- SIDEBAR (Premium Glass) ---
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
                  children: [
                    // LOGO ONLY (Consolidated Branding)
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('VETTO AI', 
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: 1.0)
                        ),
                        Text('Premium Eco-System', 
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 10, fontWeight: FontWeight.w500)
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
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
                    _buildSidebarItem(Icons.chat_bubble_outline, _currentChatTitle, onTap: (){ Navigator.pop(context); }),
                    const SizedBox(height: 20),
                    const Divider(color: Colors.white10, indent: 20, endIndent: 20),
                    _buildSidebarItem(Icons.folder_open, 'My Files', onTap: (){}),
                    _buildSidebarItem(Icons.settings, 'Settings', onTap: (){}),
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

  // --- HEADER ---
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
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Vetto Assistant',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                'Online • Active',
                style: TextStyle(color: Colors.white38, fontSize: 11),
              ),
            ],
          ),
          const Spacer(),
          // NEW CHAT ICON (Create/Edit style instead of Plus)
          IconButton(
            icon: const Icon(Icons.edit_square, color: Colors.white70), // Changed to Edit Square
            onPressed: _handleNewChat,
            tooltip: 'New Chat',
          ),
        ],
      ),
    );
  }

  // --- MESSAGES ---

  Widget _buildMessageRow(ChatMessage message) {
    final isUser = message.sender == MessageSender.user;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            _buildAvatar(isUser: false),
            const SizedBox(width: 8),
          ],
          Flexible(child: _buildMessageBubble(message, isUser)),
          if (isUser) ...[
            const SizedBox(width: 8),
            _buildAvatar(isUser: true),
          ],
        ],
      ),
    );
  }

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
          // FIXED CURVE: Bottom Left for AI, Bottom Right for User
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
          if (isUser)
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
    if (text.trim().startsWith('###')) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          text.replaceAll('#', '').trim(),
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.5),
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

  Widget _buildTypingIndicatorRow() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildAvatar(isUser: false),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
          ),
        ],
      ),
    );
  }

  // --- INPUT AREA ---

  Widget _buildInputArea() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: GlassCard(
        opacity: 0.03, 
        borderRadius: 35,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            borderRadius: BorderRadius.circular(35),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end, 
            children: [
              // FULLSCREEN TOGGLE
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
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white, 
                  minLines: 1,
                  maxLines: 5, 
                  decoration: InputDecoration(
                    filled: false, // TRANSPARENT
                    hintText: 'Ask Vetto...',
                    hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  ),
                ),
              ),
              
              if (_textController.text.isEmpty)
                 IconButton(
                  icon: Icon(_isListening ? Icons.mic : Icons.mic_none, color: _isListening ? Colors.redAccent : Colors.white54),
                  onPressed: _handleVoiceInput,
                ),

              Container(
                margin: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_upward_rounded, color: Colors.black, size: 20),
                  onPressed: _sendMessage,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}