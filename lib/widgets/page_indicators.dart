// // lib/widgets/page_indicators.dart
// import 'package:flutter/material.dart';
// import '../config/app_colors.dart';
// import '../config/constants.dart';

// class PageIndicators extends StatelessWidget {
//   final int currentPage;
//   final int totalPages;
//   final Color activeColor;
//   final Color inactiveColor;

//   const PageIndicators({
//     super.key,
//     required this.currentPage,
//     required this.totalPages,
//     this.activeColor = AppColors.neonCyan,
//     this.inactiveColor = AppColors.textTertiary,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(totalPages, (index) {
//         return Container(
//           margin: const EdgeInsets.symmetric(horizontal: AppConstants.spacingXS),
//           width: index == currentPage ? 20 : 8,
//           height: 8,
//           decoration: BoxDecoration(
//             color: index == currentPage ? activeColor : inactiveColor,
//             borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
//             // Removed boxShadow to remove glow effect
//           ),
//         );
//       }),
//     );
//   }
// }



import 'package:flutter/material.dart';

class PageIndicators extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  // Defaults updated to Vetto Style
  final Color activeColor;
  final Color inactiveColor;

  const PageIndicators({
    super.key,
    required this.currentPage,
    required this.totalPages,
    this.activeColor = Colors.white,
    this.inactiveColor = const Color(0x4DFFFFFF), // White with ~30% opacity
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: index == currentPage ? 24 : 8, // Longer active pill
          height: 8,
          decoration: BoxDecoration(
            color: index == currentPage ? activeColor : inactiveColor,
            borderRadius: BorderRadius.circular(12),
          ),
        );
      }),
    );
  }
}