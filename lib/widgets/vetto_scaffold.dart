import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VettoScaffold extends StatefulWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;
  final bool useSafeArea;

  const VettoScaffold({
    super.key,
    required this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.appBar,
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
    // Keeping your original slow rotation
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
    // 1. The Deep Charcoal Base
    const Color deepCharcoal = Color(0xFF121212);

    return Scaffold(
      backgroundColor: deepCharcoal,
      extendBodyBehindAppBar: true,
      appBar: widget.appBar,
      bottomNavigationBar: widget.bottomNavigationBar,
      floatingActionButton: widget.floatingActionButton,
      body: Stack(
        children: [
          // --- LAYER 1: The "Sheen" Gradient ---
          // Creates the matte spotlight effect from top-left
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(-0.8, -0.6),
                radius: 1.5,
                colors: [
                  Color(0xFF2A2A2A), // Matte Sheen
                  deepCharcoal,            // Deep Base
                ],
                stops: [0.0, 1.0],
              ),
            ),
          ),

          // --- LAYER 2: The Giant "V" Texture ---
          // Replaces generic patterns with bold branding
          Positioned(
            right: -80,
            top: -60,
            child: IgnorePointer(
              child: Text(
                'V',
                style: TextStyle(
                  fontSize: 600, 
                  fontWeight: FontWeight.w900,
                  color: Colors.white.withValues(alpha: 0.03), // Subtle texture
                  height: 1.0,
                ),
              ),
            ),
          ),

          // --- LAYER 3: YOUR ORIGINAL DOODLES (Restored) ---
          
          // Top Right Rotating Doodle
          Positioned(
            top: 500,
            right: 50,
            child: Opacity(
              opacity: 0.05, 
              child: RotationTransition(
                turns: _controller,
                child: SvgPicture.asset(
                  'assets/images/undraw_connected-world_anke.svg',
                  width: 120,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            ),
          ),

          // Bottom Left Doodle
          Positioned(
            bottom: 100,
            left: -30,
            child: Opacity(
              opacity: 0.05,
              child: Transform.rotate(
                angle: -0.2,
                child: SvgPicture.asset(
                  'assets/images/undraw_chat_qmyo.svg',
                  width: 250,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            ),
          ),

          // Mid-Right 3D Element
          Positioned(
            top: 300,
            right: -20,
            child: Opacity(
              opacity: 0.03,
              child: Image.asset(
                'assets/images/3dgraphics/image-keoWINYYBgXx7vwibZe2cbllJ4SaQA.png',
                width: 150,
              ),
            ),
          ),

          // --- LAYER 4: Content ---
          widget.useSafeArea ? SafeArea(child: widget.body) : widget.body,
        ],
      ),
    );
  }
}