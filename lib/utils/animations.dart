import 'package:flutter/material.dart';

class AppAnimations {
  // Curves
  static const Curve easeIn = Curves.easeIn;
  static const Curve easeOut = Curves.easeOut;
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve easeOutBack = Curves.easeOutBack;
  static const Curve elasticOut = Curves.elasticOut;
  static const Curve bounceOut = Curves.bounceOut;
  
  // Durations
  static const Duration quick = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 400);
  static const Duration slow = Duration(milliseconds: 600);
  static const Duration deliberate = Duration(milliseconds: 800);
  
  // Animation builders
  static Widget fadeScaleTransition({
    required Widget child,
    required Animation<double> animation,
  }) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: CurvedAnimation(
          parent: animation,
          curve: easeOutBack,
        ),
        child: child,
      ),
    );
  }
  
  static Widget slideTransition({
    required Widget child,
    required Animation<double> animation,
    AxisDirection direction = AxisDirection.down,
  }) {
    final offset = _getOffsetByDirection(direction);
    return SlideTransition(
      position: Tween<Offset>(
        begin: offset,
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: easeOut,
      )),
      child: child,
    );
  }
  
  static Offset _getOffsetByDirection(AxisDirection direction) {
    switch (direction) {
      case AxisDirection.up:
        return const Offset(0, 1);
      case AxisDirection.right:
        return const Offset(-1, 0);
      case AxisDirection.down:
        return const Offset(0, -1);
      case AxisDirection.left:
        return const Offset(1, 0);
    }
  }
  
  // Pulsing animation
  static Animation<double> createPulseAnimation(AnimationController controller) {
    return Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );
  }
  
  // Glow animation
  static Animation<double> createGlowAnimation(AnimationController controller) {
    return Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );
  }
}

class HoverAnimationBuilder extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final double hoverScale;
  
  const HoverAnimationBuilder({
    super.key,
    required this.child,
    this.duration = AppAnimations.quick,
    this.curve = Curves.easeInOut,
    this.hoverScale = 1.05,
  });
  
  @override
  State<HoverAnimationBuilder> createState() => _HoverAnimationBuilderState();
}

class _HoverAnimationBuilderState extends State<HoverAnimationBuilder> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.hoverScale,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  void _onHover(bool isHovering) {
    if (isHovering) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}