// // // import 'dart:ui';
// // import 'package:flutter/material.dart';
// // import 'package:vetto_ai/widgets/glass_card.dart';
// // import 'package:vetto_ai/widgets/vetto_scaffold.dart';

// // // 1. Local User Model (to ensure code runs without external dependency)
// // class User {
// //   final String name;
// //   final String email;
// //   final bool isOnline;
// //   final UserStats stats;
  
// //   User({required this.name, required this.email, required this.isOnline, required this.stats});
// // }

// // class UserStats {
// //   final int workflowCompletions;
// //   final int aiSuggestions;
// //   final int activeTasks;
// //   final int templatesCreated;

// //   const UserStats({
// //     required this.workflowCompletions,
// //     required this.aiSuggestions,
// //     required this.activeTasks,
// //     required this.templatesCreated,
// //   });
// // }

// // class ProfilePage extends StatefulWidget {
// //   const ProfilePage({super.key});

// //   @override
// //   State<ProfilePage> createState() => _ProfilePageState();
// // }

// // class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
// //   late User _user;
// //   late AnimationController _animationController;
// //   late Animation<double> _fadeAnimation;
// //   late Animation<double> _slideAnimation;

// //   // 3D Asset for Avatar Decoration
// //   // final String _avatarDecoration = "assets/images/3dgraphics/image-IU0LQSM0ihtW1G0IZB5bYpEFwG97T6.png";

// //   @override
// //   void initState() {
// //     super.initState();
// //     _user = _getMockUser();
    
// //     _animationController = AnimationController(
// //       duration: const Duration(milliseconds: 800),
// //       vsync: this,
// //     );

// //     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
// //       CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
// //     );

// //     _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
// //       CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
// //     );

// //     _animationController.forward();
// //   }

// //   @override
// //   void dispose() {
// //     _animationController.dispose();
// //     super.dispose();
// //   }

// //   User _getMockUser() {
// //     return User(
// //       name: 'Alex Chen',
// //       email: 'alex.chen@vetto.ai',
// //       isOnline: true,
// //       stats: const UserStats(
// //         workflowCompletions: 42,
// //         aiSuggestions: 128,
// //         activeTasks: 7,
// //         templatesCreated: 15,
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return VettoScaffold(
// //       // We use the VettoScaffold to get the background gradients/doodles
// //       body: SafeArea(
// //         child: AnimatedBuilder(
// //           animation: _animationController,
// //           builder: (context, child) {
// //             return Transform.translate(
// //               offset: Offset(0, _slideAnimation.value),
// //               child: Opacity(
// //                 opacity: _fadeAnimation.value,
// //                 child: ListView(
// //                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
// //                   children: [
// //                     // Header
// //                     _buildProfileHeader(),
// //                     const SizedBox(height: 24),
                    
// //                     // Stats
// //                     _buildSectionTitle('Overview'),
// //                     _buildStatsGrid(),
                    
// //                     const SizedBox(height: 24),
                    
// //                     // Activity
// //                     _buildSectionTitle('Recent Activity'),
// //                     _buildRecentActivity(),

// //                      const SizedBox(height: 40), // Bottom padding
// //                   ],
// //                 ),
// //               ),
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildSectionTitle(String title) {
// //     return Padding(
// //       padding: const EdgeInsets.only(bottom: 12, left: 4),
// //       child: Text(
// //         title.toUpperCase(),
// //         style: const TextStyle(
// //           color: Color(0xFF8DA385), // Sage Green
// //           fontSize: 12,
// //           fontWeight: FontWeight.bold,
// //           letterSpacing: 1.2,
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildProfileHeader() {
// //     return GlassCard(
// //       padding: const EdgeInsets.all(20),
// //       child: Row(
// //         children: [
// //           // Avatar Stack
// //           Stack(
// //             alignment: Alignment.center,
// //             children: [
// //               // Decorative Glow
// //               Container(
// //                 width: 70,
// //                 height: 70,
// //                 decoration: BoxDecoration(
// //                   shape: BoxShape.circle,
// //                   boxShadow: [
// //                     BoxShadow(
// //                       color: const Color(0xFFB5A642).withValues(alpha: 0.3), // Gold glow
// //                       blurRadius: 20,
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               // Main Avatar
// //               Container(
// //                 width: 80,
// //                 height: 80,
// //                 decoration: BoxDecoration(
// //                   shape: BoxShape.circle,
// //                   border: Border.all(color: Colors.white, width: 2),
// //                   image: const DecorationImage(
// //                     image: AssetImage('assets/images/logo.png'), // Placeholder
// //                     fit: BoxFit.cover,
// //                   ),
// //                 ),
// //               ),
// //               // Online Indicator
// //               Positioned(
// //                 bottom: 2,
// //                 right: 2,
// //                 child: Container(
// //                   width: 18,
// //                   height: 18,
// //                   decoration: BoxDecoration(
// //                     color: _user.isOnline ? const Color.fromARGB(255, 65, 159, 44) : Colors.grey,
// //                     shape: BoxShape.circle,
// //                     border: Border.all(color: Colors.black, width: 2),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //           const SizedBox(width: 20),
          
// //           // Text Info
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Row(
// //                   children: [
// //                     Text(
// //                       _user.name,
// //                       style: const TextStyle(
// //                         color: Colors.white,
// //                         fontSize: 22,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                     const SizedBox(width: 8),
// //                     const Icon(Icons.verified, color: Color(0xFFB5A642), size: 16), // Gold Verify
// //                   ],
// //                 ),
// //                 Text(
// //                   _user.email,
// //                   style: TextStyle(
// //                     color: Colors.white.withValues(alpha: 0.6),
// //                     fontSize: 14,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 12),
                
// //                 // Edit Button
// //                 SizedBox(
// //                   height: 32,
// //                   child: ElevatedButton(
// //                     onPressed: () {},
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: Colors.white.withValues(alpha: 0.1),
// //                       foregroundColor: Colors.white,
// //                       elevation: 0,
// //                       side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(20),
// //                       ),
// //                     ),
// //                     child: const Text('Edit Profile', style: TextStyle(fontSize: 12)),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildStatsGrid() {
// //     final stats = [
// //       {'label': 'Workflows', 'value': _user.stats.workflowCompletions.toString(), 'icon': Icons.dashboard_rounded, 'color': const Color(0xFFB5A642)}, // Gold
// //       {'label': 'AI Chats', 'value': _user.stats.aiSuggestions.toString(), 'icon': Icons.auto_awesome, 'color': const Color(0xFF8DA385)}, // Sage
// //       {'label': 'Active', 'value': _user.stats.activeTasks.toString(), 'icon': Icons.timer, 'color': Colors.white}, // White
// //       {'label': 'Templates', 'value': _user.stats.templatesCreated.toString(), 'icon': Icons.folder_copy, 'color': const Color(0xFF6A7B66)}, // Green
// //     ];

// //     return GridView.builder(
// //       shrinkWrap: true,
// //       physics: const NeverScrollableScrollPhysics(),
// //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //         crossAxisCount: 2,
// //         crossAxisSpacing: 12,
// //         mainAxisSpacing: 12,
// //         childAspectRatio: 1.5,
// //       ),
// //       itemCount: stats.length,
// //       itemBuilder: (context, index) {
// //         final stat = stats[index];
// //         final color = stat['color'] as Color;
        
// //         return GlassCard(
// //           padding: const EdgeInsets.all(16),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   Icon(stat['icon'] as IconData, color: color, size: 20),
// //                   Text(
// //                     stat['value'] as String,
// //                     style: const TextStyle(
// //                       color: Colors.white,
// //                       fontSize: 20,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               const Spacer(),
// //               Text(
// //                 stat['label'] as String,
// //                 style: TextStyle(
// //                   color: Colors.white.withValues(alpha: 0.6),
// //                   fontSize: 12,
// //                 ),
// //               ),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   Widget _buildRecentActivity() {
// //     final activities = [
// //       {'action': 'Workflow completed', 'time': '2 min ago', 'icon': Icons.check_circle_outline, 'color': const Color(0xFF8DA385)},
// //       {'action': 'AI suggestion received', 'time': '15 min ago', 'icon': Icons.lightbulb_outline, 'color': const Color(0xFFB5A642)},
// //       {'action': 'Template created', 'time': '1 hour ago', 'icon': Icons.add_box_outlined, 'color': Colors.white},
// //       {'action': 'Chat session started', 'time': '3 hours ago', 'icon': Icons.chat_bubble_outline, 'color': const Color(0xFF6A7B66)},
// //     ];

// //     return Column(
// //       children: activities.map((activity) {
// //         return Container(
// //           margin: const EdgeInsets.only(bottom: 12),
// //           child: GlassCard(
// //             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //             borderRadius: 16,
// //             child: Row(
// //               children: [
// //                 Container(
// //                   padding: const EdgeInsets.all(8),
// //                   decoration: BoxDecoration(
// //                     color: (activity['color'] as Color).withValues(alpha: 0.1),
// //                     borderRadius: BorderRadius.circular(10),
// //                   ),
// //                   child: Icon(
// //                     activity['icon'] as IconData,
// //                     color: activity['color'] as Color,
// //                     size: 20,
// //                   ),
// //                 ),
// //                 const SizedBox(width: 16),
// //                 Expanded(
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(
// //                         activity['action'] as String,
// //                         style: const TextStyle(
// //                           color: Colors.white,
// //                           fontSize: 14,
// //                           fontWeight: FontWeight.w500,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 2),
// //                       Text(
// //                         activity['time'] as String,
// //                         style: TextStyle(
// //                           color: Colors.white.withValues(alpha: 0.5),
// //                           fontSize: 11,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 Icon(Icons.arrow_forward_ios, size: 12, color: Colors.white.withValues(alpha: 0.3)),
// //               ],
// //             ),
// //           ),
// //         );
// //       }).toList(),
// //     );
// //   }
// // }



// // import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart'; // Import this
// import 'package:vetto_ai/widgets/glass_card.dart';
// import 'package:vetto_ai/widgets/vetto_scaffold.dart';

// // 1. Local User Model
// class User {
//   final String name;
//   final String email;
//   final bool isOnline;
//   final UserStats stats;
  
//   User({required this.name, required this.email, required this.isOnline, required this.stats});
// }

// class UserStats {
//   final int workflowCompletions;
//   final int aiSuggestions;
//   final int activeTasks;
//   final int templatesCreated;

//   const UserStats({
//     required this.workflowCompletions,
//     required this.aiSuggestions,
//     required this.activeTasks,
//     required this.templatesCreated,
//   });
// }

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
//   late User _user;
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _slideAnimation;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize with default first
//     _user = _getMockUser(name: 'Alex Chen'); 
    
//     // Load real name from storage
//     _loadUserProfile();

//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );

//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
//     );

//     _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
//     );

//     _animationController.forward();
//   }

//   // NEW: Load the name saved during onboarding
//   Future<void> _loadUserProfile() async {
//     final prefs = await SharedPreferences.getInstance();
//     final savedName = prefs.getString('user_name');

//     if (savedName != null && mounted) {
//       setState(() {
//         _user = _getMockUser(name: savedName);
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   // Updated to accept name
//   User _getMockUser({required String name}) {
//     return User(
//       name: name,
//       email: '${name.toLowerCase().replaceAll(' ', '.')}@vetto.ai', // Dynamic email based on name
//       isOnline: true,
//       stats: const UserStats(
//         workflowCompletions: 42,
//         aiSuggestions: 128,
//         activeTasks: 7,
//         templatesCreated: 15,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return VettoScaffold(
//       body: SafeArea(
//         child: AnimatedBuilder(
//           animation: _animationController,
//           builder: (context, child) {
//             return Transform.translate(
//               offset: Offset(0, _slideAnimation.value),
//               child: Opacity(
//                 opacity: _fadeAnimation.value,
//                 child: ListView(
//                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                   children: [
//                     _buildProfileHeader(),
//                     const SizedBox(height: 24),
                    
//                     _buildSectionTitle('Overview'),
//                     _buildStatsGrid(),
                    
//                     const SizedBox(height: 24),
                    
//                     _buildSectionTitle('Recent Activity'),
//                     _buildRecentActivity(),

//                      const SizedBox(height: 40),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12, left: 4),
//       child: Text(
//         title.toUpperCase(),
//         style: const TextStyle(
//           color: Color(0xFF8DA385),
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//           letterSpacing: 1.2,
//         ),
//       ),
//     );
//   }

//   Widget _buildProfileHeader() {
//     return GlassCard(
//       padding: const EdgeInsets.all(20),
//       child: Row(
//         children: [
//           Stack(
//             alignment: Alignment.center,
//             children: [
//               Container(
//                 width: 70,
//                 height: 70,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color(0xFFB5A642).withValues(alpha: 0.3),
//                       blurRadius: 20,
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 width: 80,
//                 height: 80,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.white, width: 2),
//                   image: const DecorationImage(
//                     image: AssetImage('assets/images/logo.png'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: 2,
//                 right: 2,
//                 child: Container(
//                   width: 18,
//                   height: 18,
//                   decoration: BoxDecoration(
//                     color: _user.isOnline ? const Color.fromARGB(255, 65, 159, 44) : Colors.grey,
//                     shape: BoxShape.circle,
//                     border: Border.all(color: Colors.black, width: 2),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(width: 20),
          
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     // Wrap in Flexible to prevent overflow with long names
//                     Flexible(
//                       child: Text(
//                         _user.name,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         overflow: TextOverflow.ellipsis, 
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     const Icon(Icons.verified, color: Color(0xFFB5A642), size: 16),
//                   ],
//                 ),
//                 Text(
//                   _user.email,
//                   style: TextStyle(
//                     color: Colors.white.withValues(alpha: 0.6),
//                     fontSize: 14,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 12),
                
//                 SizedBox(
//                   height: 32,
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white.withValues(alpha: 0.1),
//                       foregroundColor: Colors.white,
//                       elevation: 0,
//                       side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                     child: const Text('Edit Profile', style: TextStyle(fontSize: 12)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatsGrid() {
//     final stats = [
//       {'label': 'Workflows', 'value': _user.stats.workflowCompletions.toString(), 'icon': Icons.dashboard_rounded, 'color': const Color(0xFFB5A642)},
//       {'label': 'AI Chats', 'value': _user.stats.aiSuggestions.toString(), 'icon': Icons.auto_awesome, 'color': const Color(0xFF8DA385)},
//       {'label': 'Active', 'value': _user.stats.activeTasks.toString(), 'icon': Icons.timer, 'color': Colors.white},
//       {'label': 'Templates', 'value': _user.stats.templatesCreated.toString(), 'icon': Icons.folder_copy, 'color': const Color(0xFF6A7B66)},
//     ];

//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 12,
//         mainAxisSpacing: 12,
//         childAspectRatio: 1.5,
//       ),
//       itemCount: stats.length,
//       itemBuilder: (context, index) {
//         final stat = stats[index];
//         final color = stat['color'] as Color;
        
//         return GlassCard(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Icon(stat['icon'] as IconData, color: color, size: 20),
//                   Text(
//                     stat['value'] as String,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//               const Spacer(),
//               Text(
//                 stat['label'] as String,
//                 style: TextStyle(
//                   color: Colors.white.withValues(alpha: 0.6),
//                   fontSize: 12,
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildRecentActivity() {
//     final activities = [
//       {'action': 'Workflow completed', 'time': '2 min ago', 'icon': Icons.check_circle_outline, 'color': const Color(0xFF8DA385)},
//       {'action': 'AI suggestion received', 'time': '15 min ago', 'icon': Icons.lightbulb_outline, 'color': const Color(0xFFB5A642)},
//       {'action': 'Template created', 'time': '1 hour ago', 'icon': Icons.add_box_outlined, 'color': Colors.white},
//       {'action': 'Chat session started', 'time': '3 hours ago', 'icon': Icons.chat_bubble_outline, 'color': const Color(0xFF6A7B66)},
//     ];

//     return Column(
//       children: activities.map((activity) {
//         return Container(
//           margin: const EdgeInsets.only(bottom: 12),
//           child: GlassCard(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             borderRadius: 16,
//             child: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: (activity['color'] as Color).withValues(alpha: 0.1),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Icon(
//                     activity['icon'] as IconData,
//                     color: activity['color'] as Color,
//                     size: 20,
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         activity['action'] as String,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const SizedBox(height: 2),
//                       Text(
//                         activity['time'] as String,
//                         style: TextStyle(
//                           color: Colors.white.withValues(alpha: 0.5),
//                           fontSize: 11,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Icon(Icons.arrow_forward_ios, size: 12, color: Colors.white.withValues(alpha: 0.3)),
//               ],
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }
// }





import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vetto_ai/widgets/vetto_scaffold.dart';

// 1. Local User Model (PRESERVED)
class User {
  final String name;
  final String email;
  final bool isOnline;
  final UserStats stats;
  
  User({required this.name, required this.email, required this.isOnline, required this.stats});
}

class UserStats {
  final int workflowCompletions;
  final int aiSuggestions;
  final int activeTasks;
  final int templatesCreated;

  const UserStats({
    required this.workflowCompletions,
    required this.aiSuggestions,
    required this.activeTasks,
    required this.templatesCreated,
  });
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  late User _user;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize with default first
    _user = _getMockUser(name: 'Alex Chen'); 
    
    // Load real name from storage
    _loadUserProfile();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200), // Slower, more cinematic
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutQuart),
    );

    _slideAnimation = Tween<double>(begin: 40.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutQuart),
    );

    _animationController.forward();
  }

  // Logic: Load the name saved during onboarding
  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final savedName = prefs.getString('user_name');

    if (savedName != null && mounted) {
      setState(() {
        _user = _getMockUser(name: savedName);
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Logic: Updated to accept name
  User _getMockUser({required String name}) {
    return User(
      name: name,
      email: '${name.toLowerCase().replaceAll(' ', '.')}@vetto.ai',
      isOnline: true,
      stats: const UserStats(
        workflowCompletions: 42,
        aiSuggestions: 128,
        activeTasks: 7,
        templatesCreated: 15,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return VettoScaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
           // --- 1. PREMIUM DARK BACKGROUND ---
          
          // A. Base Gradient (Charcoal to Obsidian)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF121212), // Deep Charcoal
                  Color(0xFF000000), // Obsidian
                ],
              ),
            ),
          ),

          // B. Radial Spotlight (Top Left Sheen)
          Positioned(
            top: -200,
            left: -200,
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.07), // Soft sheen
                    Colors.transparent,
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
          ),

          // C. Massive Geometric Typography Texture (3% Opacity)
          Positioned(
            top: 120,
            right: -20,
            child: Text(
              "PROFILE",
              style: TextStyle(
                fontSize: 140,
                fontWeight: FontWeight.w900,
                color: Colors.white.withValues(alpha: 0.03),
                letterSpacing: -8.0,
                height: 0.8,
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -30,
            child: Text(
              "02",
              style: TextStyle(
                fontSize: 250,
                fontWeight: FontWeight.w900,
                color: Colors.white.withValues(alpha: 0.02),
                letterSpacing: -15.0,
              ),
            ),
          ),

          // --- 2. FOREGROUND CONTENT ---
          SafeArea(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _slideAnimation.value),
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      children: [
                        _buildFixedAppBar(),
                        const SizedBox(height: 30),
                        
                        _buildProfileHeader(),
                        const SizedBox(height: 40),
                        
                        _buildSectionTitle('ANALYTICS'),
                        const SizedBox(height: 16),
                        _buildStatsGrid(),
                        
                        const SizedBox(height: 40),
                        
                        _buildSectionTitle('RECENT ACTIVITY'),
                        const SizedBox(height: 16),
                        _buildRecentActivity(),

                         const SizedBox(height: 60),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGETS ---

  Widget _buildFixedAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Minimalist Label
        const Text(
          "VETTO // PROFILE",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.white54,
            letterSpacing: 1.5, // Wide spacing for small caps feel
          ),
        ),
        // Settings Icon (Minimal)
        Container(
          width: 40, height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Icon(Icons.settings, color: Colors.white.withValues(alpha: 0.7), size: 18),
        )
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(width: 4, height: 4, decoration: const BoxDecoration(color: Color(0xFFB5A642), shape: BoxShape.circle)), // Gold dot
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.4),
            fontSize: 11,
            fontWeight: FontWeight.w900, // Heavy weight
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: Container(height: 1, color: Colors.white.withValues(alpha: 0.05))), // Subtle line
      ],
    );
  }

  Widget _buildProfileHeader() {
    // Ultra-minimal header, no "GlassCard" wrapper, just clean layout
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withValues(alpha: 0.1), width: 1),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.white.withValues(alpha: 0.05), Colors.transparent],
                    )
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(2.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      backgroundImage: AssetImage('assets/images/logo.png'), 
                    ),
                  ),
                ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: _user.isOnline ? const Color(0xFF8DA385) : Colors.grey, // Muted Green
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 3),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 24),
            
            // Text Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    _user.name.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900, // Swiss Bold
                      height: 0.9,
                      letterSpacing: -1.0, // Tight kerning
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _user.email.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 10,
                      letterSpacing: 1.5, // Spaced out for technical feel
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Edit Button - Geometric Outline
                  SizedBox(
                    height: 36,
                    width: 140,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2), // Sharp corners
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      child: const Text('EDIT PROFILE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsGrid() {
    final stats = [
      {'label': 'WORKFLOWS', 'value': _user.stats.workflowCompletions.toString(), 'icon': Icons.grid_view, 'color': Colors.white},
      {'label': 'AI CHATS', 'value': _user.stats.aiSuggestions.toString(), 'icon': Icons.auto_awesome, 'color': const Color(0xFFB5A642)},
      {'label': 'ACTIVE TASKS', 'value': _user.stats.activeTasks.toString(), 'icon': Icons.bolt, 'color': const Color(0xFF8DA385)},
      {'label': 'TEMPLATES', 'value': _user.stats.templatesCreated.toString(), 'icon': Icons.copy_all, 'color': Colors.white70},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        // CHANGED: Lowered from 1.6 to 1.1 to make cards taller so content fits
        childAspectRatio: 1.1, 
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        final stat = stats[index];
        final color = stat['color'] as Color;
        
        return ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              // CHANGED: Reduced padding from 20 to 16 to save space
              padding: const EdgeInsets.all(16), 
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.03),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(stat['icon'] as IconData, color: color.withValues(alpha: 0.8), size: 20),
                  
                  // Wrapped in Flexible to handle overflow gracefully if needed
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min, // Compresses to fit
                      children: [
                        FittedBox( // Ensures number shrinks if it gets too massive
                          fit: BoxFit.scaleDown,
                          child: Text(
                            stat['value'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              // CHANGED: Reduced from 32 to 28 for safety
                              fontSize: 28, 
                              height: 1.0,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -1.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          stat['label'] as String,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildRecentActivity() {
    final activities = [
      {'action': 'WORKFLOW COMPLETED', 'time': '02 MIN AGO', 'icon': Icons.check, 'color': const Color(0xFF8DA385)},
      {'action': 'AI SUGGESTION', 'time': '15 MIN AGO', 'icon': Icons.auto_awesome, 'color': const Color(0xFFB5A642)},
      {'action': 'TEMPLATE CREATED', 'time': '01 HR AGO', 'icon': Icons.add, 'color': Colors.white},
      {'action': 'CHAT STARTED', 'time': '03 HRS AGO', 'icon': Icons.chat_bubble_outline, 'color': Colors.white54},
    ];

    return Column(
      children: activities.map((activity) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.white.withValues(alpha: 0.05))), // Bottom line only
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                // Minimal Icon Box
                Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(
                    activity['icon'] as IconData,
                    color: activity['color'] as Color,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 16),
                
                // Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity['action'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w800, // Heavy
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        activity['time'] as String,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.4),
                          fontSize: 10,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Arrow
                Icon(Icons.arrow_forward, size: 14, color: Colors.white.withValues(alpha: 0.2)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}