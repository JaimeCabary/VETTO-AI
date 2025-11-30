// import 'package:flutter/material.dart';
// import 'package:uruella_ai/widgets/page_indicators.dart';
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
//         // Slide 1: Deep Navy mixed with Olive (Darker, less saturated Blue)
//         backgroundColor: Color(0xFF142433), 
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
//         // Slide 2: Deep Jungle Olive (Darker Green)
//         backgroundColor: Color(0xFF1B3320), 
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
//         // Slide 3: Deep Plum Olive (Darker, Murky Purple)
//         backgroundColor: Color(0xFF251F33), 
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
//         // Slide 4: Deep Rust/Maroon (Darker Red blended with dark tones)
//         backgroundColor: Color(0xFF331A1A), 
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
//         // Slide 5: Deep Petrol/Teal (Darker Cyan blended with Olive)
//         backgroundColor: Color(0xFF143336), 
//         textColor: Colors.white,
//         features: ['Get Started Now', 'Customize Your Experience', 'Join Community'],
//       ),
//     ]);
//   }

//   void _nextPage() {
//     if (_currentPage < _slides.length - 1) {
//       _pageController.nextPage(
//         duration: const Duration(milliseconds: 600), // Smoother transition
//         curve: Curves.easeOutCubic,
//       );
//     } else {
//       _completeOnboarding();
//     }
//   }

//   void _previousPage() {
//     if (_currentPage > 0) {
//       _pageController.previousPage(
//         duration: const Duration(milliseconds: 600), // Smoother transition
//         curve: Curves.easeOutCubic,
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
    
//     // Default fallback if list empty
//     final bgColor = currentSlide?.backgroundColor ?? const Color(0xFF142433);

//     return Scaffold(
//       backgroundColor: Colors.black, // Base for the container to sit on
//       body: Stack(
//         children: [
//           // 1. ANIMATED BACKGROUND GRADIENT
//           // Blends specific slide color (Top) into a unified Deep Olive/Black (Bottom)
//           AnimatedContainer(
//             duration: const Duration(milliseconds: 600),
//             curve: Curves.easeInOut,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   bgColor, // The specific slide color (blended dark version)
//                   const Color(0xFF0A0F0D), // Shared Deep Olive-Black anchor
//                 ],
//                 // Push the color down a bit so the top feels rich
//                 stops: const [0.2, 1.0], 
//               ),
//             ),
//           ),

//           // 2. CONTENT
//           SafeArea(
//             child: AnimatedBuilder(
//               animation: _fadeAnimation,
//               builder: (context, child) {
//                 return FadeTransition(
//                   opacity: _fadeAnimation,
//                   child: Column(
//                     children: [
//                       // Skip Button
//                       if (_currentPage < _slides.length - 1)
//                         Align(
//                           alignment: Alignment.topRight,
//                           child: Padding(
//                             padding: const EdgeInsets.all(20),
//                             child: GestureDetector(
//                               onTap: _skipOnboarding,
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white.withValues(alpha: 0.05),
//                                   borderRadius: BorderRadius.circular(20),
//                                   border: Border.all(
//                                     color: Colors.white.withValues(alpha: 0.2),
//                                     width: 1.0,
//                                   ),
//                                 ),
//                                 child: const Text(
//                                   'Skip',
//                                   style: TextStyle(
//                                     color: Colors.white70,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),

//                       // Page View
//                       Expanded(
//                         child: PageView(
//                           controller: _pageController,
//                           onPageChanged: (page) {
//                             setState(() {
//                               _currentPage = page;
//                             });
//                           },
//                           children: const [
//                             // Ensure these slides have transparent backgrounds in their files!
//                             OnboardingSlide1(),
//                             OnboardingSlide2(),
//                             OnboardingSlide3(),
//                             OnboardingSlide4(),
//                             OnboardingSlide5(),
//                           ],
//                         ),
//                       ),

//                       // Bottom Section
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: AppConstants.spacingXL,
//                           vertical: AppConstants.spacingM,
//                         ),
//                         child: Column(
//                           children: [
//                             // Page Indicators
//                             PageIndicators(
//                               currentPage: _currentPage,
//                               totalPages: _slides.length,
//                               // Use the Neon Cyan for pop, or white for subtlety
//                               activeColor: AppColors.neonCyan, 
//                               inactiveColor: Colors.white.withValues(alpha: 0.2),
//                             ),

//                             const SizedBox(height: AppConstants.spacingM),

//                             // Navigation Buttons
//                             Row(
//                               children: [
//                                 // Back Button
//                                 if (_currentPage > 0)
//                                   Expanded(
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
//                                         border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
//                                       ),
//                                       child: TextButton(
//                                         onPressed: _previousPage,
//                                         style: TextButton.styleFrom(
//                                           padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingM),
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
//                                           ),
//                                         ),
//                                         child: const Text(
//                                           'Back',
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: AppConstants.fontSizeM,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
                                
//                                 if (_currentPage > 0) const SizedBox(width: AppConstants.spacingM),
                                
//                                 // Next/Get Started Button
//                                 Expanded(
//                                   flex: _currentPage == 0 ? 2 : 1,
//                                   child: AnimatedButton(
//                                     text: _currentPage == _slides.length - 1 ? 'Get Started' : 'Next',
//                                     onPressed: _nextPage,
//                                     type: ButtonType.primary,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
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




// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uruella_ai/widgets/page_indicators.dart';
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
  
//   // Controller for the name input with default value
//   final TextEditingController _nameController = TextEditingController(text: "Alex Chen");

//   @override
//   void initState() {
//     super.initState();
//     _checkOnboardingStatus(); // 1. Check persistence on init

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

//   // Check if onboarding is already done
//   Future<void> _checkOnboardingStatus() async {
//     final prefs = await SharedPreferences.getInstance();
//     final bool isDone = prefs.getBool('onboarding_completed') ?? false;
    
//     if (isDone && mounted) {
//       Navigator.pushReplacementNamed(context, '/main');
//     }
//   }

//   void _loadSlides() {
//     _slides.addAll([
//       const OnboardingSlide(
//         id: '1',
//         title: 'Welcome to Vetto AI',
//         description: 'Your offline-first AI ecosystem for global productivity',
//         mainImage: 'assets/images/undraw_connected-world_anke.svg',
//         doodleImages: [],
//         backgroundColor: Color(0xFF142433), 
//         textColor: Colors.white,
//         features: [],
//       ),
//       const OnboardingSlide(
//         id: '2',
//         title: 'Smart Workflows',
//         description: 'Automate tasks with AI-powered workflows',
//         mainImage: 'assets/images/undraw_document-analysis_3c0y.svg',
//         doodleImages: [],
//         backgroundColor: Color(0xFF1B3320), 
//         textColor: Colors.white,
//         features: [],
//       ),
//       const OnboardingSlide(
//         id: '3',
//         title: 'Instant Site Builder',
//         description: 'Create stunning websites with our cyberpunk templates',
//         mainImage: 'assets/images/undraw_online-resume_z4sp.svg',
//         doodleImages: [],
//         backgroundColor: Color(0xFF251F33), 
//         textColor: Colors.white,
//         features: [],
//       ),
//       const OnboardingSlide(
//         id: '4',
//         title: 'AI Assistant',
//         description: 'Your personal AI companion, always ready to help',
//         mainImage: 'assets/images/undraw_voice-assistant_k27k.svg',
//         doodleImages: [],
//         backgroundColor: Color(0xFF331A1A), 
//         textColor: Colors.white,
//         features: [],
//       ),
//       const OnboardingSlide(
//         id: '5',
//         title: 'Ready to Begin?',
//         description: 'Join thousands of users building the future today',
//         mainImage: 'assets/images/undraw_powerful_e1sw.svg',
//         doodleImages: [],
//         backgroundColor: Color(0xFF143336), 
//         textColor: Colors.white,
//         features: [],
//       ),
//     ]);
//   }

//   void _nextPage() {
//     if (_currentPage < _slides.length - 1) {
//       _pageController.nextPage(
//         duration: const Duration(milliseconds: 600),
//         curve: Curves.easeOutCubic,
//       );
//     } else {
//       // If on last page, show modal
//       _showNameInputModal();
//     }
//   }

//   void _previousPage() {
//     if (_currentPage > 0) {
//       _pageController.previousPage(
//         duration: const Duration(milliseconds: 600),
//         curve: Curves.easeOutCubic,
//       );
//     }
//   }

//   // Modified: Skips to the last slide instead of completing immediately
//   void _skipOnboarding() {
//     _pageController.animateToPage(
//       _slides.length - 1, 
//       duration: const Duration(milliseconds: 800), 
//       curve: Curves.easeInOutCubic,
//     );
//   }

//   // Show Bottom Sheet Modal
//   void _showNameInputModal() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true, // Needed to push sheet up with keyboard
//       backgroundColor: const Color(0xFF0A0F0D),
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
//       ),
//       builder: (BuildContext context) {
//         return Padding(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//             left: 20, 
//             right: 20, 
//             top: 20
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Container(
//                   width: 40, 
//                   height: 4, 
//                   decoration: BoxDecoration(
//                     color: Colors.white24, 
//                     borderRadius: BorderRadius.circular(2)
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 "Let's get to know you",
//                 style: TextStyle(
//                   color: Colors.white, 
//                   fontSize: 20, 
//                   fontWeight: FontWeight.bold
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 "What should we call you?",
//                 style: TextStyle(color: Colors.white70, fontSize: 14),
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: _nameController,
//                 style: const TextStyle(color: Colors.white),
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white.withValues(alpha: 0.1),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide.none,
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: const BorderSide(color: AppColors.neonCyan),
//                   ),
//                   prefixIcon: const Icon(Icons.person_outline, color: AppColors.neonCyan),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               SizedBox(
//                 width: double.infinity,
//                 child: AnimatedButton(
//                   text: 'Complete Setup',
//                   onPressed: () {
//                     _completeOnboardingAndSave();
//                   },
//                   type: ButtonType.primary,
//                 ),
//               ),
//               const SizedBox(height: 30),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _completeOnboardingAndSave() async {
//     final prefs = await SharedPreferences.getInstance();
//     // Save completion status
//     await prefs.setBool('onboarding_completed', true);
//     // Save user name
//     await prefs.setString('user_name', _nameController.text);
    
//     if (mounted) {
//       Navigator.pop(context); // Close modal
//       Navigator.pushReplacementNamed(context, '/main'); // Go to main
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final currentSlide = _slides.isEmpty ? null : _slides[_currentPage];
//     final bgColor = currentSlide?.backgroundColor ?? const Color(0xFF142433);
    
//     // Check if we are on the last slide
//     final bool isLastSlide = _currentPage == _slides.length - 1;

//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           // 1. ANIMATED BACKGROUND GRADIENT
//           AnimatedContainer(
//             duration: const Duration(milliseconds: 600),
//             curve: Curves.easeInOut,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   bgColor,
//                   const Color(0xFF0A0F0D),
//                 ],
//                 stops: const [0.2, 1.0], 
//               ),
//             ),
//           ),

//           // 2. CONTENT
//           SafeArea(
//             child: AnimatedBuilder(
//               animation: _fadeAnimation,
//               builder: (context, child) {
//                 return FadeTransition(
//                   opacity: _fadeAnimation,
//                   child: Column(
//                     children: [
//                       // Skip Button - Hide on last slide
//                       if (!isLastSlide)
//                         Align(
//                           alignment: Alignment.topRight,
//                           child: Padding(
//                             padding: const EdgeInsets.all(20),
//                             child: GestureDetector(
//                               onTap: _skipOnboarding,
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white.withValues(alpha: 0.05),
//                                   borderRadius: BorderRadius.circular(20),
//                                   border: Border.all(
//                                     color: Colors.white.withValues(alpha: 0.2),
//                                     width: 1.0,
//                                   ),
//                                 ),
//                                 child: const Text(
//                                   'Skip',
//                                   style: TextStyle(
//                                     color: Colors.white70,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )
//                       else 
//                         const SizedBox(height: 70), // Placeholder to keep spacing consistent

//                       // Page View
//                       Expanded(
//                         child: PageView(
//                           controller: _pageController,
//                           onPageChanged: (page) {
//                             setState(() {
//                               _currentPage = page;
//                             });
//                           },
//                           children: const [
//                             OnboardingSlide1(),
//                             OnboardingSlide2(),
//                             OnboardingSlide3(),
//                             OnboardingSlide4(),
//                             OnboardingSlide5(),
//                           ],
//                         ),
//                       ),

//                       // Bottom Section
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: AppConstants.spacingXL,
//                           vertical: AppConstants.spacingM,
//                         ),
//                         child: Column(
//                           children: [
//                             // Page Indicators
//                             PageIndicators(
//                               currentPage: _currentPage,
//                               totalPages: _slides.length,
//                               activeColor: AppColors.neonCyan, 
//                               inactiveColor: Colors.white.withValues(alpha: 0.2),
//                             ),

//                             const SizedBox(height: AppConstants.spacingM),

//                             // Navigation Buttons
//                             // Logic: If last slide, show wide "Get Started" only. Else show Back/Next.
//                             if (isLastSlide)
//                                SizedBox(
//                                 width: double.infinity,
//                                 child: AnimatedButton(
//                                   text: 'Get Started',
//                                   onPressed: _nextPage, // This calls the modal logic
//                                   type: ButtonType.primary,
//                                 ),
//                               )
//                             else
//                               Row(
//                                 children: [
//                                   // Back Button
//                                   if (_currentPage > 0)
//                                     Expanded(
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
//                                           border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
//                                         ),
//                                         child: TextButton(
//                                           onPressed: _previousPage,
//                                           style: TextButton.styleFrom(
//                                             padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingM),
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
//                                             ),
//                                           ),
//                                           child: const Text(
//                                             'Back',
//                                             style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: AppConstants.fontSizeM,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
                                  
//                                   if (_currentPage > 0) const SizedBox(width: AppConstants.spacingM),
                                  
//                                   // Next Button
//                                   Expanded(
//                                     flex: _currentPage == 0 ? 2 : 1,
//                                     child: AnimatedButton(
//                                       text: 'Next',
//                                       onPressed: _nextPage,
//                                       type: ButtonType.primary,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     _animationController.dispose();
//     _nameController.dispose();
//     super.dispose();
//   }
// }



import 'dart:ui'; // Required for BackdropFilter
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uruella_ai/widgets/page_indicators.dart';
// import '../../config/app_colors.dart';
// import '../../config/constants.dart';
// import '../../models/onboarding_slide.dart';
// import '../../widgets/animated_button.dart';

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
  
  // List of your slide widgets
  final List<Widget> _slideWidgets = const [
    OnboardingSlide1(),
    OnboardingSlide2(),
    OnboardingSlide3(),
    OnboardingSlide4(),
    OnboardingSlide5(),
  ];
  
  int _currentPage = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  final TextEditingController _nameController = TextEditingController(text: "Alex Chen");

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  Future<void> _checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isDone = prefs.getBool('onboarding_completed') ?? false;
    
    if (isDone && mounted) {
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  void _nextPage() {
    if (_currentPage < _slideWidgets.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      );
    } else {
      _showNameInputModal();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _skipOnboarding() {
    _pageController.animateToPage(
      _slideWidgets.length - 1, 
      duration: const Duration(milliseconds: 800), 
      curve: Curves.easeInOutCubic,
    );
  }

  // Updated Modal with Matte Charcoal Vibe
  void _showNameInputModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Transparent to allow blur
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)), // Sharp/Swiss corners
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 30,
                left: 30, 
                right: 30, 
                top: 30
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF121212).withValues(alpha:0.95), // Matte Charcoal
                border: Border(top: BorderSide(color: Colors.white.withValues(alpha:0.1))),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40, height: 2, 
                      decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(0))
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "IDENTITY",
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 24, 
                      fontWeight: FontWeight.w900, // Heavy Weight
                      letterSpacing: -1.0
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "How should the system address you?",
                    style: TextStyle(color: Colors.white.withValues(alpha:0.5), fontSize: 14),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: _nameController,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    cursorColor: const Color(0xFFB5A642), // Gold/Olive Accent
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withValues(alpha:0.05),
                      labelText: "NAME",
                      labelStyle: TextStyle(color: Colors.white.withValues(alpha:0.3), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: const BorderSide(color: Colors.white30),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _completeOnboardingAndSave,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                      ),
                      child: const Text('INITIALIZE SYSTEM', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.0)),
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

  Future<void> _completeOnboardingAndSave() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
    await prefs.setString('user_name', _nameController.text);
    
    if (mounted) {
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastSlide = _currentPage == _slideWidgets.length - 1;
    final bool isFirstSlide = _currentPage == 0;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // --- 1. PREMIUM DARK BACKGROUND ---
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF121212), // Matte Charcoal
                  Color(0xFF000000), // Obsidian
                ],
              ),
            ),
          ),

          // --- 2. SPOTLIGHT ---
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
                    Colors.white.withValues(alpha: 0.07), 
                    Colors.transparent,
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
          ),

          // --- 3. TEXTURE ---
          Positioned(
            bottom: -60,
            right: -20,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Text(
                "0${_currentPage + 1}", 
                key: ValueKey<int>(_currentPage),
                style: TextStyle(
                  fontSize: 200,
                  fontWeight: FontWeight.w900,
                  color: Colors.white.withValues(alpha: 0.02), 
                  letterSpacing: -10.0,
                  height: 1.0,
                ),
              ),
            ),
          ),

          // --- 4. CONTENT ---
          SafeArea(
            child: AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      // Skip Button
                      if (!isLastSlide)
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: GestureDetector(
                              onTap: _skipOnboarding,
                              child: Text(
                                'SKIP',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.5),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                        )
                      else 
                        const SizedBox(height: 64),

                      // Slide Content
                      Expanded(
                        child: PageView(
                          controller: _pageController,
                          onPageChanged: (page) => setState(() => _currentPage = page),
                          children: _slideWidgets,
                        ),
                      ),

                      // Bottom Controls
                      Container(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 40), // Reduced bottom padding slightly
                        child: Column(
                          children: [
                            // Indicators
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(_slideWidgets.length, (index) {
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  height: 4,
                                  width: _currentPage == index ? 24 : 4,
                                  decoration: BoxDecoration(
                                    color: _currentPage == index ? Colors.white : Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(0), // Sharp
                                  ),
                                );
                              }),
                            ),

                            const SizedBox(height: 40),

                            // BUTTON LOGIC
                            if (isLastSlide)
                              // Last Slide: Wide "GET STARTED"
                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton(
                                  onPressed: _nextPage,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                                    elevation: 0,
                                  ),
                                  child: const Text('GET STARTED', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.0)),
                                ),
                              )
                            else if (isFirstSlide)
                              // First Slide: Wide "DIVE IN"
                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton(
                                  onPressed: _nextPage,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                                    elevation: 0,
                                  ),
                                  child: const Text('DIVE IN', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.0)),
                                ),
                              )
                            else
                              // Middle Slides: Back (Outlined) & Next (Filled)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Outlined Back Button
                                  Expanded(
                                    child: SizedBox(
                                      height: 56,
                                      child: OutlinedButton(
                                        onPressed: _previousPage,
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                                          foregroundColor: Colors.white,
                                        ),
                                        child: const Text('BACK', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 1.0)),
                                      ),
                                    ),
                                  ),
                                  
                                  const SizedBox(width: 16), // Spacer between buttons
                                  
                                  // Next Button
                                  Expanded(
                                    child: SizedBox(
                                      height: 56,
                                      child: ElevatedButton(
                                        onPressed: _nextPage,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          foregroundColor: Colors.black,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                                          elevation: 0,
                                        ),
                                        child: const Text('NEXT', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 1.0)),
                                      ),
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
    _nameController.dispose();
    super.dispose();
  }
}