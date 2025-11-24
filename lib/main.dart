
// import 'package:flutter/material.dart';
// import 'package:vetto_ai/config/app_theme.dart';
// import 'package:vetto_ai/pages/onboarding/onboarding_screen.dart';
// import 'package:vetto_ai/pages/splash_screen.dart';
// import 'package:vetto_ai/pages/profile_page.dart';
// import 'package:vetto_ai/pages/chat_page.dart';
// import 'package:vetto_ai/pages/workflow_manager_page.dart';
// import 'package:vetto_ai/pages/site_builder_page.dart';
// import 'package:vetto_ai/widgets/bottom_nav_bar.dart';
// // import 'package:vetto_ai/widgets/floating_ai_icon.dart';

// void main() {
//   runApp(const VettoAIApp());
// }

// class VettoAIApp extends StatelessWidget {
//   const VettoAIApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Vetto AI',
//       theme: AppTheme.darkTheme,
//       debugShowCheckedModeBanner: false,
//       initialRoute: AppRoutes.onboarding,
//       routes: {
//         AppRoutes.onboarding: (context) => const OnboardingScreen(),
//         AppRoutes.splash: (context) => const SplashScreen(),
//         AppRoutes.main: (context) => const MainWrapper(),
//       },
// //       builder: (context, child) {
// //   // Check if current route is onboarding and hide floating icon
// //   final isOnboarding = ModalRoute.of(context)?.settings.name == AppRoutes.onboarding;
  
// //   return Stack(
// //     children: [
// //       child!,
// //       if (!isOnboarding) // Only show on non-onboarding pages
// //         const Positioned(
// //           right: 20,
// //           bottom: 100,
// //           child: FloatingAiIcon(),
// //         ),
// //     ],
// //   );
// // },
//     );
//   }
// }

// class AppRoutes {
//   static const String onboarding = '/';
//   static const String splash = '/splash';
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
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: _pages[_currentIndex],
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
import 'package:vetto_ai/config/app_theme.dart';
import 'package:vetto_ai/pages/onboarding/onboarding_screen.dart';
import 'package:vetto_ai/pages/splash_screen.dart';
import 'package:vetto_ai/pages/profile_page.dart';
import 'package:vetto_ai/pages/chat_page.dart';
import 'package:vetto_ai/pages/workflow_manager_page.dart';
import 'package:vetto_ai/pages/site_builder_page.dart';
import 'package:vetto_ai/widgets/bottom_nav_bar.dart';
// Add this to your imports in lib/main.dart
import 'package:vetto_ai/pages/settings_page.dart';
// import 'package:vetto_ai/widgets/floating_ai_icon.dart';

void main() {
  runApp(const VettoAIApp());
}

class VettoAIApp extends StatelessWidget {
  const VettoAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vetto AI',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash, // splash is now the starting route
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.onboarding: (context) => const OnboardingScreen(),
        AppRoutes.main: (context) => const MainWrapper(),
        AppRoutes.profile: (context) => const ProfilePage(),
        AppRoutes.chat: (context) => const ChatPage(),
        AppRoutes.workflows: (context) => const WorkflowManagerPage(),
        AppRoutes.siteBuilder: (context) => const SiteBuilderPage(),
      },
      // Uncomment if you want floating icon on non-onboarding screens
      // builder: (context, child) {
      //   final isOnboarding = ModalRoute.of(context)?.settings.name == AppRoutes.onboarding;
      //   return Stack(
      //     children: [
      //       child!,
      //       if (!isOnboarding)
      //         const Positioned(
      //           right: 20,
      //           bottom: 100,
      //           child: FloatingAiIcon(),
      //         ),
      //     ],
      //   );
      // },
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
  static const String main = '/main'; // kept for MainWrapper
}

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    WorkflowManagerPage(),
    ChatPage(),
    SiteBuilderPage(),
    ProfilePage(),
    SettingsPage(),    
  ];

  @override
  Widget build(BuildContext context) {
    assert(_pages.length == 5, 'Pages list must match BottomNavBar items count.');
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
