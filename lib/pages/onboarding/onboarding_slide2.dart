// // onboarding_slide2.dart
// import 'package:flutter/material.dart';
// // import '../../config/app_colors.dart';
// import '../../config/constants.dart';
// import '../../utils/custom_icons.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class OnboardingSlide2 extends StatefulWidget {
//   const OnboardingSlide2({super.key});

//   @override
//   State<OnboardingSlide2> createState() => _OnboardingSlide2State();
// }

// class _OnboardingSlide2State extends State<OnboardingSlide2> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _mainImageAnimation;
//   late Animation<double> _doodle1Animation;
//   late Animation<double> _doodle2Animation;
//   late Animation<double> _featureAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 2000),
//       vsync: this,
//     );

//     _mainImageAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
//       ),
//     );

//     _doodle1Animation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.3, 0.7, curve: Curves.easeOut),
//       ),
//     );

//     _doodle2Animation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
//       ),
//     );

//     _featureAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
//       ),
//     );

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF065F46),
//       body: SafeArea(
//         child: Container(
//           padding: const EdgeInsets.all(AppConstants.spacingXL),
//           child: Stack(
//             children: [
//               // Background Doodles with opacity
//               Positioned(
//                 top: 40,
//                 right: 30,
//                 child: FadeTransition(
//                   opacity: _doodle1Animation,
//                   child: SlideTransition(
//                     position: Tween<Offset>(
//                       begin: const Offset(1, -1),
//                       end: Offset.zero,
//                     ).animate(_doodle1Animation),
//                     child: Opacity(
//                       opacity: 0.4, // Added opacity to make doodle more subtle
//                       child: SizedBox(
//                         width: 70,
//                         height: 70,
//                         child: SvgPicture.asset(
//                           'assets/images/undraw_work-friends_g4mn.svg',
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               Positioned(
//                 bottom: 80,
//                 left: 25,
//                 child: FadeTransition(
//                   opacity: _doodle2Animation,
//                   child: SlideTransition(
//                     position: Tween<Offset>(
//                       begin: const Offset(-1, 1),
//                       end: Offset.zero,
//                     ).animate(_doodle2Animation),
//                     child: Opacity(
//                       opacity: 0.4, // Added opacity to make doodle more subtle
//                       child: SizedBox(
//                         width: 65,
//                         height: 65,
//                         child: SvgPicture.asset(
//                           'assets/images/undraw_work-chat_hc3y.svg',
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               // SingleChildScrollView to prevent overflow
//               SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const SizedBox(height: 20), // Top spacing

//                     // Main Image
//                     ScaleTransition(
//                       scale: _mainImageAnimation,
//                       child: SizedBox(
//                         width: 220,
//                         height: 160,
//                         child: SvgPicture.asset(
//                           'assets/images/undraw_document-analysis_3c0y.svg',
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: AppConstants.spacingXL),

//                     // Title
//                     const Text(
//                       'Smart Workflows',
//                       style: TextStyle(
//                         fontSize: AppConstants.fontSizeXXL,
//                         fontWeight: FontWeight.w800,
//                         color: Colors.white,
//                         height: 1.2,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),

//                     const SizedBox(height: AppConstants.spacingL),

//                     // Description
//                     const Text(
//                       'Automate tasks with AI-powered workflows that work anywhere, even offline. Drag and drop to create complex automations.',
//                       style: TextStyle(
//                         fontSize: AppConstants.fontSizeL,
//                         color: Colors.white,
//                         height: 1.5,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),

//                     const SizedBox(height: AppConstants.spacingXL),

//                     // Features
//                     FadeTransition(
//                       opacity: _featureAnimation,
//                       child: Column(
//                         children: [
//                           _buildFeatureItem(CustomIcons.workflow, 'Drag & Drop Builder', 'Visual workflow creation'),
//                           const SizedBox(height: AppConstants.spacingM),
//                           _buildFeatureItem(CustomIcons.zap, 'AI Automation', 'Smart task execution'),
//                           const SizedBox(height: AppConstants.spacingM),
//                           _buildFeatureItem(CustomIcons.performance, 'Real-time Monitoring', 'Track workflow progress'),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 40), // Bottom spacing for scroll
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildFeatureItem(String icon, String title, String subtitle) {
//   return Container(
//     padding: const EdgeInsets.all(AppConstants.spacingM),
//     decoration: BoxDecoration(
//       color: Colors.white.withValues(alpha: 0.1),
//       borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
//       border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
//     ),
//     child: Row(
//       children: [
//         // Use getIcon instead of Text
//         getIcon(icon, size: 24, color: Colors.white),
//         const SizedBox(width: AppConstants.spacingM),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: AppConstants.fontSizeM,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               Text(
//                 subtitle,
//                 style: TextStyle(
//                   color: Colors.white.withValues(alpha: 0.7),
//                   fontSize: AppConstants.fontSizeS,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }
// }


import 'package:flutter/material.dart';
import '../../config/constants.dart';
import '../../utils/custom_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingSlide2 extends StatefulWidget {
  const OnboardingSlide2({super.key});

  @override
  State<OnboardingSlide2> createState() => _OnboardingSlide2State();
}

class _OnboardingSlide2State extends State<OnboardingSlide2> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _mainImageAnimation;
  late Animation<double> _doodle1Animation;
  late Animation<double> _doodle2Animation;
  late Animation<double> _featureAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    _mainImageAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.5, curve: Curves.elasticOut)));
    _doodle1Animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.3, 0.7, curve: Curves.easeOut)));
    _doodle2Animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.4, 0.8, curve: Curves.easeOut)));
    _featureAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.6, 1.0, curve: Curves.easeOut)));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent, // Allows parent gradient to show
      padding: const EdgeInsets.all(AppConstants.spacingXL),
      child: Stack(
        children: [
          Positioned(
            top: 40,
            right: 30,
            child: FadeTransition(
              opacity: _doodle1Animation,
              child: SlideTransition(
                position: Tween<Offset>(begin: const Offset(1, -1), end: Offset.zero).animate(_doodle1Animation),
                child: Opacity(opacity: 0.4, child: SizedBox(width: 70, height: 70, child: SvgPicture.asset('assets/images/undraw_work-friends_g4mn.svg', fit: BoxFit.contain))),
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            left: 25,
            child: FadeTransition(
              opacity: _doodle2Animation,
              child: SlideTransition(
                position: Tween<Offset>(begin: const Offset(-1, 1), end: Offset.zero).animate(_doodle2Animation),
                child: Opacity(opacity: 0.4, child: SizedBox(width: 65, height: 65, child: SvgPicture.asset('assets/images/undraw_work-chat_hc3y.svg', fit: BoxFit.contain))),
              ),
            ),
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                ScaleTransition(
                  scale: _mainImageAnimation,
                  child: SizedBox(width: 220, height: 160, child: SvgPicture.asset('assets/images/undraw_document-analysis_3c0y.svg', fit: BoxFit.contain)),
                ),
                const SizedBox(height: AppConstants.spacingXL),
                const Text('Smart Workflows', style: TextStyle(fontSize: AppConstants.fontSizeXXL, fontWeight: FontWeight.w800, color: Colors.white, height: 1.2), textAlign: TextAlign.center),
                const SizedBox(height: AppConstants.spacingL),
                const Text('Automate tasks with AI-powered workflows that work anywhere, even offline. Drag and drop to create complex automations.', style: TextStyle(fontSize: AppConstants.fontSizeL, color: Colors.white, height: 1.5), textAlign: TextAlign.center),
                const SizedBox(height: AppConstants.spacingXL),
                FadeTransition(
                  opacity: _featureAnimation,
                  child: Column(
                    children: [
                      _buildFeatureItem(CustomIcons.workflow, 'Drag & Drop Builder', 'Visual workflow creation'),
                      const SizedBox(height: AppConstants.spacingM),
                      _buildFeatureItem(CustomIcons.zap, 'AI Automation', 'Smart task execution'),
                      const SizedBox(height: AppConstants.spacingM),
                      _buildFeatureItem(CustomIcons.performance, 'Real-time Monitoring', 'Track workflow progress'),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingM),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppConstants.borderRadiusL), border: Border.all(color: Colors.white.withValues(alpha: 0.3))),
      child: Row(
        children: [
          getIcon(icon, size: 24, color: Colors.white),
          const SizedBox(width: AppConstants.spacingM),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(color: Colors.white, fontSize: AppConstants.fontSizeM, fontWeight: FontWeight.w600)),
            Text(subtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: AppConstants.fontSizeS)),
          ])),
        ],
      ),
    );
  }
}