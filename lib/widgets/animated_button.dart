import 'package:flutter/material.dart';
import 'package:vetto_ai/config/app_colors.dart';
import 'package:vetto_ai/config/constants.dart';

class AnimatedButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;
  final bool isLoading;
  final IconData? icon;
  final double width;
  final Color? backgroundColor;
  final Color? textColor;
  
  const AnimatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.icon,
    this.width = double.infinity,
    this.backgroundColor,
    this.textColor,
  });
  
  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
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
    setState(() => _isPressed = true);
    _controller.forward();
  }
  
  void _onTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _controller.reverse();
    if (!widget.isLoading) {
      widget.onPressed();
    }
  }
  
  void _onTapCancel() {
    setState(() => _isPressed = false);
    _controller.reverse();
  }
  
  Color _getButtonColor() {
    if (widget.backgroundColor != null) return widget.backgroundColor!;
    
    switch (widget.type) {
      case ButtonType.primary:
        return Colors.white; // White button like Vetto Wallet
      case ButtonType.secondary:
        return Colors.transparent;
      case ButtonType.success:
        return Colors.white;
    }
  }
  
  Color _getTextColor() {
    if (widget.textColor != null) return widget.textColor!;
    
    switch (widget.type) {
      case ButtonType.primary:
        return AppColors.backgroundDark; // Dark text on white button
      case ButtonType.secondary:
        return Colors.white;
      case ButtonType.success:
        return AppColors.backgroundDark;
    }
  }
  
  Border? _getBorder() {
    if (widget.type == ButtonType.secondary) {
      return Border.all(color: Colors.white, width: 1.5);
    }
    return null;
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: widget.width,
          height: 56,
          decoration: BoxDecoration(
            color: _getButtonColor(),
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
            border: _getBorder(),
            // NO GLOW SHADOWS - Clean like Vetto Wallet
            boxShadow: _isPressed 
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: Center(
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
                          fontWeight: FontWeight.w700, // Bolder like Vetto Wallet
                          letterSpacing: 1.1,
                        ),
                      ),
                    ],
                  ),
          ),
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