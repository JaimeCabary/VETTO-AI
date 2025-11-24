import 'package:flutter/material.dart';
import 'config/app_theme.dart';
import 'pages/onboarding/onboarding_screen.dart'; // Add this import
import 'pages/splash_screen.dart';
import 'pages/profile_page.dart';
import 'pages/chat_page.dart';
import 'pages/settings_page.dart';
import 'pages/workflow_manager_page.dart';
import 'pages/site_builder_page.dart';
import 'widgets/floating_ai_icon.dart';

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
      initialRoute: AppRoutes.onboarding, // Change to onboarding
      routes: {
        AppRoutes.onboarding: (context) => const OnboardingScreen(), // Add this
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.profile: (context) => const ProfilePage(),
        AppRoutes.chat: (context) => const ChatPage(),
        AppRoutes.settings: (context) => const SettingsPage(),
        AppRoutes.workflows: (context) => const WorkflowManagerPage(),
        AppRoutes.siteBuilder: (context) => const SiteBuilderPage(),
      },
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            const Positioned(
              right: 20,
              bottom: 100,
              child: FloatingAiIcon(),
            ),
          ],
        );
      },
    );
  }
}

class AppRoutes {
  static const String onboarding = '/'; // Add this
  static const String splash = '/splash';
  static const String profile = '/profile';
  static const String chat = '/chat';
  static const String settings = '/settings';
  static const String workflows = '/workflows';
  static const String siteBuilder = '/site-builder';
}