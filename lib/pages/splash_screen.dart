// // // import 'package:flutter/material.dart';
// // // import '../config/app_colors.dart';
// // // import '../config/constants.dart';

// // // class SplashScreen extends StatefulWidget {
// // //   const SplashScreen({super.key});

// // //   @override
// // //   State<SplashScreen> createState() => _SplashScreenState();
// // // }

// // // class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
// // //   late AnimationController _controller;
// // //   late Animation<double> _scaleAnimation;
// // //   late Animation<double> _fadeAnimation;

// // //   @override
// // // void initState() {
// // //   super.initState();

// // //   _controller = AnimationController(
// // //     duration: const Duration(milliseconds: 1500),
// // //     vsync: this,
// // //   );

// // //   _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
// // //     CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
// // //   );

// // //   _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
// // //     CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
// // //   );

// // //   _controller.forward();

// // //   // Capture navigator BEFORE the async delay
// // //   final navigator = Navigator.of(context);

// // //   Future.delayed(const Duration(seconds: 3), () {
// // //     if (!mounted) return; // ensure widget is still alive
// // //     navigator.pushReplacementNamed('/onboarding');
// // //   });
// // // }

// // //   @override
// // //   void dispose() {
// // //     _controller.dispose();
// // //     super.dispose();
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: AppColors.backgroundDark,
// // //       body: Center(
// // //         child: AnimatedBuilder(
// // //           animation: _controller,
// // //           builder: (context, child) {
// // //             return Opacity(
// // //               opacity: _fadeAnimation.value,
// // //               child: Transform.scale(
// // //                 scale: _scaleAnimation.value,
// // //                 child: Column(
// // //                   mainAxisAlignment: MainAxisAlignment.center,
// // //                   children: [
// // //                     // Logo with glow effect
// // //                     Container(
// // //                       width: 120,
// // //                       height: 120,
// // //                       decoration: BoxDecoration(
// // //                         shape: BoxShape.circle,
// // //                         boxShadow: [
// // //                           BoxShadow(
// // //                             color: AppColors.neonCyan.withValues(alpha:0.5),
// // //                             blurRadius: 20,
// // //                             spreadRadius: 5,
// // //                           ),
// // //                         ],
// // //                       ),
// // //                       child: ClipOval(
// // //                         child: Image.asset(
// // //                           'assets/images/logo.jpg',
// // //                           width: 120,
// // //                           height: 120,
// // //                           fit: BoxFit.cover,
// // //                           errorBuilder: (context, error, stackTrace) {
// // //                             return Container(
// // //                               width: 120,
// // //                               height: 120,
// // //                               decoration: const BoxDecoration(
// // //                                 gradient: AppColors.primaryGradient,
// // //                                 shape: BoxShape.circle,
// // //                               ),
// // //                               child: const Icon(
// // //                                 Icons.auto_awesome,
// // //                                 color: AppColors.backgroundDark,
// // //                                 size: 50,
// // //                               ),
// // //                             );
// // //                           },
// // //                         ),
// // //                       ),
// // //                     ),
// // //                     const SizedBox(height: AppConstants.spacingXL),
// // //                     const Text(
// // //                       'VETTO AI',
// // //                       style: TextStyle(
// // //                         fontSize: AppConstants.fontSizeXXL,
// // //                         fontWeight: FontWeight.w800,
// // //                         color: AppColors.neonCyan,
// // //                         letterSpacing: 2,
// // //                       ),
// // //                     ),
// // //                     const SizedBox(height: AppConstants.spacingM),
// // //                     const Text(
// // //                       'Offline-First AI Ecosystem',
// // //                       style: TextStyle(
// // //                         fontSize: AppConstants.fontSizeM,
// // //                         color: AppColors.textSecondary,
// // //                         fontWeight: FontWeight.w300,
// // //                       ),
// // //                     ),
// // //                     const SizedBox(height: AppConstants.spacingXL),
// // //                     const SizedBox(
// // //                       width: 40,
// // //                       height: 40,
// // //                       child: CircularProgressIndicator(
// // //                         strokeWidth: 2,
// // //                         valueColor: AlwaysStoppedAnimation(AppColors.neonCyan),
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             );
// // //           },
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }



// // import 'package:flutter/material.dart';
// // import '../config/app_colors.dart';
// // import '../config/constants.dart';
// // // import 'package:audioplayers/audioplayers.dart'; // 1. Uncomment to use sound

// // class SplashScreen extends StatefulWidget {
// //   const SplashScreen({super.key});

// //   @override
// //   State<SplashScreen> createState() => _SplashScreenState();
// // }

// // class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
// //   late AnimationController _controller;
// //   late Animation<double> _scaleAnimation;
// //   late Animation<double> _fadeAnimation;
// //   late Animation<double> _tiltAnimation;

// //   @override
// //   void initState() {
// //     super.initState();

// //     _controller = AnimationController(
// //       duration: const Duration(milliseconds: 2500), // Increased duration for the sequence
// //       vsync: this,
// //     );

// //     // 1. Fade In (Starts immediately)
// //     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
// //       CurvedAnimation(
// //         parent: _controller,
// //         curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
// //       ),
// //     );

// //     // 2. Tilt (Starts slightly tilted, straightens up)
// //     // -0.05 turns is about -18 degrees. Rotates to 0 (straight).
// //     _tiltAnimation = Tween<double>(begin: -0.05, end: 0.0).animate(
// //       CurvedAnimation(
// //         parent: _controller,
// //         curve: const Interval(0.2, 0.7, curve: Curves.elasticOut),
// //       ),
// //     );

// //     // 3. Scale (Expands/Pops at the end)
// //     _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
// //       CurvedAnimation(
// //         parent: _controller,
// //         curve: const Interval(0.4, 1.0, curve: Curves.elasticOut),
// //       ),
// //     );

// //     _controller.forward();

// //     // _playSound(); // 2. Call sound function here

// //     // Capture navigator to avoid context issues in async
// //     final navigator = Navigator.of(context);

// //     Future.delayed(const Duration(seconds: 4), () {
// //       if (!mounted) return;
// //       navigator.pushReplacementNamed('/onboarding');
// //     });
// //   }

// //   // 3. Sound Implementation (Commented Out)
// //   /*
// //   Future<void> _playSound() async {
// //     try {
// //       final player = AudioPlayer();
// //       // Ensure you have added the file to assets/sounds/startup.mp3
// //       await player.play(AssetSource('sounds/startup.mp3'));
// //     } catch (e) {
// //       debugPrint('Error playing sound: $e');
// //     }
// //   }
// //   */

// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       // Using the Vetto Gradient from the image analysis
// //       body: Container(
// //         width: double.infinity,
// //         height: double.infinity,
// //         decoration: const BoxDecoration(
// //           gradient: AppColors.vettoBackgroundGradient, 
// //         ),
// //         child: Center(
// //           child: AnimatedBuilder(
// //             animation: _controller,
// //             builder: (context, child) {
// //               return FadeTransition(
// //                 opacity: _fadeAnimation,
// //                 child: RotationTransition(
// //                   turns: _tiltAnimation,
// //                   child: ScaleTransition(
// //                     scale: _scaleAnimation,
// //                     child: Column(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: [
// //                         // Logo Container
// //                         Container(
// //                           width: 140,
// //                           height: 140,
// //                           decoration: BoxDecoration(
// //                             shape: BoxShape.circle,
// //                             boxShadow: [
// //                               // Deep, subtle shadow instead of neon glow for "Clean" look
// //                               BoxShadow(
// //                                 color: Colors.black.withValues(alpha: 0.4),
// //                                 blurRadius: 30,
// //                                 offset: const Offset(0, 10),
// //                                 spreadRadius: 0,
// //                               ),
// //                             ],
// //                           ),
// //                           child: ClipOval(
// //                             // Note: Using 'jpg' to match your file list, even though prompt said 'png'
// //                             child: Image.asset(
// //                               'assets/images/logo.png', 
// //                               width: 140,
// //                               height: 140,
// //                               fit: BoxFit.cover,
// //                               errorBuilder: (context, error, stackTrace) {
// //                                 return Container(
// //                                   color: Colors.white,
// //                                   child: const Icon(Icons.broken_image, color: Colors.grey),
// //                                 );
// //                               },
// //                             ),
// //                           ),
// //                         ),
                        
// //                         const SizedBox(height: AppConstants.spacingXL),
                        
// //                         // Brand Text
// //                         const Text(
// //                           'VETTO',
// //                           style: TextStyle(
// //                             fontSize: 40,
// //                             fontWeight: FontWeight.w900,
// //                             color: Colors.white,
// //                             letterSpacing: 3,
// //                             height: 1.0,
// //                           ),
// //                         ),
// //                         Text(
// //                           'AI ECOSYSTEM',
// //                           style: TextStyle(
// //                             fontSize: 12,
// //                             fontWeight: FontWeight.w600,
// //                             color: Colors.white.withValues(alpha: 0.6),
// //                             letterSpacing: 6,
// //                           ),
// //                         ),
                        
// //                         const SizedBox(height: 60),
                        
// //                         // Loader
// //                         const SizedBox(
// //                           width: 24,
// //                           height: 24,
// //                           child: CircularProgressIndicator(
// //                             strokeWidth: 2.5,
// //                             valueColor: AlwaysStoppedAnimation(Colors.white),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               );
// //             },
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }



// import 'package:flutter/material.dart';
// import '../config/app_colors.dart';
// // import '../config/constants.dart'; // Not used anymore in this version
// // import 'package:audioplayers/audioplayers.dart'; // 1. Uncomment to use sound

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _tiltAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 2500), // Increased duration for the sequence
//       vsync: this,
//     );

//     // 1. Fade In (Starts immediately)
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
//       ),
//     );

//     // 2. Tilt (Starts slightly tilted, straightens up)
//     // -0.05 turns is about -18 degrees. Rotates to 0 (straight).
//     _tiltAnimation = Tween<double>(begin: -0.05, end: 0.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.2, 0.7, curve: Curves.elasticOut),
//       ),
//     );

//     // 3. Scale (Expands/Pops at the end)
//     _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.4, 1.0, curve: Curves.elasticOut),
//       ),
//     );

//     _controller.forward();

//     // _playSound(); // 2. Call sound function here

//     // Capture navigator to avoid context issues in async
//     final navigator = Navigator.of(context);

//     Future.delayed(const Duration(seconds: 4), () {
//       if (!mounted) return;
//       navigator.pushReplacementNamed('/onboarding');
//     });
//   }

//   // 3. Sound Implementation (Commented Out)
//   /*
//   Future<void> _playSound() async {
//     try {
//       final player = AudioPlayer();
//       // Ensure you have added the file to assets/sounds/startup.mp3
//       await player.play(AssetSource('sounds/startup.mp3'));
//     } catch (e) {
//       debugPrint('Error playing sound: $e');
//     }
//   }
//   */

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // Using the Vetto Gradient from the image analysis
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: AppColors.vettoBackgroundGradient,
//         ),
//         child: Center(
//           child: AnimatedBuilder(
//             animation: _controller,
//             builder: (context, child) {
//               return FadeTransition(
//                 opacity: _fadeAnimation,
//                 child: RotationTransition(
//                   turns: _tiltAnimation,
//                   child: ScaleTransition(
//                     scale: _scaleAnimation,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // Logo Container
//                         Container(
//                           width: 140,
//                           height: 140,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             boxShadow: [
//                               // Deep, subtle shadow instead of neon glow for "Clean" look
//                               BoxShadow(
//                                 color: Colors.black.withValues(alpha: 0.4),
//                                 blurRadius: 30,
//                                 offset: const Offset(0, 10),
//                                 spreadRadius: 0,
//                               ),
//                             ],
//                           ),
//                           child: ClipOval(
//                             // Note: Using 'jpg' to match your file list, even though prompt said 'png'
//                             child: Image.asset(
//                               'assets/images/logo.png',
//                               width: 140,
//                               height: 140,
//                               fit: BoxFit.cover,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return Container(
//                                   color: Colors.white,
//                                   child: const Icon(Icons.broken_image, color: Colors.grey),
//                                 );
//                               },
//                             ),
//                           ),
//                         ),

//                         // --- TEXT REMOVED HERE ---

//                         const SizedBox(height: 60),

//                         // Loader
//                         const SizedBox(
//                           width: 24,
//                           height: 24,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2.5,
//                             valueColor: AlwaysStoppedAnimation(Colors.white),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _tiltAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    // 1. Fade In
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    // 2. Tilt
    _tiltAnimation = Tween<double>(begin: -0.05, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.7, curve: Curves.elasticOut),
      ),
    );

    // 3. Scale
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.elasticOut),
      ),
    );

    _controller.forward();

    // Navigation logic
    final navigator = Navigator.of(context);
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      navigator.pushReplacementNamed('/onboarding');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, 
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

          // --- 2. SPOTLIGHT (Top Left Sheen) ---
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
                    Colors.white.withValues(alpha: 0.05), // Subtle light
                    Colors.transparent,
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
          ),

          // --- 3. BACKGROUND TEXTURE (Swiss Typography) ---
          Positioned(
            bottom: -60,
            right: -20,
            child: Text(
              "VETTO",
              style: TextStyle(
                fontSize: 160,
                fontWeight: FontWeight.w900,
                color: Colors.white.withValues(alpha: 0.03), // 3% opacity for texture
                letterSpacing: -8.0,
                height: 1.0,
              ),
            ),
          ),

          // --- 4. FOREGROUND CONTENT ---
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: RotationTransition(
                    turns: _tiltAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // LOGO ON ITS OWN
                          Image.asset(
                            'assets/images/logo.png',
                            width: 180, // Increased slightly since padding is gone
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.broken_image, color: Colors.grey, size: 100);
                            },
                          ),

                          const SizedBox(height: 30),

                          // SUBTEXT
                          const Text(
                            "INTELLIGENCE REFINED",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFB5A642), // Olive Gold
                              letterSpacing: 3.0,
                            ),
                          ),

                          const SizedBox(height: 80),

                          // LOADER - Minimal
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(Color(0xFF6A7B66)), // Sage Olive
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}