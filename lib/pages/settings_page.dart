// // import 'package:flutter/material.dart';
// // import '../config/app_colors.dart';
// // import '../config/constants.dart';
// // import '../widgets/animated_button.dart';

// // class SettingsPage extends StatefulWidget {
// //   const SettingsPage({super.key});

// //   @override
// //   State<SettingsPage> createState() => _SettingsPageState();
// // }

// // class _SettingsPageState extends State<SettingsPage> {
// //   bool _darkMode = true;
// //   bool _notifications = true;
// //   bool _offlineMode = true;
// //   bool _autoSync = false;
// //   double _fontSize = 1.0;
// //   String _selectedTheme = 'Dark';
// //   String _selectedLanguage = 'English';

// //   final List<String> _themes = ['Dark', 'Light', 'Rainbow Onboarding'];
// //   final List<String> _languages = ['English', 'Spanish', 'French', 'German', 'Japanese'];

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: AppColors.backgroundDark,
// //       body: SafeArea(
// //         child: CustomScrollView(
// //           slivers: [
// //             SliverAppBar(
// //               backgroundColor: Colors.transparent,
// //               elevation: 0,
// //               title: Text(
// //                 'Settings',
// //                 style: Theme.of(context).textTheme.displayMedium?.copyWith(
// //                   color: AppColors.neonCyan,
// //                 ),
// //               ),
// //               centerTitle: false,
// //               pinned: true,
// //               floating: true,
// //             ),
// //             SliverToBoxAdapter(
// //               child: Padding(
// //                 padding: AppConstants.paddingPage,
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     _buildSectionHeader('Appearance'),
// //                     _buildThemeCard(),
// //                     const SizedBox(height: AppConstants.spacingXL),
// //                     _buildSectionHeader('Preferences'),
// //                     _buildPreferencesCard(),
// //                     const SizedBox(height: AppConstants.spacingXL),
// //                     _buildSectionHeader('Offline & Sync'),
// //                     _buildOfflineCard(),
// //                     const SizedBox(height: AppConstants.spacingXL),
// //                     _buildSectionHeader('Accessibility'),
// //                     _buildAccessibilityCard(),
// //                     const SizedBox(height: AppConstants.spacingXL),
// //                     _buildActionButtons(),
// //                     const SizedBox(height: AppConstants.spacingXXL),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildSectionHeader(String title) {
// //     return Padding(
// //       padding: const EdgeInsets.only(bottom: AppConstants.spacingM),
// //       child: Text(
// //         title,
// //         style: Theme.of(context).textTheme.headlineMedium?.copyWith(
// //           color: AppColors.neonCyan,
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildThemeCard() {
// //     return Container(
// //       padding: AppConstants.paddingCard,
// //       decoration: BoxDecoration(
// //         gradient: AppColors.cardGradient,
// //         borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
// //         // boxShadow: AppColors.neonGlow(AppColors.neonPurple),
// //       ),
// //       child: Column(
// //         children: [
// //           _buildSettingRow(
// //             'Dark Mode',
// //             'Use dark theme for better battery life',
// //             Switch(
// //               value: _darkMode,
// //               onChanged: (value) => setState(() => _darkMode = value),
// //               activeThumbColor: AppColors.neonCyan,
// //               activeTrackColor: AppColors.neonCyan.withValues(alpha:0.3),
// //             ),
// //           ),
// //           const Divider(color: AppColors.surface),
// //           _buildDropdownRow(
// //             'Theme',
// //             'Select app theme',
// //             _selectedTheme,
// //             _themes,
// //             (value) => setState(() => _selectedTheme = value!),
// //           ),
// //           const Divider(color: AppColors.surface),
// //           _buildSettingRow(
// //             'Rainbow Animations',
// //             'Enable colorful onboarding animations',
// //             Switch(
// //               value: true,
// //               onChanged: (value) {},
// //               activeThumbColor: AppColors.neonPink,
// //               activeTrackColor: AppColors.neonPink.withValues(alpha:0.3),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildPreferencesCard() {
// //     return Container(
// //       padding: AppConstants.paddingCard,
// //       decoration: BoxDecoration(
// //         gradient: AppColors.cardGradient,
// //         borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
// //         // boxShadow: AppColors.neonGlow(AppColors.neonGreen),
// //       ),
// //       child: Column(
// //         children: [
// //           _buildSettingRow(
// //             'Push Notifications',
// //             'Receive alerts and updates',
// //             Switch(
// //               value: _notifications,
// //               onChanged: (value) => setState(() => _notifications = value),
// //               activeThumbColor: AppColors.neonGreen,
// //               activeTrackColor: AppColors.neonGreen.withValues(alpha:0.3),
// //             ),
// //           ),
// //           const Divider(color: AppColors.surface),
// //           _buildDropdownRow(
// //             'Language',
// //             'Select app language',
// //             _selectedLanguage,
// //             _languages,
// //             (value) => setState(() => _selectedLanguage = value!),
// //           ),
// //           const Divider(color: AppColors.surface),
// //           _buildSettingRow(
// //             'Sound Effects',
// //             'Play sounds for interactions',
// //             Switch(
// //               value: true,
// //               onChanged: (value) {},
// //               activeThumbColor: AppColors.oliveGold,
// //               activeTrackColor: AppColors.oliveGold.withValues(alpha:0.3),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildOfflineCard() {
// //     return Container(
// //       padding: AppConstants.paddingCard,
// //       decoration: BoxDecoration(
// //         gradient: AppColors.cardGradient,
// //         borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
// //         // boxShadow: AppColors.neonGlow(AppColors.oliveGold),
// //       ),
// //       child: Column(
// //         children: [
// //           _buildSettingRow(
// //             'Offline-First Mode',
// //             'Store all data locally',
// //             Switch(
// //               value: _offlineMode,
// //               onChanged: (value) => setState(() => _offlineMode = value),
// //               activeThumbColor: AppColors.oliveGold,
// //               activeTrackColor: AppColors.oliveGold.withValues(alpha:0.3),
// //             ),
// //           ),
// //           const Divider(color: AppColors.surface),
// //           _buildSettingRow(
// //             'Auto Sync',
// //             'Sync data when online',
// //             Switch(
// //               value: _autoSync,
// //               onChanged: _offlineMode ? (value) => setState(() => _autoSync = value) : null,
// //               activeThumbColor: AppColors.neonCyan,
// //               activeTrackColor: AppColors.neonCyan.withValues(alpha:0.3),
// //             ),
// //           ),
// //           const Divider(color: AppColors.surface),
// //           _buildStorageInfo(),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildAccessibilityCard() {
// //     return Container(
// //       padding: AppConstants.paddingCard,
// //       decoration: BoxDecoration(
// //         gradient: AppColors.cardGradient,
// //         borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
// //         // boxShadow: AppColors.neonGlow(AppColors.neonCyan),
// //       ),
// //       child: Column(
// //         children: [
// //           _buildSliderRow(
// //             'Font Size',
// //             'Adjust text size',
// //             _fontSize,
// //             (value) => setState(() => _fontSize = value),
// //           ),
// //           const Divider(color: AppColors.surface),
// //           _buildSettingRow(
// //             'High Contrast',
// //             'Increase color contrast',
// //             Switch(
// //               value: false,
// //               onChanged: (value) {},
// //               activeThumbColor: AppColors.neonPurple,
// //               activeTrackColor: AppColors.neonPurple.withValues(alpha:0.3),
// //             ),
// //           ),
// //           const Divider(color: AppColors.surface),
// //           _buildSettingRow(
// //             'Reduce Motion',
// //             'Minimize animations',
// //             Switch(
// //               value: false,
// //               onChanged: (value) {},
// //               activeThumbColor: AppColors.neonGreen,
// //               activeTrackColor: AppColors.neonGreen.withValues(alpha:0.3),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildSettingRow(String title, String subtitle, Widget control) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingM),
// //       child: Row(
// //         children: [
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   title,
// //                   style: Theme.of(context).textTheme.titleLarge,
// //                 ),
// //                 const SizedBox(height: AppConstants.spacingXS),
// //                 Text(
// //                   subtitle,
// //                   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
// //                     color: AppColors.textTertiary,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           control,
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildDropdownRow(
// //     String title,
// //     String subtitle,
// //     String value,
// //     List<String> items,
// //     ValueChanged<String?> onChanged,
// //   ) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingM),
// //       child: Row(
// //         children: [
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   title,
// //                   style: Theme.of(context).textTheme.titleLarge,
// //                 ),
// //                 const SizedBox(height: AppConstants.spacingXS),
// //                 Text(
// //                   subtitle,
// //                   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
// //                     color: AppColors.textTertiary,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Container(
// //             padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacingM),
// //             decoration: BoxDecoration(
// //               color: AppColors.surface,
// //               borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
// //               border: Border.all(color: AppColors.neonCyan.withValues(alpha:0.3)),
// //             ),
// //             child: DropdownButton<String>(
// //               value: value,
// //               onChanged: onChanged,
// //               dropdownColor: AppColors.cardBackground,
// //               style: const TextStyle(
// //                 color: AppColors.textPrimary,
// //                 fontSize: AppConstants.fontSizeM,
// //               ),
// //               underline: const SizedBox(),
// //               icon: const Icon(
// //                 Icons.arrow_drop_down,
// //                 color: AppColors.neonCyan,
// //               ),
// //               items: items.map((String item) {
// //                 return DropdownMenuItem<String>(
// //                   value: item,
// //                   child: Text(
// //                     item,
// //                     style: const TextStyle(
// //                       color: AppColors.textPrimary,
// //                     ),
// //                   ),
// //                 );
// //               }).toList(),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildSliderRow(
// //     String title,
// //     String subtitle,
// //     double value,
// //     ValueChanged<double> onChanged,
// //   ) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingM),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               Text(
// //                 title,
// //                 style: Theme.of(context).textTheme.titleLarge,
// //               ),
// //               Container(
// //                 padding: const EdgeInsets.symmetric(
// //                   horizontal: AppConstants.spacingM,
// //                   vertical: AppConstants.spacingXS,
// //                 ),
// //                 decoration: BoxDecoration(
// //                   color: AppColors.neonCyan.withValues(alpha:0.2),
// //                   borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
// //                   border: Border.all(color: AppColors.neonCyan),
// //                 ),
// //                 child: Text(
// //                   '${(value * 100).round()}%',
// //                   style: const TextStyle(
// //                     color: AppColors.neonCyan,
// //                     fontSize: AppConstants.fontSizeS,
// //                     fontWeight: FontWeight.w600,
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //           const SizedBox(height: AppConstants.spacingXS),
// //           Text(
// //             subtitle,
// //             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
// //               color: AppColors.textTertiary,
// //             ),
// //           ),
// //           const SizedBox(height: AppConstants.spacingM),
// //           Slider(
// //             value: value,
// //             onChanged: onChanged,
// //             min: 0.5,
// //             max: 2.0,
// //             divisions: 15,
// //             activeColor: AppColors.neonCyan,
// //             inactiveColor: AppColors.surface,
// //             thumbColor: AppColors.neonCyan,
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildStorageInfo() {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingM),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               Text(
// //                 'Local Storage',
// //                 style: Theme.of(context).textTheme.titleLarge,
// //               ),
// //               Text(
// //                 '2.3 GB / 4.0 GB',
// //                 style: Theme.of(context).textTheme.bodyLarge?.copyWith(
// //                   color: AppColors.neonGreen,
// //                 ),
// //               ),
// //             ],
// //           ),
// //           const SizedBox(height: AppConstants.spacingS),
// //           LinearProgressIndicator(
// //             value: 2.3 / 4.0,
// //             backgroundColor: AppColors.surface,
// //             valueColor: const AlwaysStoppedAnimation(AppColors.neonGreen),
// //             borderRadius: BorderRadius.circular(AppConstants.borderRadiusS),
// //           ),
// //           const SizedBox(height: AppConstants.spacingS),
// //           Text(
// //             'AI models, chat history, and workflows stored locally',
// //             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
// //               color: AppColors.textTertiary,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildActionButtons() {
// //     return Column(
// //       children: [
// //         AnimatedButton(
// //           text: 'Export All Data',
// //           onPressed: () {},
// //           type: ButtonType.secondary,
// //           icon: Icons.backup,
// //         ),
// //         const SizedBox(height: AppConstants.spacingM),
// //         AnimatedButton(
// //           text: 'Clear Cache',
// //           onPressed: () => _showClearCacheDialog(),
// //           type: ButtonType.success,
// //           icon: Icons.cleaning_services,
// //         ),
// //         const SizedBox(height: AppConstants.spacingM),
// //         Container(
// //           width: double.infinity,
// //           height: 56,
// //           decoration: BoxDecoration(
// //             border: Border.all(color: AppColors.error.withValues(alpha:0.3)),
// //             borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
// //           ),
// //           child: TextButton(
// //             onPressed: () => _showResetDialog(),
// //             child: const Text(
// //               'Reset to Defaults',
// //               style: TextStyle(
// //                 color: AppColors.error,
// //                 fontSize: AppConstants.fontSizeM,
// //                 fontWeight: FontWeight.w600,
// //               ),
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   void _showClearCacheDialog() {
// //     showDialog(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         backgroundColor: AppColors.cardBackground,
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
// //         ),
// //         title: const Text(
// //           'Clear Cache?',
// //           style: TextStyle(
// //             color: AppColors.textPrimary,
// //             fontSize: AppConstants.fontSizeXL,
// //             fontWeight: FontWeight.w700,
// //           ),
// //         ),
// //         content: const Text(
// //           'This will remove all temporary files but keep your important data like chats and workflows.',
// //           style: TextStyle(
// //             color: AppColors.textSecondary,
// //             fontSize: AppConstants.fontSizeM,
// //           ),
// //         ),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.pop(context),
// //             child: const Text(
// //               'Cancel',
// //               style: TextStyle(
// //                 color: AppColors.textTertiary,
// //                 fontSize: AppConstants.fontSizeM,
// //               ),
// //             ),
// //           ),
// //           Container(
// //             decoration: BoxDecoration(
// //               gradient: AppColors.primaryGradient,
// //               borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
// //             ),
// //             child: TextButton(
// //               onPressed: () {
// //                 Navigator.pop(context);
// //                 // Clear cache logic here
// //               },
// //               child: const Text(
// //                 'Clear Cache',
// //                 style: TextStyle(
// //                   color: AppColors.backgroundDark,
// //                   fontSize: AppConstants.fontSizeM,
// //                   fontWeight: FontWeight.w600,
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   void _showResetDialog() {
// //     showDialog(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         backgroundColor: AppColors.cardBackground,
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
// //         ),
// //         title: const Text(
// //           'Reset Settings?',
// //           style: TextStyle(
// //             color: AppColors.error,
// //             fontSize: AppConstants.fontSizeXL,
// //             fontWeight: FontWeight.w700,
// //           ),
// //         ),
// //         content: const Text(
// //           'This will reset all settings to their default values. This action cannot be undone.',
// //           style: TextStyle(
// //             color: AppColors.textSecondary,
// //             fontSize: AppConstants.fontSizeM,
// //           ),
// //         ),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.pop(context),
// //             child: const Text(
// //               'Cancel',
// //               style: TextStyle(
// //                 color: AppColors.textTertiary,
// //                 fontSize: AppConstants.fontSizeM,
// //               ),
// //             ),
// //           ),
// //           Container(
// //             decoration: BoxDecoration(
// //               color: AppColors.error.withValues(alpha:0.8),
// //               borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
// //             ),
// //             child: TextButton(
// //               onPressed: () {
// //                 Navigator.pop(context);
// //                 setState(() {
// //                   _darkMode = true;
// //                   _notifications = true;
// //                   _offlineMode = true;
// //                   _autoSync = false;
// //                   _fontSize = 1.0;
// //                   _selectedTheme = 'Dark';
// //                   _selectedLanguage = 'English';
// //                 });
// //               },
// //               child: const Text(
// //                 'Reset',
// //                 style: TextStyle(
// //                   color: AppColors.textPrimary,
// //                   fontSize: AppConstants.fontSizeM,
// //                   fontWeight: FontWeight.w600,
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }




// // import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:uruella_ai/widgets/glass_card.dart';
// import 'package:uruella_ai/widgets/vetto_scaffold.dart';

// class SettingsPage extends StatefulWidget {
//   const SettingsPage({super.key});

//   @override
//   State<SettingsPage> createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
//   // Settings State
//   bool _darkMode = true;
//   bool _notifications = true;
//   bool _offlineMode = true;
//   bool _autoSync = false;
//   // final double _fontSize = 1.0;
//   final String _selectedLanguage = 'English';

//   // Assets
//   final String _headerGraphic = "assets/images/logo.png"; 

//   @override
//   Widget build(BuildContext context) {
//     return VettoScaffold(
//       // Custom app bar title
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: const Text('Settings', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//         centerTitle: true,
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
//         children: [
//           // --- 1. Header Graphic ---
//           Center(
//             child: SizedBox(
//               height: 180,
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   // Glow behind the image
//                   Container(
//                     width: 120,
//                     height: 120,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: const Color(0xFF6A7B66).withValues(alpha: 0.3),
//                       boxShadow: [
//                         BoxShadow(
//                           color: const Color(0xFF6A7B66).withValues(alpha: 0.3),
//                           blurRadius: 60,
//                           spreadRadius: 20,
//                         )
//                       ],
//                     ),
//                   ),
//                   // 3D Graphic
//                   Image.asset(
//                     _headerGraphic,
//                     height: 160,
//                     fit: BoxFit.contain,
//                     errorBuilder: (_,__,___) => const Icon(Icons.settings, size: 100, color: Colors.white24),
//                   ),
//                 ],
//               ),
//             ),
//           ),
          
//           const SizedBox(height: 20),

//           // --- 2. Account Section ---
//           _buildSectionHeader('Account', Icons.person_outline),
//           GlassCard(
//             child: Column(
//               children: [
//                 ListTile(
//                   leading: const CircleAvatar(
//                     backgroundColor: Colors.white24,
//                     backgroundImage: AssetImage('assets/images/logo.png'), // Using logo as avatar placeholder
//                   ),
//                   title: const Text('Vetto User', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                   subtitle: Text('Pro Plan • Active', style: TextStyle(color: Colors.white.withValues(alpha: 0.6))),
//                   trailing: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFB5A642), // Gold
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: const Text('PRO', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
//                   ),
//                 ),
//                 const Divider(color: Colors.white10),
//                 _buildSettingsTile(
//                   'Manage Subscription',
//                   Icons.credit_card,
//                   onTap: () {},
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 24),

//           // --- 3. App Preferences ---
//           _buildSectionHeader('Preferences', Icons.tune),
//           GlassCard(
//             child: Column(
//               children: [
//                 _buildSwitchTile(
//                   'Dark Mode',
//                   'Easy on the eyes',
//                   _darkMode,
//                   (v) => setState(() => _darkMode = v),
//                 ),
//                 const Divider(color: Colors.white10),
//                 _buildSwitchTile(
//                   'Notifications',
//                   'Push alerts for workflows',
//                   _notifications,
//                   (v) => setState(() => _notifications = v),
//                 ),
//                 const Divider(color: Colors.white10),
//                 ListTile(
//                   title: const Text('Language', style: TextStyle(color: Colors.white)),
//                   subtitle: Text(_selectedLanguage, style: TextStyle(color: Colors.white.withValues(alpha: 0.5))),
//                   trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white54),
//                   onTap: () {}, // Show language picker
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 24),

//           // --- 4. Data & Sync ---
//           _buildSectionHeader('Data & Storage', Icons.cloud_outlined),
//           GlassCard(
//             child: Column(
//               children: [
//                 _buildSwitchTile(
//                   'Offline Mode',
//                   'Store data locally',
//                   _offlineMode,
//                   (v) => setState(() => _offlineMode = v),
//                 ),
//                 _buildSwitchTile(
//                   'Auto-Sync',
//                   'Sync when online',
//                   _autoSync,
//                   _offlineMode ? (v) => setState(() => _autoSync = v) : null,
//                 ),
//                 const SizedBox(height: 10),
//                 // Storage Usage Bar
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   child: Column(
//                     children: [
//                       const Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Storage Used', style: TextStyle(color: Colors.white70, fontSize: 12)),
//                           Text('2.3 GB / 5 GB', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(4),
//                         child: const LinearProgressIndicator(
//                           value: 0.46,
//                           backgroundColor: Colors.white10,
//                           valueColor: AlwaysStoppedAnimation(Color(0xFF6A7B66)), // Vetto Green
//                           minHeight: 6,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 24),

//           // --- 5. Danger Zone ---
//           GlassCard(
//             color: Colors.red.withValues(alpha: 0.05), // Subtle red tint
//             child: Column(
//               children: [
//                 _buildSettingsTile(
//                   'Clear Cache',
//                   Icons.cleaning_services_outlined,
//                   color: Colors.white,
//                   onTap: () => _showClearCacheDialog(),
//                 ),
//                 const Divider(color: Colors.white10),
//                 _buildSettingsTile(
//                   'Sign Out',
//                   Icons.logout,
//                   color: const Color(0xFFE57373),
//                   onTap: () {},
//                 ),
//               ],
//             ),
//           ),
          
//           const SizedBox(height: 20),
//           Center(
//             child: Text(
//               "Vetto AI v1.0.0",
//               style: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 12),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // --- Helper Widgets ---

//   Widget _buildSectionHeader(String title, IconData icon) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12, left: 4),
//       child: Row(
//         children: [
//           Icon(icon, size: 16, color: const Color(0xFF8DA385)), // Light Sage
//           const SizedBox(width: 8),
//           Text(
//             title.toUpperCase(),
//             style: const TextStyle(
//               color: Color(0xFF8DA385),
//               fontSize: 12,
//               fontWeight: FontWeight.bold,
//               letterSpacing: 1.2,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSwitchTile(String title, String subtitle, bool value, Function(bool)? onChanged) {
//     return SwitchListTile(
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16),
//       title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
//       subtitle: Text(subtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 12)),
//       value: value,
//       onChanged: onChanged,
//       activeThumbColor: Colors.white,
//       activeTrackColor: const Color(0xFF6A7B66), // Vetto Green
//       inactiveThumbColor: Colors.grey.shade300,
//       inactiveTrackColor: Colors.white10,
//     );
//   }

//   Widget _buildSettingsTile(String title, IconData icon, {Color color = Colors.white, VoidCallback? onTap}) {
//     return ListTile(
//       onTap: onTap,
//       leading: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: color.withValues(alpha: 0.1),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Icon(icon, size: 18, color: color),
//       ),
//       title: Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
//       trailing: Icon(Icons.arrow_forward_ios, size: 14, color: color.withValues(alpha: 0.5)),
//     );
//   }

//   void _showClearCacheDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: const Color(0xFF1E2B1E),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         title: const Text("Clear Cache?", style: TextStyle(color: Colors.white)),
//         content: const Text(
//           "This will free up local space but may slow down image loading initially.",
//           style: TextStyle(color: Colors.white70),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("Cancel", style: TextStyle(color: Colors.white54)),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("Clear", style: TextStyle(color: Color(0xFFB5A642))),
//           ),
//         ],
//       ),
//     );
//   }
// }





import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:uruella_ai/widgets/vetto_scaffold.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with SingleTickerProviderStateMixin {
  // Loading State
  bool _isLoading = true;

  // Settings State
  bool _darkMode = true;
  bool _notifications = true;
  bool _offlineMode = true;
  bool _autoSync = false;
  final String _selectedLanguage = 'English';

  // Animation for Content Entry
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    // Setup Animations
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutQuart),
    );
    _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutQuart),
    );

    // Simulate Data Loading
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    if (mounted) {
      setState(() => _isLoading = false);
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VettoScaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // --- 1. PREMIUM DARK BACKGROUND ---
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF121212), Color(0xFF000000)],
              ),
            ),
          ),
          
          // Radial Spotlight
          Positioned(
            top: -200, left: -200,
            child: Container(
              width: 600, height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Colors.white.withValues(alpha: 0.05), Colors.transparent],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
          ),

          // Geometric Typography Texture
          Positioned(
            top: 80, right: -40,
            child: Text(
              "SETTINGS",
              style: TextStyle(
                fontSize: 100, fontWeight: FontWeight.w900,
                color: Colors.white.withValues(alpha: 0.02),
                letterSpacing: -5.0,
              ),
            ),
          ),
          Positioned(
            bottom: -50, left: -20,
            child: Text(
              "03",
              style: TextStyle(
                fontSize: 250, fontWeight: FontWeight.w900,
                color: Colors.white.withValues(alpha: 0.02),
                letterSpacing: -15.0,
              ),
            ),
          ),

          // --- 2. CONTENT ---
          SafeArea(
            child: Column(
              children: [
                _buildFixedAppBar(),
                Expanded(
                  child: _isLoading 
                    ? _buildSkeletonLoading() 
                    : _buildSettingsContent(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- MAIN CONTENT BUILDER ---

  Widget _buildSettingsContent() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              children: [
                // 1. Header Graphic (Minimal)
                Center(
                  child: Container(
                    width: 120, height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.white.withValues(alpha: 0.05), Colors.transparent],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Image.asset(
                        'assets/images/logo.png',
                        color: Colors.white.withValues(alpha: 0.9),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 40),

                // 2. Account Section
                _buildSectionHeader('ACCOUNT'),
                const SizedBox(height: 16),
                _buildMatteContainer(
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        leading: CircleAvatar(
                          backgroundColor: Colors.white.withValues(alpha: 0.1),
                          backgroundImage: const AssetImage('assets/images/logo.png'),
                          radius: 20,
                        ),
                        title: const Text(
                          'SHALOM AZUWIKE',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: -0.5),
                        ),
                        subtitle: Text(
                          'PRO PLAN • ACTIVE',
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFB5A642)), // Gold Border
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: const Text('PRO', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Color(0xFFB5A642))),
                        ),
                      ),
                      _buildDivider(),
                      _buildSettingsTile(
                        'MANAGE SUBSCRIPTION',
                        Icons.credit_card,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // 3. Preferences
                _buildSectionHeader('PREFERENCES'),
                const SizedBox(height: 16),
                _buildMatteContainer(
                  child: Column(
                    children: [
                      _buildSwitchTile(
                        'DARK MODE',
                        'Easy on the eyes',
                        _darkMode,
                        (v) => setState(() => _darkMode = v),
                      ),
                      _buildDivider(),
                      _buildSwitchTile(
                        'NOTIFICATIONS',
                        'Push alerts for workflows',
                        _notifications,
                        (v) => setState(() => _notifications = v),
                      ),
                      _buildDivider(),
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        title: const Text('LANGUAGE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 0.5)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(_selectedLanguage.toUpperCase(), style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 12, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 8),
                            Icon(Icons.arrow_forward, size: 14, color: Colors.white.withValues(alpha: 0.3)),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // 4. Data & Sync
                _buildSectionHeader('DATA & STORAGE'),
                const SizedBox(height: 16),
                _buildMatteContainer(
                  child: Column(
                    children: [
                      _buildSwitchTile(
                        'OFFLINE MODE',
                        'Store data locally',
                        _offlineMode,
                        (v) => setState(() => _offlineMode = v),
                      ),
                      _buildSwitchTile(
                        'AUTO-SYNC',
                        'Sync when online',
                        _autoSync,
                        _offlineMode ? (v) => setState(() => _autoSync = v) : null,
                      ),
                      const SizedBox(height: 10),
                      // Storage Bar
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('STORAGE USED', style: TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold)),
                                Text('2.3 GB / 5 GB', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0), // Sharp
                              child: const LinearProgressIndicator(
                                value: 0.46,
                                backgroundColor: Colors.white10,
                                valueColor: AlwaysStoppedAnimation(Color(0xFF8DA385)), // Muted Sage
                                minHeight: 2, // Ultra thin
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // 5. Danger Zone
                _buildMatteContainer(
                  color: const Color(0xFFD32F2F).withValues(alpha: 0.05), // Subtle red tint
                  borderColor: const Color(0xFFD32F2F).withValues(alpha: 0.2),
                  child: Column(
                    children: [
                      _buildSettingsTile(
                        'CLEAR CACHE',
                        Icons.cleaning_services_outlined,
                        color: Colors.white,
                        onTap: () => _showClearCacheDialog(),
                      ),
                      _buildDivider(color: const Color(0xFFD32F2F).withValues(alpha: 0.2)),
                      _buildSettingsTile(
                        'SIGN OUT',
                        Icons.logout,
                        color: const Color(0xFFE57373),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
                Center(
                  child: Text(
                    "URUELLA AI v1.0.0",
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.2), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 2.0),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  // --- SKELETON LOADING ---

  Widget _buildSkeletonLoading() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      children: const [
        Center(child: _SkeletonBox(width: 120, height: 120, shape: BoxShape.circle)),
        SizedBox(height: 40),
        _SkeletonBox(width: 100, height: 14), // Section Title
        SizedBox(height: 16),
        _SkeletonBox(width: double.infinity, height: 140), // Large container
        SizedBox(height: 40),
        _SkeletonBox(width: 100, height: 14),
        SizedBox(height: 16),
        _SkeletonBox(width: double.infinity, height: 180),
      ],
    );
  }

  // --- WIDGET HELPERS ---

  Widget _buildFixedAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "URUELLA // SETTINGS",
            style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w700,
              color: Colors.white54, letterSpacing: 1.5,
            ),
          ),
          Container(
            width: 8, height: 8,
            decoration: const BoxDecoration(color: Color(0xFF8DA385), shape: BoxShape.circle),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(width: 4, height: 4, decoration: const BoxDecoration(color: Color(0xFFB5A642), shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.4),
            fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.0,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: Container(height: 1, color: Colors.white.withValues(alpha: 0.05))),
      ],
    );
  }

  Widget _buildMatteContainer({required Widget child, Color? color, Color? borderColor}) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(4), // Sharp corners
        border: Border.all(color: borderColor ?? Colors.white.withValues(alpha: 0.08)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: child,
        ),
      ),
    );
  }

  Widget _buildSwitchTile(String title, String subtitle, bool value, Function(bool)? onChanged) {
    return SwitchListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 11)),
      value: value,
      onChanged: onChanged,
      // FIX 2: Updated activeColor to activeThumbColor
      activeThumbColor: const Color(0xFF222222), // Dark knob
      activeTrackColor: Colors.white, // White track
      inactiveThumbColor: Colors.grey,
      inactiveTrackColor: Colors.white10,
    );
  }

  Widget _buildSettingsTile(String title, IconData icon, {Color color = Colors.white, VoidCallback? onTap}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      onTap: onTap,
      leading: Icon(icon, size: 18, color: color.withValues(alpha: 0.8)),
      title: Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 0.5)),
      trailing: Icon(Icons.arrow_forward, size: 14, color: color.withValues(alpha: 0.3)),
    );
  }

  Widget _buildDivider({Color? color}) {
    return Divider(height: 1, thickness: 1, color: color ?? Colors.white.withValues(alpha: 0.05));
  }

  void _showClearCacheDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF121212),
        // FIX 1: Moved BorderSide into RoundedRectangleBorder
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
        title: const Text("CLEAR CACHE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16, letterSpacing: 1.0)),
        content: const Text(
          "This will free up local space but may slow down image loading initially.",
          style: TextStyle(color: Colors.white70, fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("CANCEL", style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("CONFIRM", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// --- SKELETON ANIMATION COMPONENT ---

class _SkeletonBox extends StatefulWidget {
  final double width;
  final double height;
  final BoxShape shape;

  const _SkeletonBox({required this.width, required this.height, this.shape = BoxShape.rectangle});

  @override
  State<_SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<_SkeletonBox> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this)..repeat(reverse: true);
    _colorAnimation = ColorTween(
      begin: Colors.white.withValues(alpha: 0.02),
      end: Colors.white.withValues(alpha: 0.08),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: _colorAnimation.value,
            shape: widget.shape,
            borderRadius: widget.shape == BoxShape.rectangle ? BorderRadius.circular(4) : null,
          ),
        );
      },
    );
  }
}