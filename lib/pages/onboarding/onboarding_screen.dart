// // // onboarding_screen.dart
// // import 'package:flutter/material.dart';
// // import 'package:vetto_ai/widgets/page_indicators.dart';
// // import '../../config/app_colors.dart';
// // import '../../config/constants.dart';
// // import '../../models/onboarding_slide.dart';
// // import '../../widgets/animated_button.dart';
// // // import 'package:flutter_svg/flutter_svg.dart';

// // import 'onboarding_slide1.dart';
// // import 'onboarding_slide2.dart';
// // import 'onboarding_slide3.dart';
// // import 'onboarding_slide4.dart';
// // import 'onboarding_slide5.dart';

// // class OnboardingScreen extends StatefulWidget {
// //   const OnboardingScreen({super.key});

// //   @override
// //   State<OnboardingScreen> createState() => _OnboardingScreenState();
// // }

// // class _OnboardingScreenState extends State<OnboardingScreen> with SingleTickerProviderStateMixin {
// //   final PageController _pageController = PageController();
// //   final List<OnboardingSlide> _slides = [];
// //   int _currentPage = 0;
// //   late AnimationController _animationController;
// //   late Animation<double> _fadeAnimation;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _animationController = AnimationController(
// //       duration: const Duration(milliseconds: 800),
// //       vsync: this,
// //     );
// //     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
// //       CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
// //     );

// //     _loadSlides();
// //     _animationController.forward();
// //   }

// //   void _loadSlides() {
// //     _slides.addAll([
// //       const OnboardingSlide(
// //         id: '1',
// //         title: 'Welcome to Vetto AI',
// //         description: 'Your offline-first AI ecosystem for global productivity',
// //         mainImage: 'assets/images/undraw_connected-world_anke.svg',
// //         doodleImages: [
// //           'assets/images/undraw_around-the-world_vgcy.svg',
// //           'assets/images/undraw_the-world-is-mine_wnib.svg',
// //         ],
// //         backgroundColor: Color(0xFF1E3A8A), // Blue
// //         textColor: Colors.white,
// //         features: ['Fully Offline AI', 'Cyberpunk Design', 'Global Accessibility'],
// //       ),
// //       const OnboardingSlide(
// //         id: '2',
// //         title: 'Smart Workflows',
// //         description: 'Automate tasks with AI-powered workflows that work anywhere',
// //         mainImage: 'assets/images/undraw_document-analysis_3c0y.svg',
// //         doodleImages: [
// //           'assets/images/undraw_work-friends_g4mn.svg',
// //           'assets/images/undraw_work-chat_hc3y.svg',
// //         ],
// //         backgroundColor: Color(0xFF065F46), // Green
// //         textColor: Colors.white,
// //         features: ['Drag & Drop Builder', 'AI Automation', 'Real-time Monitoring'],
// //       ),
// //       const OnboardingSlide(
// //         id: '3',
// //         title: 'Instant Site Builder',
// //         description: 'Create stunning websites with our cyberpunk templates',
// //         mainImage: 'assets/images/undraw_online-resume_z4sp.svg',
// //         doodleImages: [
// //           'assets/images/undraw_fill-the-blank_n29z.svg',
// //           'assets/images/undraw_typing_gcve.svg',
// //         ],
// //         backgroundColor: Color(0xFF7C3AED), // Purple
// //         textColor: Colors.white,
// //         features: ['50+ Templates', 'No Coding Required', 'Instant Deployment'],
// //       ),
// //       const OnboardingSlide(
// //         id: '4',
// //         title: 'AI Assistant',
// //         description: 'Your personal AI companion, always ready to help',
// //         mainImage: 'assets/images/undraw_voice-assistant_k27k.svg',
// //         doodleImages: [
// //           'assets/images/undraw_chat-with-ai_ir62.svg',
// //           'assets/images/undraw_messages_okui.svg',
// //         ],
// //         backgroundColor: Color(0xFFDC2626), // Red
// //         textColor: Colors.white,
// //         features: ['24/7 Available', 'Context Aware', 'Multi-language'],
// //       ),
// //       const OnboardingSlide(
// //         id: '5',
// //         title: 'Ready to Begin?',
// //         description: 'Join thousands of users building the future today',
// //         mainImage: 'assets/images/undraw_powerful_e1sw.svg',
// //         doodleImages: [
// //           'assets/images/undraw_join_6quk.svg',
// //           'assets/images/undraw_online-community_3o0l.svg',
// //         ],
// //         backgroundColor: Color(0xFF0891B2), // Cyan
// //         textColor: Colors.white,
// //         features: ['Get Started Now', 'Customize Your Experience', 'Join Community'],
// //       ),
// //     ]);
// //   }

// //   void _nextPage() {
// //     if (_currentPage < _slides.length - 1) {
// //       _pageController.nextPage(
// //         duration: const Duration(milliseconds: 500),
// //         curve: Curves.easeInOut,
// //       );
// //     } else {
// //       _completeOnboarding();
// //     }
// //   }

// //   void _previousPage() {
// //     if (_currentPage > 0) {
// //       _pageController.previousPage(
// //         duration: const Duration(milliseconds: 500),
// //         curve: Curves.easeInOut,
// //       );
// //     }
// //   }

// //   void _completeOnboarding() {
// //     Navigator.pushReplacementNamed(context, '/profile');
// //   }

// //   void _skipOnboarding() {
// //     _completeOnboarding();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final currentSlide = _slides.isEmpty ? null : _slides[_currentPage];
    
// //     return Scaffold(
// //       backgroundColor: currentSlide?.backgroundColor ?? AppColors.backgroundDark,
// //       body: SafeArea(
// //         child: AnimatedBuilder(
// //           animation: _fadeAnimation,
// //           builder: (context, child) {
// //             return FadeTransition(
// //               opacity: _fadeAnimation,
// //               child: Column(
// //                 children: [
// //                   // Skip Button - Wallet Style
// //                   if (_currentPage < _slides.length - 1)
// //                     Align(
// //                       alignment: Alignment.topRight,
// //                       child: Padding(
// //                         padding: const EdgeInsets.all(20),
// //                         child: GestureDetector(
// //                           onTap: _skipOnboarding,
// //                           child: Container(
// //                             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //                             decoration: BoxDecoration(
// //                               color: Colors.white.withValues(alpha: 0.1),
// //                               borderRadius: BorderRadius.circular(20),
// //                               border: Border.all(
// //                                 color: Colors.white.withValues(alpha: 0.5),
// //                                 width: 1.5,
// //                               ),
// //                             ),
// //                             child: const Text(
// //                               'Skip',
// //                               style: TextStyle(
// //                                 color: Colors.white,
// //                                 fontSize: 14,
// //                                 fontWeight: FontWeight.w600,
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ),

// //                   // Page View
// //                   Expanded(
// //                     child: PageView(
// //                       controller: _pageController,
// //                       onPageChanged: (page) {
// //                         setState(() {
// //                           _currentPage = page;
// //                         });
// //                       },
// //                       children: const [
// //                         OnboardingSlide1(),
// //                         OnboardingSlide2(),
// //                         OnboardingSlide3(),
// //                         OnboardingSlide4(),
// //                         OnboardingSlide5(),
// //                       ],
// //                     ),
// //                   ),

// //                   // Bottom Section
// //                   Container(
// //                     padding: const EdgeInsets.all(AppConstants.spacingXL),
// //                     decoration: BoxDecoration(
// //                       gradient: LinearGradient(
// //                         begin: Alignment.topCenter,
// //                         end: Alignment.bottomCenter,
// //                         colors: [
// //                           Colors.transparent,
// //                           currentSlide?.backgroundColor.withValues(alpha: 0.9) ?? AppColors.backgroundDark,
// //                         ],
// //                       ),
// //                     ),
// //                     child: Column(
// //                       children: [
// //                         // Page Indicators
// //                         PageIndicators(
// //                           currentPage: _currentPage,
// //                           totalPages: _slides.length,
// //                           activeColor: currentSlide?.textColor ?? AppColors.neonCyan,
// //                           inactiveColor: Colors.white.withValues(alpha: 0.3),
// //                         ),

// //                         const SizedBox(height: AppConstants.spacingXL),

// //                         // Navigation Buttons
// //                         Row(
// //                           children: [
// //                             if (_currentPage > 0)
// //                               Expanded(
// //                                 child: Container(
// //                                   decoration: BoxDecoration(
// //                                     borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
// //                                     border: Border.all(color: Colors.white),
// //                                   ),
// //                                   child: TextButton(
// //                                     onPressed: _previousPage,
// //                                     style: TextButton.styleFrom(
// //                                       padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingM),
// //                                       shape: RoundedRectangleBorder(
// //                                         borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
// //                                       ),
// //                                     ),
// //                                     child: const Text(
// //                                       'Back',
// //                                       style: TextStyle(
// //                                         color: Colors.white,
// //                                         fontSize: AppConstants.fontSizeM,
// //                                         fontWeight: FontWeight.w600,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                             if (_currentPage > 0) const SizedBox(width: AppConstants.spacingM),
// //                             Expanded(
// //                               flex: _currentPage > 0 ? 1 : 2,
// //                               child: AnimatedButton(
// //                                 text: _currentPage == _slides.length - 1 ? 'Get Started' : 'Next',
// //                                 onPressed: _nextPage,
// //                                 type: ButtonType.primary,
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _pageController.dispose();
// //     _animationController.dispose();
// //     super.dispose();
// //   }
// // }




// // onboarding_screen.dart
// import 'package:flutter/material.dart';
// import 'package:vetto_ai/widgets/page_indicators.dart';
// import '../../config/app_colors.dart';
// import '../../config/constants.dart';
// import '../../models/onboarding_slide.dart';
// import '../../widgets/animated_button.dart';
// import 'onboarding_slide1.dart';
// import 'onboarding_slide2.dart';
// import 'onboarding_slide3.dart';
// import 'onboarding_slide4.dart';
// import 'onboarding_slide5.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> with SingleTickerProviderStateMixin {
//   final PageController _pageController = PageController();
//   final List<OnboardingSlide> _slides = [];
//   int _currentPage = 0;
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
//     );

//     _loadSlides();
//     _animationController.forward();
//   }

//   void _loadSlides() {
//     _slides.addAll([
//       const OnboardingSlide(
//         id: '1',
//         title: 'Welcome to Vetto AI',
//         description: 'Your offline-first AI ecosystem for global productivity',
//         mainImage: 'assets/images/undraw_connected-world_anke.svg',
//         doodleImages: [
//           'assets/images/undraw_around-the-world_vgcy.svg',
//           'assets/images/undraw_the-world-is-mine_wnib.svg',
//         ],
//         backgroundColor: Color(0xFF1E3A8A),
//         textColor: Colors.white,
//         features: ['Fully Offline AI', 'Cyberpunk Design', 'Global Accessibility'],
//       ),
//       const OnboardingSlide(
//         id: '2',
//         title: 'Smart Workflows',
//         description: 'Automate tasks with AI-powered workflows that work anywhere',
//         mainImage: 'assets/images/undraw_document-analysis_3c0y.svg',
//         doodleImages: [
//           'assets/images/undraw_work-friends_g4mn.svg',
//           'assets/images/undraw_work-chat_hc3y.svg',
//         ],
//         backgroundColor: Color(0xFF065F46),
//         textColor: Colors.white,
//         features: ['Drag & Drop Builder', 'AI Automation', 'Real-time Monitoring'],
//       ),
//       const OnboardingSlide(
//         id: '3',
//         title: 'Instant Site Builder',
//         description: 'Create stunning websites with our cyberpunk templates',
//         mainImage: 'assets/images/undraw_online-resume_z4sp.svg',
//         doodleImages: [
//           'assets/images/undraw_fill-the-blank_n29z.svg',
//           'assets/images/undraw_typing_gcve.svg',
//         ],
//         backgroundColor: Color(0xFF7C3AED),
//         textColor: Colors.white,
//         features: ['50+ Templates', 'No Coding Required', 'Instant Deployment'],
//       ),
//       const OnboardingSlide(
//         id: '4',
//         title: 'AI Assistant',
//         description: 'Your personal AI companion, always ready to help',
//         mainImage: 'assets/images/undraw_voice-assistant_k27k.svg',
//         doodleImages: [
//           'assets/images/undraw_chat-with-ai_ir62.svg',
//           'assets/images/undraw_messages_okui.svg',
//         ],
//         backgroundColor: Color(0xFFDC2626),
//         textColor: Colors.white,
//         features: ['24/7 Available', 'Context Aware', 'Multi-language'],
//       ),
//       const OnboardingSlide(
//         id: '5',
//         title: 'Ready to Begin?',
//         description: 'Join thousands of users building the future today',
//         mainImage: 'assets/images/undraw_powerful_e1sw.svg',
//         doodleImages: [
//           'assets/images/undraw_join_6quk.svg',
//           'assets/images/undraw_online-community_3o0l.svg',
//         ],
//         backgroundColor: Color(0xFF0891B2),
//         textColor: Colors.white,
//         features: ['Get Started Now', 'Customize Your Experience', 'Join Community'],
//       ),
//     ]);
//   }

//   void _nextPage() {
//     if (_currentPage < _slides.length - 1) {
//       _pageController.nextPage(
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//       );
//     } else {
//       _completeOnboarding();
//     }
//   }

//   void _previousPage() {
//     if (_currentPage > 0) {
//       _pageController.previousPage(
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//       );
//     }
//   }

//   void _completeOnboarding() {
//     Navigator.pushReplacementNamed(context, '/main');
//   }

//   void _skipOnboarding() {
//     _completeOnboarding();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final currentSlide = _slides.isEmpty ? null : _slides[_currentPage];
    
//     return Scaffold(
//       backgroundColor: currentSlide?.backgroundColor ?? AppColors.backgroundDark,
//       body: SafeArea(
//         child: AnimatedBuilder(
//           animation: _fadeAnimation,
//           builder: (context, child) {
//             return FadeTransition(
//               opacity: _fadeAnimation,
//               child: Column(
//                 children: [
//                   // Skip Button at Top Right
//                   if (_currentPage < _slides.length - 1)
//                     Align(
//                       alignment: Alignment.topRight,
//                       child: Padding(
//                         padding: const EdgeInsets.all(20),
//                         child: GestureDetector(
//                           onTap: _skipOnboarding,
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                             decoration: BoxDecoration(
//                               color: Colors.white.withValues(alpha: 0.1),
//                               borderRadius: BorderRadius.circular(20),
//                               border: Border.all(
//                                 color: Colors.white.withValues(alpha: 0.5),
//                                 width: 1.5,
//                               ),
//                             ),
//                             child: const Text(
//                               'Skip',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),

//                   // Page View
//                   Expanded(
//                     child: PageView(
//                       controller: _pageController,
//                       onPageChanged: (page) {
//                         setState(() {
//                           _currentPage = page;
//                         });
//                       },
//                       children: const [
//                         OnboardingSlide1(),
//                         OnboardingSlide2(),
//                         OnboardingSlide3(),
//                         OnboardingSlide4(),
//                         OnboardingSlide5(),
//                       ],
//                     ),
//                   ),

//                   // Bottom Section - Reduced margin
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: AppConstants.spacingXL,
//                       vertical: AppConstants.spacingM, // Reduced margin
//                     ),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           Colors.transparent,
//                           currentSlide?.backgroundColor.withValues(alpha: 0.9) ?? AppColors.backgroundDark,
//                         ],
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         // Page Indicators
//                         PageIndicators(
//                           currentPage: _currentPage,
//                           totalPages: _slides.length,
//                           activeColor: currentSlide?.textColor ?? AppColors.neonCyan,
//                           inactiveColor: Colors.white.withValues(alpha: 0.3),
//                         ),

//                         const SizedBox(height: AppConstants.spacingM), // Reduced spacing

//                         // Navigation Buttons - Back/Next at bottom
//                         Row(
//                           children: [
//                             // Show Back button on all pages except first
//                             if (_currentPage > 0)
//                               Expanded(
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
//                                     border: Border.all(color: Colors.white),
//                                   ),
//                                   child: TextButton(
//                                     onPressed: _previousPage,
//                                     style: TextButton.styleFrom(
//                                       padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingM),
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
//                                       ),
//                                     ),
//                                     child: const Text(
//                                       'Back',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: AppConstants.fontSizeM,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
                            
//                             // Spacing between buttons when both are visible
//                             if (_currentPage > 0) const SizedBox(width: AppConstants.spacingM),
                            
//                             // Next/Get Started button
//                             Expanded(
//                               flex: _currentPage == 0 ? 2 : 1, // Wide only on first page
//                               child: AnimatedButton(
//                                 text: _currentPage == _slides.length - 1 ? 'Get Started' : 'Next',
//                                 onPressed: _nextPage,
//                                 type: ButtonType.primary,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     _animationController.dispose();
//     super.dispose();
//   }
// }



import 'package:flutter/material.dart';
import 'package:vetto_ai/widgets/page_indicators.dart';
import '../../config/app_colors.dart';
import '../../config/constants.dart';
import '../../models/onboarding_slide.dart';
import '../../widgets/animated_button.dart';

import 'onboarding_slide1.dart';
import 'onboarding_slide2.dart';
import 'onboarding_slide3.dart';
import 'onboarding_slide4.dart';
import 'onboarding_slide5.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  final List<OnboardingSlide> _slides = [];
  int _currentPage = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _loadSlides();
    _animationController.forward();
  }

  void _loadSlides() {
    _slides.addAll([
      const OnboardingSlide(
        id: '1',
        title: 'Welcome to Vetto AI',
        description: 'Your offline-first AI ecosystem for global productivity',
        mainImage: 'assets/images/undraw_connected-world_anke.svg',
        doodleImages: [
          'assets/images/undraw_around-the-world_vgcy.svg',
          'assets/images/undraw_the-world-is-mine_wnib.svg',
        ],
        // Slide 1: Deep Navy mixed with Olive (Darker, less saturated Blue)
        backgroundColor: Color(0xFF142433), 
        textColor: Colors.white,
        features: ['Fully Offline AI', 'Cyberpunk Design', 'Global Accessibility'],
      ),
      const OnboardingSlide(
        id: '2',
        title: 'Smart Workflows',
        description: 'Automate tasks with AI-powered workflows that work anywhere',
        mainImage: 'assets/images/undraw_document-analysis_3c0y.svg',
        doodleImages: [
          'assets/images/undraw_work-friends_g4mn.svg',
          'assets/images/undraw_work-chat_hc3y.svg',
        ],
        // Slide 2: Deep Jungle Olive (Darker Green)
        backgroundColor: Color(0xFF1B3320), 
        textColor: Colors.white,
        features: ['Drag & Drop Builder', 'AI Automation', 'Real-time Monitoring'],
      ),
      const OnboardingSlide(
        id: '3',
        title: 'Instant Site Builder',
        description: 'Create stunning websites with our cyberpunk templates',
        mainImage: 'assets/images/undraw_online-resume_z4sp.svg',
        doodleImages: [
          'assets/images/undraw_fill-the-blank_n29z.svg',
          'assets/images/undraw_typing_gcve.svg',
        ],
        // Slide 3: Deep Plum Olive (Darker, Murky Purple)
        backgroundColor: Color(0xFF251F33), 
        textColor: Colors.white,
        features: ['50+ Templates', 'No Coding Required', 'Instant Deployment'],
      ),
      const OnboardingSlide(
        id: '4',
        title: 'AI Assistant',
        description: 'Your personal AI companion, always ready to help',
        mainImage: 'assets/images/undraw_voice-assistant_k27k.svg',
        doodleImages: [
          'assets/images/undraw_chat-with-ai_ir62.svg',
          'assets/images/undraw_messages_okui.svg',
        ],
        // Slide 4: Deep Rust/Maroon (Darker Red blended with dark tones)
        backgroundColor: Color(0xFF331A1A), 
        textColor: Colors.white,
        features: ['24/7 Available', 'Context Aware', 'Multi-language'],
      ),
      const OnboardingSlide(
        id: '5',
        title: 'Ready to Begin?',
        description: 'Join thousands of users building the future today',
        mainImage: 'assets/images/undraw_powerful_e1sw.svg',
        doodleImages: [
          'assets/images/undraw_join_6quk.svg',
          'assets/images/undraw_online-community_3o0l.svg',
        ],
        // Slide 5: Deep Petrol/Teal (Darker Cyan blended with Olive)
        backgroundColor: Color(0xFF143336), 
        textColor: Colors.white,
        features: ['Get Started Now', 'Customize Your Experience', 'Join Community'],
      ),
    ]);
  }

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 600), // Smoother transition
        curve: Curves.easeOutCubic,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 600), // Smoother transition
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _completeOnboarding() {
    Navigator.pushReplacementNamed(context, '/main');
  }

  void _skipOnboarding() {
    _completeOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    final currentSlide = _slides.isEmpty ? null : _slides[_currentPage];
    
    // Default fallback if list empty
    final bgColor = currentSlide?.backgroundColor ?? const Color(0xFF142433);

    return Scaffold(
      backgroundColor: Colors.black, // Base for the container to sit on
      body: Stack(
        children: [
          // 1. ANIMATED BACKGROUND GRADIENT
          // Blends specific slide color (Top) into a unified Deep Olive/Black (Bottom)
          AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  bgColor, // The specific slide color (blended dark version)
                  const Color(0xFF0A0F0D), // Shared Deep Olive-Black anchor
                ],
                // Push the color down a bit so the top feels rich
                stops: const [0.2, 1.0], 
              ),
            ),
          ),

          // 2. CONTENT
          SafeArea(
            child: AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      // Skip Button
                      if (_currentPage < _slides.length - 1)
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: GestureDetector(
                              onTap: _skipOnboarding,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.05),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    width: 1.0,
                                  ),
                                ),
                                child: const Text(
                                  'Skip',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      // Page View
                      Expanded(
                        child: PageView(
                          controller: _pageController,
                          onPageChanged: (page) {
                            setState(() {
                              _currentPage = page;
                            });
                          },
                          children: const [
                            // Ensure these slides have transparent backgrounds in their files!
                            OnboardingSlide1(),
                            OnboardingSlide2(),
                            OnboardingSlide3(),
                            OnboardingSlide4(),
                            OnboardingSlide5(),
                          ],
                        ),
                      ),

                      // Bottom Section
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.spacingXL,
                          vertical: AppConstants.spacingM,
                        ),
                        child: Column(
                          children: [
                            // Page Indicators
                            PageIndicators(
                              currentPage: _currentPage,
                              totalPages: _slides.length,
                              // Use the Neon Cyan for pop, or white for subtlety
                              activeColor: AppColors.neonCyan, 
                              inactiveColor: Colors.white.withValues(alpha: 0.2),
                            ),

                            const SizedBox(height: AppConstants.spacingM),

                            // Navigation Buttons
                            Row(
                              children: [
                                // Back Button
                                if (_currentPage > 0)
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
                                        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                                      ),
                                      child: TextButton(
                                        onPressed: _previousPage,
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingM),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
                                          ),
                                        ),
                                        child: const Text(
                                          'Back',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: AppConstants.fontSizeM,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                
                                if (_currentPage > 0) const SizedBox(width: AppConstants.spacingM),
                                
                                // Next/Get Started Button
                                Expanded(
                                  flex: _currentPage == 0 ? 2 : 1,
                                  child: AnimatedButton(
                                    text: _currentPage == _slides.length - 1 ? 'Get Started' : 'Next',
                                    onPressed: _nextPage,
                                    type: ButtonType.primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}