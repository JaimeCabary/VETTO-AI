// // onboarding_slide3.dart
// import 'package:flutter/material.dart';
// // import '../../config/app_colors.dart';
// import '../../config/constants.dart';
// import '../../utils/custom_icons.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class OnboardingSlide3 extends StatefulWidget {
//   const OnboardingSlide3({super.key});

//   @override
//   State<OnboardingSlide3> createState() => _OnboardingSlide3State();
// }

// class _OnboardingSlide3State extends State<OnboardingSlide3> with TickerProviderStateMixin {
//   late AnimationController _floatingController; // For main image floating
//   late AnimationController _fadeController; // For features fade-in
//   late AnimationController _doodleController; // For doodle slide-in

//   late Animation<double> _floatingAnimation;
//   late Animation<double> _featureFadeAnimation;
//   late Animation<double> _doodle1FadeAnimation;
//   late Animation<double> _doodle2FadeAnimation;
//   late Animation<Offset> _doodle1SlideAnimation;
//   late Animation<Offset> _doodle2SlideAnimation;

//   @override
//   void initState() {
//     super.initState();

//     // Main image floating (continuous)
//     _floatingController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );
//     _floatingAnimation =
//         Tween<double>(begin: -10.0, end: 10.0).animate(CurvedAnimation(
//       parent: _floatingController,
//       curve: Curves.easeInOut,
//     ));
//     _floatingController.repeat(reverse: true);

//     // Features fade-in once
//     _fadeController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );
//     _featureFadeAnimation = CurvedAnimation(
//       parent: _fadeController,
//       curve: Curves.easeIn,
//     );
//     _fadeController.forward();

//     // Doodles slide-in once
//     _doodleController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1200),
//     );
//     _doodle1FadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//         CurvedAnimation(parent: _doodleController, curve: const Interval(0.0, 0.6, curve: Curves.easeOut)));
//     _doodle2FadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//         CurvedAnimation(parent: _doodleController, curve: const Interval(0.3, 1.0, curve: Curves.easeOut)));

//     _doodle1SlideAnimation = Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
//         .animate(CurvedAnimation(parent: _doodleController, curve: Curves.easeOut));
//     _doodle2SlideAnimation = Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
//         .animate(CurvedAnimation(parent: _doodleController, curve: Curves.easeOut));

//     _doodleController.forward();
//   }

//   @override
//   void dispose() {
//     _floatingController.dispose();
//     _fadeController.dispose();
//     _doodleController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF7C3AED),
//       body: SafeArea(
//         child: Container(
//           padding: const EdgeInsets.all(AppConstants.spacingXL),
//           child: Stack(
//             children: [
//               // Background Doodles with opacity
//               Positioned(
//                 top: 60,
//                 left: 25,
//                 child: FadeTransition(
//                   opacity: _doodle1FadeAnimation,
//                   child: SlideTransition(
//                     position: _doodle1SlideAnimation,
//                     child: ColorFiltered(
//                       colorFilter: ColorFilter.mode(
//                         Colors.white.withValues(alpha:0.4), // 40% opacity
//                         BlendMode.modulate,
//                       ),
//                       child: SizedBox(
//                         width: 55,
//                         height: 55,
//                         child: SvgPicture.asset(
//                           'assets/images/undraw_fill-the-blank_n29z.svg',
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               Positioned(
//                 bottom: 120,
//                 right: 30,
//                 child: FadeTransition(
//                   opacity: _doodle2FadeAnimation,
//                   child: SlideTransition(
//                     position: _doodle2SlideAnimation,
//                     child: ColorFiltered(
//                       colorFilter: ColorFilter.mode(
//                         Colors.white.withValues(alpha:0.4), // 40% opacity
//                         BlendMode.modulate,
//                       ),
//                       child: SizedBox(
//                         width: 50,
//                         height: 50,
//                         child: SvgPicture.asset(
//                           'assets/images/undraw_typing_gcve.svg',
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const SizedBox(height: 20), // Top spacing

//                     // Main Image with Floating Animation
//                     AnimatedBuilder(
//                       animation: _floatingAnimation,
//                       builder: (context, child) {
//                         return Transform.translate(
//                           offset: Offset(0, _floatingAnimation.value),
//                           child: child,
//                         );
//                       },
//                       child: SizedBox(
//                         width: 200,
//                         height: 150,
//                         child: SvgPicture.asset(
//                           'assets/images/undraw_online-resume_z4sp.svg',
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: AppConstants.spacingXL),

//                     // Title
//                     const Text(
//                       'Instant Site Builder',
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
//                       'Create stunning websites with our cyberpunk templates. No coding required - just drag, drop, and deploy instantly.',
//                       style: TextStyle(
//                         fontSize: AppConstants.fontSizeL,
//                         color: Colors.white,
//                         height: 1.5,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),

//                     const SizedBox(height: AppConstants.spacingXL),

//                     // Features fade-in
//                     FadeTransition(
//                       opacity: _featureFadeAnimation,
//                       child: Column(
//                         children: [
//                           _buildFeatureItem(
//                               CustomIcons.template, '50+ Templates', 'Cyberpunk designs'),
//                           const SizedBox(height: AppConstants.spacingM),
//                           _buildFeatureItem(
//                               CustomIcons.rocket, 'No Coding Required', 'Visual builder'),
//                           const SizedBox(height: AppConstants.spacingM),
//                           _buildFeatureItem(
//                               CustomIcons.globe, 'Instant Deployment', 'Go live in minutes'),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 40), // Bottom spacing
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
//         color: Colors.white.withValues(alpha:0.1),
//         borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
//         border: Border.all(color: Colors.white.withValues(alpha:0.3)),
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
//                     color: Colors.white.withValues(alpha:0.7),
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

class OnboardingSlide3 extends StatefulWidget {
  const OnboardingSlide3({super.key});

  @override
  State<OnboardingSlide3> createState() => _OnboardingSlide3State();
}

class _OnboardingSlide3State extends State<OnboardingSlide3> with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late AnimationController _fadeController;
  late AnimationController _doodleController;
  late Animation<double> _floatingAnimation;
  late Animation<double> _featureFadeAnimation;
  late Animation<double> _doodle1FadeAnimation;
  late Animation<double> _doodle2FadeAnimation;
  late Animation<Offset> _doodle1SlideAnimation;
  late Animation<Offset> _doodle2SlideAnimation;

  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _floatingAnimation = Tween<double>(begin: -10.0, end: 10.0).animate(CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut));
    _floatingController.repeat(reverse: true);

    _fadeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _featureFadeAnimation = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
    _fadeController.forward();

    _doodleController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _doodle1FadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _doodleController, curve: const Interval(0.0, 0.6, curve: Curves.easeOut)));
    _doodle2FadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _doodleController, curve: const Interval(0.3, 1.0, curve: Curves.easeOut)));
    _doodle1SlideAnimation = Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(CurvedAnimation(parent: _doodleController, curve: Curves.easeOut));
    _doodle2SlideAnimation = Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(CurvedAnimation(parent: _doodleController, curve: Curves.easeOut));
    _doodleController.forward();
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _fadeController.dispose();
    _doodleController.dispose();
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
            top: 60,
            left: 25,
            child: FadeTransition(
              opacity: _doodle1FadeAnimation,
              child: SlideTransition(
                position: _doodle1SlideAnimation,
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(Colors.white.withValues(alpha: 0.4), BlendMode.modulate),
                  child: SizedBox(width: 55, height: 55, child: SvgPicture.asset('assets/images/undraw_fill-the-blank_n29z.svg', fit: BoxFit.contain)),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 120,
            right: 30,
            child: FadeTransition(
              opacity: _doodle2FadeAnimation,
              child: SlideTransition(
                position: _doodle2SlideAnimation,
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(Colors.white.withValues(alpha: 0.4), BlendMode.modulate),
                  child: SizedBox(width: 50, height: 50, child: SvgPicture.asset('assets/images/undraw_typing_gcve.svg', fit: BoxFit.contain)),
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
                AnimatedBuilder(
                  animation: _floatingAnimation,
                  builder: (context, child) {
                    return Transform.translate(offset: Offset(0, _floatingAnimation.value), child: child);
                  },
                  child: SizedBox(width: 200, height: 150, child: SvgPicture.asset('assets/images/undraw_online-resume_z4sp.svg', fit: BoxFit.contain)),
                ),
                const SizedBox(height: AppConstants.spacingXL),
                const Text('Instant Site Builder', style: TextStyle(fontSize: AppConstants.fontSizeXXL, fontWeight: FontWeight.w800, color: Colors.white, height: 1.2), textAlign: TextAlign.center),
                const SizedBox(height: AppConstants.spacingL),
                const Text('Create stunning websites with our cyberpunk templates. No coding required - just drag, drop, and deploy instantly.', style: TextStyle(fontSize: AppConstants.fontSizeL, color: Colors.white, height: 1.5), textAlign: TextAlign.center),
                const SizedBox(height: AppConstants.spacingXL),
                FadeTransition(
                  opacity: _featureFadeAnimation,
                  child: Column(
                    children: [
                      _buildFeatureItem(CustomIcons.template, '50+ Templates', 'Cyberpunk designs'),
                      const SizedBox(height: AppConstants.spacingM),
                      _buildFeatureItem(CustomIcons.rocket, 'No Coding Required', 'Visual builder'),
                      const SizedBox(height: AppConstants.spacingM),
                      _buildFeatureItem(CustomIcons.globe, 'Instant Deployment', 'Go live in minutes'),
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