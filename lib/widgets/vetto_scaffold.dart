import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'dart:math' as math;

class VettoScaffold extends StatefulWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;
  
  // FIX 1: Removed space between useSafe and Area
  final bool useSafeArea; 

  const VettoScaffold({
    super.key,
    required this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.appBar,
    // FIX 2: Corrected parameter name
    this.useSafeArea = true, 
  });

  @override
  State<VettoScaffold> createState() => _VettoScaffoldState();
}

class _VettoScaffoldState extends State<VettoScaffold> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Slow rotation for background doodles
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: widget.appBar,
      bottomNavigationBar: widget.bottomNavigationBar,
      floatingActionButton: widget.floatingActionButton,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          // DARKER VETTO GRADIENT
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2F3A2F), // Dark Olive
              Color(0xFF1A211A), // Almost Black Green
            ],
          ),
        ),
        child: Stack(
          children: [
            // --- 1. Top Right Doodle (SVG) ---
            Positioned(
              top: -50,
              right: -50,
              child: Opacity(
                opacity: 0.05, // Very subtle/opaque
                child: RotationTransition(
                  turns: _controller,
                  child: SvgPicture.asset(
                    'assets/images/undraw_connected-world_anke.svg',
                    width: 300,
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ),
              ),
            ),

            // --- 2. Bottom Left Doodle (SVG) ---
            Positioned(
              bottom: 100,
              left: -30,
              child: Opacity(
                opacity: 0.05,
                child: Transform.rotate(
                  angle: -0.2,
                  child: SvgPicture.asset(
                    'assets/images/undraw_chat_qmyo.svg', // Using one of your chat SVGs
                    width: 250,
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ),
              ),
            ),

            // --- 3. Mid-Right 3D Element (Static) ---
            Positioned(
              top: 300,
              right: -20,
              child: Opacity(
                opacity: 0.03,
                child: Image.asset(
                  'assets/images/3dgraphics/image-keoWINYYBgXx7vwibZe2cbllJ4SaQA.png', // 3D Mascot
                  width: 150,
                ),
              ),
            ),
            
            // --- Main Content ---
            // FIX 3: Corrected variable usage
            widget.useSafeArea ? SafeArea(child: widget.body) : widget.body,
          ],
        ),
      ),
    );
  }
}