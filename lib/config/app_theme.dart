// import 'app_colors.dart';
// import 'package:flutter/material.dart';

// class AppTheme {
//   static ThemeData get darkTheme {
//     return ThemeData(
//       brightness: Brightness.dark,
//       scaffoldBackgroundColor: AppColors.backgroundDark,
//       appBarTheme: const AppBarTheme(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         titleTextStyle: TextStyle(
//           fontSize: 24,
//           fontWeight: FontWeight.w700,
//           color: AppColors.textPrimary,
//         ),
//         iconTheme: IconThemeData(
//           color: AppColors.neonCyan,
//         ),
//       ),
//       colorScheme: const ColorScheme.dark(
//         primary: AppColors.neonCyan,
//         secondary: AppColors.neonPurple,
//         surface: AppColors.cardBackground,
//       ),
//       textTheme: const TextTheme(
//         displayLarge: TextStyle(
//           fontSize: 34,
//           fontWeight: FontWeight.w700,
//           color: AppColors.textPrimary,
//         ),
//         displayMedium: TextStyle(
//           fontSize: 28,
//           fontWeight: FontWeight.w700,
//           color: AppColors.textPrimary,
//         ),
//         headlineMedium: TextStyle(
//           fontSize: 22,
//           fontWeight: FontWeight.w600,
//           color: AppColors.textPrimary,
//         ),
//         titleLarge: TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.w600,
//           color: AppColors.textPrimary,
//         ),
//         bodyLarge: TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.w400,
//           color: AppColors.textSecondary,
//         ),
//         bodyMedium: TextStyle(
//           fontSize: 14,
//           fontWeight: FontWeight.w400,
//           color: AppColors.textSecondary,
//         ),
//       ),
//       cardTheme: CardThemeData(
//         color: AppColors.cardBackground,
//         elevation: 0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         margin: EdgeInsets.zero,
//       ),

//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: AppColors.surface,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(
//             color: AppColors.neonCyan,
//             width: 2,
//           ),
//         ),
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 16,
//           vertical: 14,
//         ),
//       ),
//       buttonTheme: ButtonThemeData(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         padding: const EdgeInsets.symmetric(
//           horizontal: 24,
//           vertical: 12,
//         ),
//       ),
//       floatingActionButtonTheme: FloatingActionButtonThemeData(
//         backgroundColor: AppColors.neonCyan,
//         foregroundColor: AppColors.backgroundDark,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//       ),
//     );
//   }
  
//   static ThemeData get rainbowOnboardingTheme {
//     return darkTheme.copyWith(
//       scaffoldBackgroundColor: AppColors.darkOlive,
//       colorScheme: darkTheme.colorScheme.copyWith(
//         primary: AppColors.oliveGold,
//         secondary: AppColors.neonGreen,
//       ),
//     );
//   }
// }


import 'app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        iconTheme: IconThemeData(
          color: AppColors.neonCyan,
        ),
      ),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.neonCyan,
        secondary: AppColors.neonPurple,
        surface: AppColors.cardBackground,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: EdgeInsets.zero,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.neonCyan,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.neonCyan,
        foregroundColor: AppColors.backgroundDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
  
  static ThemeData get rainbowOnboardingTheme {
    return darkTheme.copyWith(
      scaffoldBackgroundColor: AppColors.darkOlive,
      colorScheme: darkTheme.colorScheme.copyWith(
        primary: AppColors.oliveGold,
        secondary: AppColors.neonGreen,
      ),
    );
  }

  // --- New Vetto Theme ---
  static ThemeData get vettoTheme {
    // Start with the base dark theme and override
    return darkTheme.copyWith(
      // Use the darker bottom color as a solid fallback.
      // For the full gradient effect, apply AppColors.vettoBackgroundGradient
      // to a Container in your scaffold's body.
      scaffoldBackgroundColor: AppColors.vettoBgBottom,
      
      appBarTheme: darkTheme.appBarTheme.copyWith(
        iconTheme: const IconThemeData(
          color: AppColors.vettoTextWhite, // White icons
        ),
        titleTextStyle: darkTheme.appBarTheme.titleTextStyle?.copyWith(
          color: AppColors.vettoTextWhite, // White title
        ),
      ),
      
      colorScheme: darkTheme.colorScheme.copyWith(
        primary: AppColors.vettoAccentGreen, // Use the logo's green as primary
        secondary: AppColors.vettoTextWhite, // White as secondary
        surface: AppColors.vettoBgTop, // Lighter part of bg for surfaces/cards
        onPrimary: AppColors.vettoBgBottom, // Text on primary button
      ),
      
      textTheme: darkTheme.textTheme.apply(
        bodyColor: AppColors.vettoTextWhite, // Main text color
        displayColor: AppColors.vettoTextWhite, // Headlines color
      ),
      
      floatingActionButtonTheme: darkTheme.floatingActionButtonTheme.copyWith(
        backgroundColor: AppColors.vettoAccentGreen,
        foregroundColor: AppColors.vettoTextWhite,
      ),

      inputDecorationTheme: darkTheme.inputDecorationTheme.copyWith(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.vettoAccentGreen,
            width: 2,
          ),
        ),
      ),
    );
  }
}
