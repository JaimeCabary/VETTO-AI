// // // // onboarding_slide1.dart
// // // import 'package:flutter/material.dart';
// // // // import '../../config/app_colors.dart';
// // // import '../../config/constants.dart';
// // // import '../../utils/custom_icons.dart';
// // // import 'package:flutter_svg/flutter_svg.dart';

// // // class OnboardingSlide1 extends StatefulWidget {
// // //   const OnboardingSlide1({super.key});

// // //   @override
// // //   State<OnboardingSlide1> createState() => _OnboardingSlide1State();
// // // }

// // // class _OnboardingSlide1State extends State<OnboardingSlide1> with SingleTickerProviderStateMixin {
// // //   late AnimationController _controller;
// // //   late Animation<double> _titleAnimation;
// // //   late Animation<double> _descriptionAnimation;
// // //   late Animation<double> _mainImageAnimation;
// // //   late Animation<double> _doodle1Animation;
// // //   late Animation<double> _doodle2Animation;
// // //   late Animation<double> _featureAnimation;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _controller = AnimationController(
// // //       duration: const Duration(milliseconds: 2000),
// // //       vsync: this,
// // //     );

// // //     _titleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
// // //       CurvedAnimation(
// // //         parent: _controller,
// // //         curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
// // //       ),
// // //     );

// // //     _descriptionAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
// // //       CurvedAnimation(
// // //         parent: _controller,
// // //         curve: const Interval(0.2, 0.5, curve: Curves.easeOut),
// // //       ),
// // //     );

// // //     _mainImageAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
// // //       CurvedAnimation(
// // //         parent: _controller,
// // //         curve: const Interval(0.3, 0.7, curve: Curves.elasticOut),
// // //       ),
// // //     );

// // //     _doodle1Animation = Tween<double>(begin: 0.0, end: 1.0).animate(
// // //       CurvedAnimation(
// // //         parent: _controller,
// // //         curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
// // //       ),
// // //     );

// // //     _doodle2Animation = Tween<double>(begin: 0.0, end: 1.0).animate(
// // //       CurvedAnimation(
// // //         parent: _controller,
// // //         curve: const Interval(0.5, 0.9, curve: Curves.easeOut),
// // //       ),
// // //     );

// // //     _featureAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
// // //       CurvedAnimation(
// // //         parent: _controller,
// // //         curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
// // //       ),
// // //     );

// // //     _controller.forward();
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _controller.dispose();
// // //     super.dispose();
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold( // Changed to Scaffold for better structure
// // //       backgroundColor: const Color(0xFF1E3A8A),
// // //       body: SafeArea(
// // //         child: Container(
// // //           padding: const EdgeInsets.all(AppConstants.spacingXL),
// // //           child: Stack(
// // //             children: [
// // //               // Background Doodles
// // //               Positioned(
// // //                 top: 50,
// // //                 left: 20,
// // //                 child: FadeTransition(
// // //                   opacity: _doodle1Animation,
// // //                   child: SlideTransition(
// // //                     position: Tween<Offset>(
// // //                       begin: const Offset(-1, 0),
// // //                       end: Offset.zero,
// // //                     ).animate(_doodle1Animation),
// // //                     child: SizedBox(
// // //                       width: 80,
// // //                       height: 80,
// // //                       child: SvgPicture.asset(
// // //                         'assets/images/undraw_around-the-world_vgcy.svg',
// // //                         fit: BoxFit.contain,
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ),

// // //               Positioned(
// // //                 bottom: 100,
// // //                 right: 20,
// // //                 child: FadeTransition(
// // //                   opacity: _doodle2Animation,
// // //                   child: SlideTransition(
// // //                     position: Tween<Offset>(
// // //                       begin: const Offset(1, 0),
// // //                       end: Offset.zero,
// // //                     ).animate(_doodle2Animation),
// // //                     child: SizedBox(
// // //                       width: 60,
// // //                       height: 60,
// // //                       child: SvgPicture.asset(
// // //                         'assets/images/undraw_the-world-is-mine_wnib.svg',
// // //                         fit: BoxFit.contain,
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ),

// // //               // SingleChildScrollView to prevent overflow
// // //               SingleChildScrollView(
// // //                 physics: const BouncingScrollPhysics(),
// // //                 child: Column(
// // //                   mainAxisAlignment: MainAxisAlignment.center,
// // //                   children: [
// // //                     const SizedBox(height: 20), // Add some top spacing

// // //                     // Main Image
// // //                     ScaleTransition(
// // //                       scale: _mainImageAnimation,
// // //                       child: SizedBox(
// // //                         width: 200,
// // //                         height: 150,
// // //                         child: SvgPicture.asset(
// // //                           'assets/images/undraw_connected-world_anke.svg',
// // //                           fit: BoxFit.contain,
// // //                         ),
// // //                       ),
// // //                     ),

// // //                     const SizedBox(height: AppConstants.spacingXL),

// // //                     // Title
// // //                     FadeTransition(
// // //                       opacity: _titleAnimation,
// // //                       child: SlideTransition(
// // //                         position: Tween<Offset>(
// // //                           begin: const Offset(0, 0.5),
// // //                           end: Offset.zero,
// // //                         ).animate(_titleAnimation),
// // //                         child: const Text(
// // //                           'Welcome to Vetto AI',
// // //                           style: TextStyle(
// // //                             fontSize: AppConstants.fontSizeXXL,
// // //                             fontWeight: FontWeight.w800,
// // //                             color: Colors.white,
// // //                             height: 1.2,
// // //                           ),
// // //                           textAlign: TextAlign.center,
// // //                         ),
// // //                       ),
// // //                     ),

// // //                     const SizedBox(height: AppConstants.spacingL),

// // //                     // Description
// // //                     FadeTransition(
// // //                       opacity: _descriptionAnimation,
// // //                       child: SlideTransition(
// // //                         position: Tween<Offset>(
// // //                           begin: const Offset(0, 0.3),
// // //                           end: Offset.zero,
// // //                         ).animate(_descriptionAnimation),
// // //                         child: const Text(
// // //                           'Your offline-first AI ecosystem for global productivity. Built for areas with limited connectivity.',
// // //                           style: TextStyle(
// // //                             fontSize: AppConstants.fontSizeL,
// // //                             color: Colors.white,
// // //                             height: 1.5,
// // //                           ),
// // //                           textAlign: TextAlign.center,
// // //                         ),
// // //                       ),
// // //                     ),

// // //                     const SizedBox(height: AppConstants.spacingXL),

// // //                     // Features
// // //                     FadeTransition(
// // //                       opacity: _featureAnimation,
// // //                       child: Column(
// // //                         children: [
// // //                           _buildFeatureItem(CustomIcons.brain, 'Fully Offline AI', 'Works without internet'),
// // //                           const SizedBox(height: AppConstants.spacingM),
// // //                           _buildFeatureItem(CustomIcons.rocket, 'Cyberpunk Design', 'Futuristic interface'),
// // //                           const SizedBox(height: AppConstants.spacingM),
// // //                           _buildFeatureItem(CustomIcons.globe, 'Global Accessibility', 'Built for everyone'),
// // //                         ],
// // //                       ),
// // //                     ),

// // //                     const SizedBox(height: 40), // Add bottom padding for scroll
// // //                   ],
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildFeatureItem(String icon, String title, String subtitle) {
// // //   return Container(
// // //     padding: const EdgeInsets.all(AppConstants.spacingM),
// // //     decoration: BoxDecoration(
// // //       color: Colors.white.withValues(alpha: 0.1),
// // //       borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
// // //       border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
// // //     ),
// // //     child: Row(
// // //       children: [
// // //         // Use getIcon instead of Text
// // //         getIcon(icon, size: 24, color: Colors.white),
// // //         const SizedBox(width: AppConstants.spacingM),
// // //         Expanded(
// // //           child: Column(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               Text(
// // //                 title,
// // //                 style: const TextStyle(
// // //                   color: Colors.white,
// // //                   fontSize: AppConstants.fontSizeM,
// // //                   fontWeight: FontWeight.w600,
// // //                 ),
// // //               ),
// // //               Text(
// // //                 subtitle,
// // //                 style: TextStyle(
// // //                   color: Colors.white.withValues(alpha: 0.7),
// // //                   fontSize: AppConstants.fontSizeS,
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ],
// // //     ),
// // //   );
// // // }
// // // }



// // // onboarding_slide1.dart
// // import 'package:flutter/material.dart';
// // // import '../../config/app_colors.dart';
// // import '../../config/constants.dart';
// // import '../../utils/custom_icons.dart';
// // import 'package:flutter_svg/flutter_svg.dart';

// // class OnboardingSlide1 extends StatefulWidget {
// //   const OnboardingSlide1({super.key});

// //   @override
// //   State<OnboardingSlide1> createState() => _OnboardingSlide1State();
// // }

// // class _OnboardingSlide1State extends State<OnboardingSlide1> with SingleTickerProviderStateMixin {
// //   late AnimationController _controller;
// //   late Animation<double> _titleAnimation;
// //   late Animation<double> _descriptionAnimation;
// //   late Animation<double> _mainImageAnimation;
// //   late Animation<double> _doodle1Animation;
// //   late Animation<double> _doodle2Animation;
// //   late Animation<double> _featureAnimation;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _controller = AnimationController(
// //       duration: const Duration(milliseconds: 2000),
// //       vsync: this,
// //     );

// //     _titleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
// //       CurvedAnimation(
// //         parent: _controller,
// //         curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
// //       ),
// //     );

// //     _descriptionAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
// //       CurvedAnimation(
// //         parent: _controller,
// //         curve: const Interval(0.2, 0.5, curve: Curves.easeOut),
// //       ),
// //     );

// //     _mainImageAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
// //       CurvedAnimation(
// //         parent: _controller,
// //         curve: const Interval(0.3, 0.7, curve: Curves.elasticOut),
// //       ),
// //     );

// //     _doodle1Animation = Tween<double>(begin: 0.0, end: 1.0).animate(
// //       CurvedAnimation(
// //         parent: _controller,
// //         curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
// //       ),
// //     );

// //     _doodle2Animation = Tween<double>(begin: 0.0, end: 1.0).animate(
// //       CurvedAnimation(
// //         parent: _controller,
// //         curve: const Interval(0.5, 0.9, curve: Curves.easeOut),
// //       ),
// //     );

// //     _featureAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
// //       CurvedAnimation(
// //         parent: _controller,
// //         curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
// //       ),
// //     );

// //     _controller.forward();
// //   }

// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFF1E3A8A),
// //       body: SafeArea(
// //         child: Container(
// //           padding: const EdgeInsets.all(AppConstants.spacingXL),
// //           child: Stack(
// //             children: [
// //               // Background Doodles with fade effect
// //               Positioned(
// //                 top: 50,
// //                 left: 20,
// //                 child: FadeTransition(
// //                   opacity: _doodle1Animation,
// //                   child: SlideTransition(
// //                     position: Tween<Offset>(
// //                       begin: const Offset(-1, 0),
// //                       end: Offset.zero,
// //                     ).animate(_doodle1Animation),
// //                     child: ColorFiltered(
// //                       colorFilter: ColorFilter.mode(
// //                         Colors.white.withValues(alpha: 0.4), // 40% opacity - faded out
// //                         BlendMode.modulate,
// //                       ),
// //                       child: SizedBox(
// //                         width: 80,
// //                         height: 80,
// //                         child: SvgPicture.asset(
// //                           'assets/images/undraw_around-the-world_vgcy.svg',
// //                           fit: BoxFit.contain,
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ),

// //               Positioned(
// //                 bottom: 100,
// //                 right: 20,
// //                 child: FadeTransition(
// //                   opacity: _doodle2Animation,
// //                   child: SlideTransition(
// //                     position: Tween<Offset>(
// //                       begin: const Offset(1, 0),
// //                       end: Offset.zero,
// //                     ).animate(_doodle2Animation),
// //                     child: ColorFiltered(
// //                       colorFilter: ColorFilter.mode(
// //                         Colors.white.withValues(alpha: 0.4), // 40% opacity - faded out
// //                         BlendMode.modulate,
// //                       ),
// //                       child: SizedBox(
// //                         width: 60,
// //                         height: 60,
// //                         child: SvgPicture.asset(
// //                           'assets/images/undraw_the-world-is-mine_wnib.svg',
// //                           fit: BoxFit.contain,
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ),

// //               // SingleChildScrollView to prevent overflow
// //               SingleChildScrollView(
// //                 physics: const BouncingScrollPhysics(),
// //                 child: Column(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     const SizedBox(height: 20), // Add some top spacing

// //                     // Main Image
// //                     ScaleTransition(
// //                       scale: _mainImageAnimation,
// //                       child: SizedBox(
// //                         width: 200,
// //                         height: 150,
// //                         child: SvgPicture.asset(
// //                           'assets/images/undraw_connected-world_anke.svg',
// //                           fit: BoxFit.contain,
// //                         ),
// //                       ),
// //                     ),

// //                     const SizedBox(height: AppConstants.spacingXL),

// //                     // Title
// //                     FadeTransition(
// //                       opacity: _titleAnimation,
// //                       child: SlideTransition(
// //                         position: Tween<Offset>(
// //                           begin: const Offset(0, 0.5),
// //                           end: Offset.zero,
// //                         ).animate(_titleAnimation),
// //                         child: const Text(
// //                           'Welcome to Vetto AI',
// //                           style: TextStyle(
// //                             fontSize: AppConstants.fontSizeXXL,
// //                             fontWeight: FontWeight.w800,
// //                             color: Colors.white,
// //                             height: 1.2,
// //                           ),
// //                           textAlign: TextAlign.center,
// //                         ),
// //                       ),
// //                     ),

// //                     const SizedBox(height: AppConstants.spacingL),

// //                     // Description
// //                     FadeTransition(
// //                       opacity: _descriptionAnimation,
// //                       child: SlideTransition(
// //                         position: Tween<Offset>(
// //                           begin: const Offset(0, 0.3),
// //                           end: Offset.zero,
// //                         ).animate(_descriptionAnimation),
// //                         child: const Text(
// //                           'Your offline-first AI ecosystem for global productivity. Built for areas with limited connectivity.',
// //                           style: TextStyle(
// //                             fontSize: AppConstants.fontSizeL,
// //                             color: Colors.white,
// //                             height: 1.5,
// //                           ),
// //                           textAlign: TextAlign.center,
// //                         ),
// //                       ),
// //                     ),

// //                     const SizedBox(height: AppConstants.spacingXL),

// //                     // Features
// //                     FadeTransition(
// //                       opacity: _featureAnimation,
// //                       child: Column(
// //                         children: [
// //                           _buildFeatureItem(CustomIcons.brain, 'Fully Offline AI', 'Works without internet'),
// //                           const SizedBox(height: AppConstants.spacingM),
// //                           _buildFeatureItem(CustomIcons.rocket, 'Cyberpunk Design', 'Futuristic interface'),
// //                           const SizedBox(height: AppConstants.spacingM),
// //                           _buildFeatureItem(CustomIcons.globe, 'Global Accessibility', 'Built for everyone'),
// //                         ],
// //                       ),
// //                     ),

// //                     const SizedBox(height: 40), // Add bottom padding for scroll
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildFeatureItem(String icon, String title, String subtitle) {
// //     return Container(
// //       padding: const EdgeInsets.all(AppConstants.spacingM),
// //       decoration: BoxDecoration(
// //         color: Colors.white.withValues(alpha: 0.1),
// //         borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
// //         border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
// //       ),
// //       child: Row(
// //         children: [
// //           // Use getIcon instead of Text
// //           getIcon(icon, size: 24, color: Colors.white),
// //           const SizedBox(width: AppConstants.spacingM),
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   title,
// //                   style: const TextStyle(
// //                     color: Colors.white,
// //                     fontSize: AppConstants.fontSizeM,
// //                     fontWeight: FontWeight.w600,
// //                   ),
// //                 ),
// //                 Text(
// //                   subtitle,
// //                   style: TextStyle(
// //                     color: Colors.white.withValues(alpha: 0.7),
// //                     fontSize: AppConstants.fontSizeS,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }



// // onboarding_slide1.dart
// import 'package:flutter/material.dart';
// // import '../../config/app_colors.dart';
// import '../../config/constants.dart';
// import '../../utils/custom_icons.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class OnboardingSlide1 extends StatefulWidget {
//   const OnboardingSlide1({super.key});

//   @override
//   State<OnboardingSlide1> createState() => _OnboardingSlide1State();
// }

// class _OnboardingSlide1State extends State<OnboardingSlide1> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _titleAnimation;
//   late Animation<double> _descriptionAnimation;
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

//     _titleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
//       ),
//     );

//     _descriptionAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.2, 0.5, curve: Curves.easeOut),
//       ),
//     );

//     _mainImageAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.3, 0.7, curve: Curves.elasticOut),
//       ),
//     );

//     _doodle1Animation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
//       ),
//     );

//     _doodle2Animation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.5, 0.9, curve: Curves.easeOut),
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
//       backgroundColor: const Color(0xFF1E3A8A),
//       body: SafeArea(
//         child: Container(
//           padding: const EdgeInsets.all(AppConstants.spacingXL),
//           child: Stack(
//             children: [
//               // Background Doodles with fade effect
//               Positioned(
//                 top: 50,
//                 left: 20,
//                 child: FadeTransition(
//                   opacity: _doodle1Animation,
//                   child: SlideTransition(
//                     position: Tween<Offset>(
//                       begin: const Offset(-1, 0),
//                       end: Offset.zero,
//                     ).animate(_doodle1Animation),
//                     child: ColorFiltered(
//                       colorFilter: ColorFilter.mode(
//                         Colors.white.withValues(alpha: 0.4), // 40% opacity - faded out
//                         BlendMode.modulate,
//                       ),
//                       child: SizedBox(
//                         width: 80,
//                         height: 80,
//                         child: SvgPicture.asset(
//                           'assets/images/undraw_around-the-world_vgcy.svg',
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               Positioned(
//                 bottom: 100,
//                 right: 20,
//                 child: FadeTransition(
//                   opacity: _doodle2Animation,
//                   child: SlideTransition(
//                     position: Tween<Offset>(
//                       begin: const Offset(1, 0),
//                       end: Offset.zero,
//                     ).animate(_doodle2Animation),
//                     child: ColorFiltered(
//                       colorFilter: ColorFilter.mode(
//                         Colors.white.withValues(alpha: 0.4), // 40% opacity - faded out
//                         BlendMode.modulate,
//                       ),
//                       child: SizedBox(
//                         width: 60,
//                         height: 60,
//                         child: SvgPicture.asset(
//                           'assets/images/undraw_the-world-is-mine_wnib.svg',
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
//                     const SizedBox(height: 20), // Add some top spacing

//                     // Main Image
//                     ScaleTransition(
//                       scale: _mainImageAnimation,
//                       child: SizedBox(
//                         width: 200,
//                         height: 150,
//                         child: SvgPicture.asset(
//                           'assets/images/undraw_connected-world_anke.svg',
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: AppConstants.spacingXL),

//                     // Title
//                     FadeTransition(
//                       opacity: _titleAnimation,
//                       child: SlideTransition(
//                         position: Tween<Offset>(
//                           begin: const Offset(0, 0.5),
//                           end: Offset.zero,
//                         ).animate(_titleAnimation),
//                         child: const Text(
//                           'Welcome to Vetto AI',
//                           style: TextStyle(
//                             fontSize: AppConstants.fontSizeXXL,
//                             fontWeight: FontWeight.w800,
//                             color: Colors.white,
//                             height: 1.2,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: AppConstants.spacingL),

//                     // Description
//                     FadeTransition(
//                       opacity: _descriptionAnimation,
//                       child: SlideTransition(
//                         position: Tween<Offset>(
//                           begin: const Offset(0, 0.3),
//                           end: Offset.zero,
//                         ).animate(_descriptionAnimation),
//                         child: const Text(
//                           'Your offline-first AI ecosystem for global productivity. Built for areas with limited connectivity.',
//                           style: TextStyle(
//                             fontSize: AppConstants.fontSizeL,
//                             color: Colors.white,
//                             height: 1.5,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: AppConstants.spacingXL),

//                     // Features
//                     FadeTransition(
//                       opacity: _featureAnimation,
//                       child: Column(
//                         children: [
//                           _buildFeatureItem(CustomIcons.brain, 'Fully Offline AI', 'Works without internet'),
//                           const SizedBox(height: AppConstants.spacingM),
//                           _buildFeatureItem(CustomIcons.rocket, 'Cyberpunk Design', 'Futuristic interface'),
//                           const SizedBox(height: AppConstants.spacingM),
//                           _buildFeatureItem(CustomIcons.globe, 'Global Accessibility', 'Built for everyone'),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 40), // Add bottom padding for scroll
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
//           // Use getIcon instead of Text
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

class OnboardingSlide1 extends StatefulWidget {
  const OnboardingSlide1({super.key});

  @override
  State<OnboardingSlide1> createState() => _OnboardingSlide1State();
}

class _OnboardingSlide1State extends State<OnboardingSlide1> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _titleAnimation;
  late Animation<double> _descriptionAnimation;
  late Animation<double> _mainImageAnimation;
  late Animation<double> _doodle1Animation;
  late Animation<double> _doodle2Animation;
  late Animation<double> _featureAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    _titleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.3, curve: Curves.easeOut)));
    _descriptionAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.5, curve: Curves.easeOut)));
    _mainImageAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.3, 0.7, curve: Curves.elasticOut)));
    _doodle1Animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.4, 0.8, curve: Curves.easeOut)));
    _doodle2Animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.5, 0.9, curve: Curves.easeOut)));
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
    // 1. CHANGED: Container instead of Scaffold
    return Container(
      color: Colors.transparent, // 2. CRITICAL: Allows parent gradient to show
      padding: const EdgeInsets.all(AppConstants.spacingXL),
      child: Stack(
        children: [
          Positioned(
            top: 50,
            left: 20,
            child: FadeTransition(
              opacity: _doodle1Animation,
              child: SlideTransition(
                position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(_doodle1Animation),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(Colors.white.withValues(alpha: 0.4), BlendMode.modulate),
                  child: SizedBox(width: 80, height: 80, child: SvgPicture.asset('assets/images/undraw_around-the-world_vgcy.svg', fit: BoxFit.contain)),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            right: 20,
            child: FadeTransition(
              opacity: _doodle2Animation,
              child: SlideTransition(
                position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(_doodle2Animation),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(Colors.white.withValues(alpha: 0.4), BlendMode.modulate),
                  child: SizedBox(width: 60, height: 60, child: SvgPicture.asset('assets/images/undraw_the-world-is-mine_wnib.svg', fit: BoxFit.contain)),
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
                  child: SizedBox(width: 200, height: 150, child: SvgPicture.asset('assets/images/undraw_connected-world_anke.svg', fit: BoxFit.contain)),
                ),
                const SizedBox(height: AppConstants.spacingXL),
                FadeTransition(
                  opacity: _titleAnimation,
                  child: const Text('Welcome to Vetto AI', style: TextStyle(fontSize: AppConstants.fontSizeXXL, fontWeight: FontWeight.w800, color: Colors.white, height: 1.2), textAlign: TextAlign.center),
                ),
                const SizedBox(height: AppConstants.spacingL),
                FadeTransition(
                  opacity: _descriptionAnimation,
                  child: const Text('Your offline-first AI ecosystem for global productivity. Built for areas with limited connectivity.', style: TextStyle(fontSize: AppConstants.fontSizeL, color: Colors.white, height: 1.5), textAlign: TextAlign.center),
                ),
                const SizedBox(height: AppConstants.spacingXL),
                FadeTransition(
                  opacity: _featureAnimation,
                  child: Column(
                    children: [
                      _buildFeatureItem(CustomIcons.brain, 'Fully Offline AI', 'Works without internet'),
                      const SizedBox(height: AppConstants.spacingM),
                      _buildFeatureItem(CustomIcons.rocket, 'Cyberpunk Design', 'Futuristic interface'),
                      const SizedBox(height: AppConstants.spacingM),
                      _buildFeatureItem(CustomIcons.globe, 'Global Accessibility', 'Built for everyone'),
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