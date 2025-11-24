// // onboarding_slide4.dart
// import 'package:flutter/material.dart';
// import '../../config/constants.dart';
// import '../../utils/custom_icons.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class OnboardingSlide4 extends StatefulWidget {
//   const OnboardingSlide4({super.key});

//   @override
//   State<OnboardingSlide4> createState() => _OnboardingSlide4State();
// }

// class _OnboardingSlide4State extends State<OnboardingSlide4> with SingleTickerProviderStateMixin {
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
//         curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
//       ),
//     );

//     _doodle1Animation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
//       ),
//     );

//     _doodle2Animation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
//       ),
//     );

//     _featureAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
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
//       backgroundColor: const Color(0xFFDC2626),
//       body: SafeArea(
//         child: Container(
//           padding: const EdgeInsets.all(AppConstants.spacingXL),
//           child: Stack(
//             children: [
//               // Background Doodles with opacity
//               Positioned(
//                 top: 40,
//                 right: 25,
//                 child: FadeTransition(
//                   opacity: _doodle1Animation,
//                   child: SlideTransition(
//                     position: Tween<Offset>(
//                       begin: const Offset(1, -1),
//                       end: Offset.zero,
//                     ).animate(_doodle1Animation),
//                     child: ColorFiltered(
//                       colorFilter: ColorFilter.mode(
//                         Colors.white.withValues(alpha: 0.3),
//                         BlendMode.modulate,
//                       ),
//                       child: SizedBox(
//                         width: 65,
//                         height: 65,
//                         child: SvgPicture.asset(
//                           'assets/images/undraw_chat-with-ai_ir62.svg',
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               Positioned(
//                 bottom: 80,
//                 left: 20,
//                 child: FadeTransition(
//                   opacity: _doodle2Animation,
//                   child: SlideTransition(
//                     position: Tween<Offset>(
//                       begin: const Offset(-1, 1),
//                       end: Offset.zero,
//                     ).animate(_doodle2Animation),
//                     child: ColorFiltered(
//                       colorFilter: ColorFilter.mode(
//                         Colors.white.withValues(alpha: 0.08),
//                         BlendMode.modulate,
//                       ),
//                       child: SizedBox(
//                         width: 70,
//                         height: 70,
//                         child: SvgPicture.asset(
//                           'assets/images/undraw_messages_okui.svg',
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
//                     const SizedBox(height: 20),

//                     // Main Image
//                     ScaleTransition(
//                       scale: _mainImageAnimation,
//                       child: SizedBox(
//                         width: 190,
//                         height: 140,
//                         child: SvgPicture.asset(
//                           'assets/images/undraw_voice-assistant_k27k.svg',
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: AppConstants.spacingXL),

//                     // Title
//                     const Text(
//                       'AI Assistant',
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
//                       'Your personal AI companion, always ready to help. Get instant answers, automate tasks, and boost your productivity.',
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
//                           _buildFeatureItem(CustomIcons.chat, '24/7 Available', 'Always ready to help'),
//                           const SizedBox(height: AppConstants.spacingM),
//                           _buildFeatureItem(CustomIcons.brain, 'Context Aware', 'Understands your needs'),
//                           const SizedBox(height: AppConstants.spacingM),
//                           _buildFeatureItem(CustomIcons.globe, 'Multi-language', 'Speaks your language'),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 40),
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
//     return Container(
//       padding: const EdgeInsets.all(AppConstants.spacingM),
//       decoration: BoxDecoration(
//         color: Colors.white.withValues(alpha: 0.1),
//         borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
//         border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
//       ),
//       child: Row(
//         children: [
//           getIcon(icon, size: 24, color: Colors.white),
//           const SizedBox(width: AppConstants.spacingM),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: AppConstants.fontSizeM,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 Text(
//                   subtitle,
//                   style: TextStyle(
//                     color: Colors.white.withValues(alpha: 0.7),
//                     fontSize: AppConstants.fontSizeS,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import '../../config/constants.dart';
import '../../utils/custom_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingSlide4 extends StatefulWidget {
  const OnboardingSlide4({super.key});

  @override
  State<OnboardingSlide4> createState() => _OnboardingSlide4State();
}

class _OnboardingSlide4State extends State<OnboardingSlide4> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _mainImageAnimation;
  late Animation<double> _doodle1Animation;
  late Animation<double> _doodle2Animation;
  late Animation<double> _featureAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    _mainImageAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.6, curve: Curves.elasticOut)));
    _doodle1Animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.7, curve: Curves.easeOut)));
    _doodle2Animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.3, 0.8, curve: Curves.easeOut)));
    _featureAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.5, 1.0, curve: Curves.easeOut)));
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
            right: 25,
            child: FadeTransition(
              opacity: _doodle1Animation,
              child: SlideTransition(
                position: Tween<Offset>(begin: const Offset(1, -1), end: Offset.zero).animate(_doodle1Animation),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(Colors.white.withValues(alpha: 0.3), BlendMode.modulate),
                  child: SizedBox(width: 65, height: 65, child: SvgPicture.asset('assets/images/undraw_chat-with-ai_ir62.svg', fit: BoxFit.contain)),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            left: 20,
            child: FadeTransition(
              opacity: _doodle2Animation,
              child: SlideTransition(
                position: Tween<Offset>(begin: const Offset(-1, 1), end: Offset.zero).animate(_doodle2Animation),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(Colors.white.withValues(alpha: 0.08), BlendMode.modulate),
                  child: SizedBox(width: 70, height: 70, child: SvgPicture.asset('assets/images/undraw_messages_okui.svg', fit: BoxFit.contain)),
                ),
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
                  child: SizedBox(width: 190, height: 140, child: SvgPicture.asset('assets/images/undraw_voice-assistant_k27k.svg', fit: BoxFit.contain)),
                ),
                const SizedBox(height: AppConstants.spacingXL),
                const Text('AI Assistant', style: TextStyle(fontSize: AppConstants.fontSizeXXL, fontWeight: FontWeight.w800, color: Colors.white, height: 1.2), textAlign: TextAlign.center),
                const SizedBox(height: AppConstants.spacingL),
                const Text('Your personal AI companion, always ready to help. Get instant answers, automate tasks, and boost your productivity.', style: TextStyle(fontSize: AppConstants.fontSizeL, color: Colors.white, height: 1.5), textAlign: TextAlign.center),
                const SizedBox(height: AppConstants.spacingXL),
                FadeTransition(
                  opacity: _featureAnimation,
                  child: Column(
                    children: [
                      _buildFeatureItem(CustomIcons.chat, '24/7 Available', 'Always ready to help'),
                      const SizedBox(height: AppConstants.spacingM),
                      _buildFeatureItem(CustomIcons.brain, 'Context Aware', 'Understands your needs'),
                      const SizedBox(height: AppConstants.spacingM),
                      _buildFeatureItem(CustomIcons.globe, 'Multi-language', 'Speaks your language'),
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