import 'package:flutter/material.dart';

class AppColors {
  // Background colors
  static const Color backgroundDark = Color(0xFF121212);
  static const Color backgroundDarker = Color(0xFF1E1E2C);
  static const Color cardBackground = Color(0xFF2C2C2C);
  static const Color surface = Color(0xFF3A3A3A);
  
  // Neon accent colors
  static const Color neonCyan = Color(0xFF00FFFF);
  static const Color neonPurple = Color(0xFF9B59B6);
  static const Color oliveGold = Color(0xFFFFD700);
  static const Color darkOlive = Color(0xFF1E3A8A);
  static const Color neonGreen = Color(0xFF00FF7F);
  static const Color neonPink = Color(0xFFFF00FF);
  
  // Text colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textTertiary = Color(0xFF808080);
  
  // Status colors
  static const Color success = Color(0xFF00FF7F);
  static const Color warning = Color(0xFFFFFF00);
  static const Color error = Color(0xFFFF4444);
  static const Color info = Color(0xFF00FFFF);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [neonCyan, neonPurple],
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [backgroundDark, backgroundDarker],
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [cardBackground, Color(0xFF363636)],
  );
  
  // Glow effects
  static List<BoxShadow> neonGlow(Color color, {double spread = 0.0}) => [
    BoxShadow(
      color: color.withValues(alpha: 0.4),
      blurRadius: 8.0,
      spreadRadius: spread,
    ),
    BoxShadow(
      color: color.withValues(alpha: 0.3),
      blurRadius: 16.0,
      spreadRadius: spread,
    ),
    BoxShadow(
      color: color.withValues(alpha: 0.2),
      blurRadius: 24.0,
      spreadRadius: spread,
    ),
  ];
}