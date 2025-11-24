// import 'package:flutter/material.dart';
// import '../config/app_colors.dart';
// import '../config/constants.dart';

// class BottomNavBar extends StatefulWidget {
//   final int currentIndex;
//   final Function(int) onTap;

//   const BottomNavBar({
//     super.key,
//     required this.currentIndex,
//     required this.onTap,
//   });

//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(16),
//       height: 70,
//       decoration: BoxDecoration(
//         color: AppColors.surface,
//         borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
//         border: Border.all(
//           color: AppColors.surface.withValues(alpha: 0.1),
//         ),
//       ),
//       child: Row(
//         children: [
//           _buildNavItem(0, Icons.dashboard, 'Workflows'),
//           _buildNavItem(1, Icons.auto_awesome, 'AI Chat'),
//           _buildNavItem(2, Icons.design_services, 'Sites'),
//           _buildNavItem(3, Icons.person, 'Profile'),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavItem(int index, IconData icon, String label) {
//     final isSelected = widget.currentIndex == index;
//     return Expanded(
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: () => widget.onTap(index),
//           borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 width: isSelected ? 40 : 32,
//                 height: isSelected ? 40 : 32,
//                 decoration: BoxDecoration(
//                   gradient: isSelected ? AppColors.primaryGradient : null,
//                   color: isSelected ? null : Colors.transparent,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   icon,
//                   size: isSelected ? 20 : 18,
//                   color: isSelected ? AppColors.backgroundDark : AppColors.textTertiary,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: AppConstants.fontSizeXS,
//                   color: isSelected ? AppColors.neonCyan : AppColors.textTertiary,
//                   fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'dart:ui';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      height: 80,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.2), // Darker glass for contrast
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(0, Icons.dashboard_rounded, 'Workflows'),
                _buildNavItem(1, Icons.auto_awesome, 'AI Chat'),
                _buildNavItem(2, Icons.web, 'Sites'),
                _buildNavItem(3, Icons.person, 'Profile'),
                _buildNavItem(4, Icons.settings, 'Settings'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = widget.currentIndex == index;
    
    return GestureDetector(
      onTap: () => widget.onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withValues(alpha: 0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              // Vetto Green for selected, White 50% for unselected
              color: isSelected ? const Color(0xFF7E8F77) : Colors.white.withValues(alpha: 0.5),
            ),
            if (isSelected) ...[
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}