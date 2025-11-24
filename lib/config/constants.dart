import 'package:flutter/material.dart';
class AppConstants {
  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;
  
  // Padding
  static const EdgeInsets paddingPage = EdgeInsets.all(spacingL);
  static const EdgeInsets paddingCard = EdgeInsets.all(spacingM);
  static const EdgeInsets paddingButton = EdgeInsets.symmetric(
    horizontal: spacingL,
    vertical: spacingM,
  );
  
  // Border radius
  static const double borderRadiusS = 8.0;
  static const double borderRadiusM = 12.0;
  static const double borderRadiusL = 16.0;
  static const double borderRadiusXL = 24.0;
  
  // Animation durations
  static const Duration animationShort = Duration(milliseconds: 200);
  static const Duration animationMedium = Duration(milliseconds: 400);
  static const Duration animationLong = Duration(milliseconds: 600);
  static const Duration animationXLong = Duration(milliseconds: 1200);
  
  // Font sizes
  static const double fontSizeXS = 12.0;
  static const double fontSizeS = 14.0;
  static const double fontSizeM = 16.0;
  static const double fontSizeL = 18.0;
  static const double fontSizeXL = 24.0;
  static const double fontSizeXXL = 32.0;
  
  // Icon sizes
  static const double iconSizeS = 16.0;
  static const double iconSizeM = 24.0;
  static const double iconSizeL = 32.0;
  static const double iconSizeXL = 48.0;
}