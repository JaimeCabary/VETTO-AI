
// import 'package:flutter/material.dart';
// import 'package:uruella_ai/config/app_theme.dart';
// import 'package:uruella_ai/pages/onboarding/onboarding_screen.dart';
// import 'package:uruella_ai/pages/splash_screen.dart';
// import 'package:uruella_ai/pages/profile_page.dart';
// import 'package:uruella_ai/pages/chat_page.dart';
// import 'package:uruella_ai/pages/workflow_manager_page.dart';
// import 'package:uruella_ai/pages/site_builder_page.dart';
// import 'package:uruella_ai/widgets/bottom_nav_bar.dart';
// import 'package:uruella_ai/pages/settings_page.dart';
// import 'package:uruella_ai/services/env_service.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await EnvService().initialize();
//   runApp(const UruellaAIApp());
// }

// class UruellaAIApp extends StatelessWidget {
//   const UruellaAIApp({super.key});


//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Uruella AI',
//       theme: AppTheme.darkTheme,
//       debugShowCheckedModeBanner: false,
//       initialRoute: AppRoutes.splash,
//       routes: {
//         AppRoutes.splash: (context) => const SplashScreen(),
//         AppRoutes.onboarding: (context) => const OnboardingScreen(),
//         AppRoutes.main: (context) => const MainWrapper(),
//         AppRoutes.profile: (context) => const ProfilePage(),
//         AppRoutes.chat: (context) => const ChatPage(),
//         AppRoutes.workflows: (context) => const WorkflowManagerPage(),
//         AppRoutes.siteBuilder: (context) => const SiteBuilderPage(),
//       },
//     );
//   }
// }

// class AppRoutes {
//   static const String splash = '/';
//   static const String onboarding = '/onboarding';
//   static const String profile = '/profile';
//   static const String chat = '/chat';
//   static const String settings = '/settings';
//   static const String workflows = '/workflows';
//   static const String siteBuilder = '/site-builder';
//   static const String main = '/main';
// }

// class MainWrapper extends StatefulWidget {
//   const MainWrapper({super.key});

//   @override
//   State<MainWrapper> createState() => _MainWrapperState();
// }

// class _MainWrapperState extends State<MainWrapper> {
//   int _currentIndex = 0;

//   final List<Widget> _pages = const [
//     WorkflowManagerPage(),
//     ChatPage(),
//     SiteBuilderPage(),
//     ProfilePage(),
//     SettingsPage(),    
//   ];

//   @override
//   Widget build(BuildContext context) {
//     assert(_pages.length == 5, 'Pages list must match BottomNavBar items count.');
    
//     return Scaffold(
//       // We set this to transparent because we are creating a custom background Stack
//       backgroundColor: Colors.transparent,
//       extendBody: true, // Allows background to flow behind the BottomNavBar
      
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           // --- 1. PREMIUM DARK BACKGROUND BASE ---
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   Color(0xFF121212), // Deep Charcoal
//                   Color(0xFF000000), // Obsidian Black
//                 ],
//               ),
//             ),
//           ),

//           // --- 2. RADIAL SPOTLIGHT ---
//           Positioned(
//             top: -200,
//             left: -200,
//             child: Container(
//               width: 600,
//               height: 600,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: RadialGradient(
//                   colors: [
//                     Colors.white.withValues(alpha: 0.07), // Soft matte sheen
//                     Colors.transparent,
//                   ],
//                   stops: const [0.0, 1.0],
//                 ),
//               ),
//             ),
//           ),

//           // --- 3. GEOMETRIC TYPOGRAPHY TEXTURE ---
//           // Massive, cropped typography for depth
//           Positioned(
//             bottom: -50,
//             right: -20,
//             child: IgnorePointer( // Ensures clicks pass through to the pages
//               child: Text(
//                 "URUELLA",
//                 style: TextStyle(
//                   fontSize: 180,
//                   fontWeight: FontWeight.w900, // Heavy geometric weight
//                   color: Colors.white.withValues(alpha: 0.02), // 2-3% opacity
//                   letterSpacing: -10.0, // Tight kerning
//                   height: 1.0,
//                 ),
//               ),
//             ),
//           ),

//           // --- 4. ACTIVE PAGE CONTENT ---
//           _pages[_currentIndex],
//         ],
//       ),
      
//       bottomNavigationBar: BottomNavBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:uruella_ai/config/app_theme.dart';
import 'package:uruella_ai/pages/onboarding/onboarding_screen.dart';
import 'package:uruella_ai/pages/splash_screen.dart';
import 'package:uruella_ai/pages/profile_page.dart';
import 'package:uruella_ai/pages/chat_page.dart';
import 'package:uruella_ai/pages/workflow_manager_page.dart';
import 'package:uruella_ai/pages/site_builder_page.dart';
import 'package:uruella_ai/widgets/bottom_nav_bar.dart';
import 'package:uruella_ai/pages/settings_page.dart';
import 'package:uruella_ai/services/env_service.dart';

// Helper Extension for Color opacity (Needed for your custom background)
extension ColorExtension on Color {
  Color withValues({double? alpha}) {
    if (alpha == null) return this;
    return withValues(alpha: alpha);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Ensure EnvService is initialized before running the app
  // This is required since you use it in AIService initialization later
  await EnvService().initialize(); 
  runApp(const UruellaAIApp());
}

class UruellaAIApp extends StatelessWidget {
  const UruellaAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uruella AI',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.onboarding: (context) => const OnboardingScreen(),
        AppRoutes.main: (context) => const MainWrapper(),
        AppRoutes.profile: (context) => const ProfilePage(),
        AppRoutes.chat: (context) => const ChatPage(),
        AppRoutes.workflows: (context) => const WorkflowManagerPage(),
        AppRoutes.siteBuilder: (context) => const SiteBuilderPage(),
        AppRoutes.settings: (context) => const SettingsPage(), // Ensure this route is defined
      },
    );
  }
}

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String profile = '/profile';
  static const String chat = '/chat';
  static const String settings = '/settings';
  static const String workflows = '/workflows';
  static const String siteBuilder = '/site-builder';
  static const String main = '/main';
}

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  // Pages list is NOT const so we can check the runtime type
  final List<Widget> _pages = [ 
    const WorkflowManagerPage(),
    const ChatPage(),
    const SiteBuilderPage(),
    const ProfilePage(),
    const SettingsPage(),    
  ];

  // ⭐️ Logic to determine if the BottomNavBar should be visible ⭐️
  bool get _isBottomNavBarVisible {
    if (_currentIndex >= _pages.length) return true; // Safety check
    
    final currentPage = _pages[_currentIndex];
    
    // Explicitly hide the navbar for these pages
    return !(currentPage is ChatPage || currentPage is SettingsPage);
  }


  @override
  Widget build(BuildContext context) {
    assert(_pages.length == 5, 'Pages list must match BottomNavBar items count.');
    
    final isVisible = _isBottomNavBarVisible;

    // Use AnimatedSwitcher to smoothly transition the BottomNavBar appearance
    final bottomNavigationBar = AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: isVisible
          ? BottomNavBar(
              key: const ValueKey('BottomNavBar'),
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            )
          : const SizedBox.shrink(key: ValueKey('HiddenNavBar')),
    );

    return Scaffold(
      // Keep background transparent so the Stack's background shows through
      backgroundColor: Colors.transparent, 
      extendBody: true, 
      
      body: Stack(
        fit: StackFit.expand,
        children: [
          // --- 1. PREMIUM DARK BACKGROUND BASE ---
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF121212), // Deep Charcoal
                  Color(0xFF000000), // Obsidian Black
                ],
              ),
            ),
          ),

          // --- 2. RADIAL SPOTLIGHT ---
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
                    Colors.white.withValues(alpha: 0.07), // Soft matte sheen
                    Colors.transparent,
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
          ),

          // --- 3. GEOMETRIC TYPOGRAPHY TEXTURE ---
          Positioned(
            bottom: -50,
            right: -20,
            child: IgnorePointer(
              child: Text(
                "URUELLA",
                style: TextStyle(
                  fontSize: 180,
                  fontWeight: FontWeight.w900,
                  color: Colors.white.withValues(alpha: 0.02),
                  letterSpacing: -10.0,
                  height: 1.0,
                ),
              ),
            ),
          ),

          // --- 4. ACTIVE PAGE CONTENT ---
          // Use IndexedStack to preserve state between pages
          IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),
        ],
      ),
      
      // ⭐️ CONDITIONAL BOTTOM NAVIGATION BAR ⭐️
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}