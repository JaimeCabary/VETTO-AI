

// import 'package:flutter/material.dart';

// class AppColors {
//   // --- Vetto Brand Colors (from Image) ---
//   // Background Gradient Colors
//   static const Color vettoBgTop = Color(0xFF6A7B66); // Grayish-olive green from top
//   static const Color vettoBgBottom = Color(0xFF2F3A2F); // Dark muted green from bottom
  
//   // Logo Accent Colors
//   static const Color vettoAccentGreen = Color(0xFF7E8F77); // Lighter green in the logo's 'V'
//   static const Color vettoAccentDark = Color(0xFF1C211E); // Dark/black parts of the logo
//   static const Color vettoTextWhite = Color(0xFFFFFFFF); // White color for text and logo parts

//   // --- Existing App Colors ---
//   // Background Colors
//   static const Color backgroundDark = Color(0xFF121212);
//   static const Color backgroundDarker = Color(0xFF0A0A0A);
//   static const Color surface = Color(0xFF1E1E2C);
//   static const Color cardBackground = Color(0xFF2C2C2C);

//   // Text Colors
//   static const Color textPrimary = Color(0xFFFFFFFF);
//   static const Color textSecondary = Color(0xFFA0A0A0);
//   static const Color textTertiary = Color(0xFF666666);

//   // Accent Colors
//   static const Color neonCyan = Color(0xFF00FFFF);
//   static const Color neonPurple = Color(0xFF9B59B6);
//   static const Color neonGreen = Color(0xFF00FF7F);
//   static const Color oliveGold = Color(0xFFB5A642);
//   static const Color darkOlive = Color(0xFF1E3A8A);
//   static const Color error = Color(0xFFFF4757);
//   static const Color neonPink = Color(0xFFFF6B9D);

//   // --- Gradients ---
  
//   // New Vetto Background Gradient
//   static const Gradient vettoBackgroundGradient = LinearGradient(
//     begin: Alignment.topCenter,
//     end: Alignment.bottomCenter,
//     colors: [vettoBgTop, vettoBgBottom],
//   );

//   static const Gradient primaryGradient = LinearGradient(
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//     colors: [neonCyan, neonPurple],
//   );

//   static const Gradient cardGradient = LinearGradient(
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//     colors: [surface, cardBackground],
//   );

//   // Helper method for alpha values - replaces withOpacity
//   static Color withValues({required Color color, double? alpha}) {
//     return color.withValues(alpha:alpha ?? 1.0);
//   }

//   // Clean shadows instead of glows
//   static List<BoxShadow> get subtleShadow => [
//         BoxShadow(
//           color: Colors.black.withValues(alpha:0.2),
//           blurRadius: 8,
//           offset: const Offset(0, 4),
//         ),
//       ];

//   static List<BoxShadow> get mediumShadow => [
//         BoxShadow(
//           color: Colors.black.withValues(alpha:0.3),
//           blurRadius: 12,
//           offset: const Offset(0, 6),
//         ),
//       ];

//   static List<BoxShadow> get cardShadow => [
//         BoxShadow(
//           color: Colors.black.withValues(alpha:0.25),
//           blurRadius: 16,
//           offset: const Offset(0, 8),
//         ),
//       ];
// }




import 'package:flutter/material.dart';

class AppColors {
  // --- Vetto Brand Colors (from Image) ---
  static const Color vettoBgTop = Color.fromRGBO(0, 0, 0, 1); // Grayish-olive green
  static const Color vettoBgBottom = Color(0xFF2F3A2F); // Dark muted green

  // Logo Accent Colors
  static const Color vettoAccentGreen = Color(0xFF7E8F77); // Light green in logo 'V'
  static const Color vettoAccentDark = Color(0xFF1C211E); // Dark/black parts of logo
  static const Color vettoTextWhite = Color(0xFFFFFFFF); // White text/logo

  // --- Existing App Colors ---
  static const Color backgroundDark = vettoBgBottom; // merged
  static const Color backgroundDarker = Color(0xFF0A0A0A);
  static const Color surface = Color.fromARGB(255, 0, 85, 44);
  static const Color cardBackground = Color.fromARGB(255, 19, 14, 14);
  static const Color surfaceLight = Color(0xFF4A5A4A); // new

  // Text Colors
  static const Color textPrimary = vettoTextWhite; // merged
  static const Color textSecondary = Color(0xFFA0A0A0); // original fallback
  static const Color textTertiary = Color(0xFF666666); // original fallback

  // Accent Colors
  static const Color neonCyan = Color(0xFF00FFFF);
  static const Color neonPurple = Color(0xFF9B59B6);
  static const Color neonGreen = Color(0xFF00FF7F);
  static const Color oliveGold = Color(0xFFB5A642);
  static const Color darkOlive = Color(0xFF1E3A8A);
  static const Color error = Color(0xFFFF4757);
  static const Color neonPink = Color(0xFFFF6B9D);

  static const Color primary = vettoAccentGreen; // merged
  static const Color secondary = Color(0xFF9BBA9B); // new
  static const Color accent = Color(0xFFB5A642); // new
  static const Color success = Color(0xFF51CF66); // new

  // Button Colors
  static const Color buttonPrimary = vettoAccentGreen; // merged
  static const Color buttonSecondary = Colors.transparent;
  static const Color buttonTextLight = vettoTextWhite;
  static const Color buttonTextDark = vettoBgBottom;

  // --- Gradients ---
  static const Gradient vettoBackgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [vettoBgTop, vettoBgBottom],
  );

  static const Gradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [neonCyan, neonPurple],
  );

  static const Gradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [surface, cardBackground],
  );

  static const Gradient buttonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [vettoAccentGreen, Color(0xFF9BBA9B)],
  );

  // Helper method for alpha/opacity values
  static Color withValues({required Color color, double alpha = 1.0}) {
    return color.withValues(alpha:alpha);
  }

  // --- Shadows ---
  static List<BoxShadow> get subtleShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha:0.2),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get mediumShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha:0.3),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ];

  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha:0.25),
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ];
}
