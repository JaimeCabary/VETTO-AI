import 'package:flutter/material.dart';
import 'package:vetto_ai/config/app_colors.dart';
import 'package:vetto_ai/config/constants.dart';
import 'package:vetto_ai/utils/animations.dart';

class AnimatedButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;
  final bool isLoading;
  final IconData? icon;
  final double width;
  
  const AnimatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.icon,
    this.width = double.infinity,
  });
  
  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppAnimations.medium,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }
  
  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onPressed();
  }
  
  void _onTapCancel() {
    _controller.reverse();
  }
  
  Color _getButtonColor() {
    switch (widget.type) {
      case ButtonType.primary:
        return AppColors.neonCyan;
      case ButtonType.secondary:
        return AppColors.neonPurple;
      case ButtonType.success:
        return AppColors.neonGreen;
    }
  }
  
  Color _getTextColor() {
    switch (widget.type) {
      case ButtonType.primary:
      case ButtonType.secondary:
      case ButtonType.success:
        return AppColors.backgroundDark;
    }
  }
  
  List<BoxShadow> _getGlowShadows() {
    final color = _getButtonColor();
    return [
      BoxShadow(
        color: color.withValues(alpha: 0.6),
        blurRadius: 8,
        spreadRadius: 2,
      ),
      BoxShadow(
        color: color.withValues(alpha: 0.3),
        blurRadius: 16,
        spreadRadius: 4,
      ),
    ];
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedBuilder(
          animation: _glowAnimation,
          builder: (context, child) {
            return Container(
              width: widget.width,
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _getButtonColor(),
                    _getButtonColor().withValues(alpha: 0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
                boxShadow: _getGlowShadows(),
              ),
              child: Stack(
                children: [
                  // Pulsing glow effect
                  if (_glowAnimation.value > 0)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
                          gradient: RadialGradient(
                            center: Alignment.center,
                            radius: 1.5,
                            colors: [
                              _getButtonColor().withValues(alpha: 0.3 * _glowAnimation.value),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                  
                  // Content
                  Center(
                    child: widget.isLoading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(_getTextColor()),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (widget.icon != null) ...[
                                Icon(
                                  widget.icon,
                                  color: _getTextColor(),
                                  size: AppConstants.iconSizeM,
                                ),
                                const SizedBox(width: AppConstants.spacingS),
                              ],
                              Text(
                                widget.text,
                                style: TextStyle(
                                  color: _getTextColor(),
                                  fontSize: AppConstants.fontSizeM,
                                  fontWeight: FontWeight.w600,
                                ),
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
    );
  }
}

enum ButtonType {
  primary,
  secondary,
  success,
}