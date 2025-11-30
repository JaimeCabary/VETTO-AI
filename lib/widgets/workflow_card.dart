// // import 'package:flutter/material.dart';
// // import 'package:uruella_ai/config/app_colors.dart';
// // import 'package:uruella_ai/config/constants.dart';
// // import 'package:uruella_ai/models/workflow.dart';
// // import 'package:uruella_ai/utils/animations.dart';

// // class WorkflowCard extends StatefulWidget {
// //   final Workflow workflow;
// //   final VoidCallback? onTap;
// //   final VoidCallback? onLongPress;
// //   final bool isDragging;
  
// //   const WorkflowCard({
// //     super.key,
// //     required this.workflow,
// //     this.onTap,
// //     this.onLongPress,
// //     this.isDragging = false,
// //   });
  
// //   @override
// //   State<WorkflowCard> createState() => _WorkflowCardState();
// // }

// // class _WorkflowCardState extends State<WorkflowCard> 
// //     with SingleTickerProviderStateMixin {
// //   late AnimationController _pulseController;
// //   late Animation<double> _pulseAnimation;
  
// //   @override
// //   void initState() {
// //     super.initState();
// //     _pulseController = AnimationController(
// //       duration: const Duration(seconds: 2),
// //       vsync: this,
// //     );
// //     _pulseAnimation = AppAnimations.createPulseAnimation(_pulseController);
    
// //     if (widget.workflow.status == WorkflowStatus.active) {
// //       _pulseController.repeat(reverse: true);
// //     }
// //   }
  
// //   @override
// //   void didUpdateWidget(WorkflowCard oldWidget) {
// //     super.didUpdateWidget(oldWidget);
// //     if (widget.workflow.status == WorkflowStatus.active) {
// //       _pulseController.repeat(reverse: true);
// //     } else {
// //       _pulseController.stop();
// //       _pulseController.value = 0;
// //     }
// //   }
  
// //   @override
// //   void dispose() {
// //     _pulseController.dispose();
// //     super.dispose();
// //   }
  
// //   @override
// //   Widget build(BuildContext context) {
// //     return AnimatedBuilder(
// //       animation: _pulseAnimation,
// //       builder: (context, child) {
// //         return Transform.scale(
// //           scale: widget.isDragging ? 1.05 : _pulseAnimation.value,
// //           child: HoverAnimationBuilder(
// //             child: GestureDetector(
// //               onTap: widget.onTap,
// //               onLongPress: widget.onLongPress,
// //               child: Container(
// //                 margin: const EdgeInsets.only(bottom: AppConstants.spacingM),
// //                 padding: AppConstants.paddingCard,
// //                 decoration: BoxDecoration(
// //                   gradient: AppColors.cardGradient,
// //                   borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
// //                   boxShadow: [
// //                     ...AppColors.neonGlow(widget.workflow.statusColor),
// //                     if (widget.isDragging)
// //                       BoxShadow(
// //                         color: widget.workflow.statusColor.withValues(alpha: 0.5),
// //                         blurRadius: 20,
// //                         spreadRadius: 2,
// //                       ),
// //                   ],
// //                 ),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     // Header with status
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         Expanded(
// //                           child: Text(
// //                             widget.workflow.title,
// //                             style: Theme.of(context).textTheme.titleLarge,
// //                             maxLines: 1,
// //                             overflow: TextOverflow.ellipsis,
// //                           ),
// //                         ),
// //                         Container(
// //                           padding: const EdgeInsets.symmetric(
// //                             horizontal: AppConstants.spacingS,
// //                             vertical: AppConstants.spacingXS,
// //                           ),
// //                           decoration: BoxDecoration(
// //                             color: widget.workflow.statusColor.withValues(alpha: 0.2),
// //                             borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
// //                             border: Border.all(
// //                               color: widget.workflow.statusColor,
// //                               width: 1,
// //                             ),
// //                           ),
// //                           child: Text(
// //                             widget.workflow.statusText.toUpperCase(),
// //                             style: TextStyle(
// //                               color: widget.workflow.statusColor,
// //                               fontSize: AppConstants.fontSizeXS,
// //                               fontWeight: FontWeight.w600,
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
                    
// //                     const SizedBox(height: AppConstants.spacingS),
                    
// //                     // Description
// //                     Text(
// //                       widget.workflow.description,
// //                       style: Theme.of(context).textTheme.bodyMedium,
// //                       maxLines: 2,
// //                       overflow: TextOverflow.ellipsis,
// //                     ),
                    
// //                     const SizedBox(height: AppConstants.spacingM),
                    
// //                     // Progress bar
// //                     LinearProgressIndicator(
// //                       value: widget.workflow.progress / 100,
// //                       backgroundColor: AppColors.surface,
// //                       valueColor: AlwaysStoppedAnimation(widget.workflow.statusColor),
// //                       borderRadius: BorderRadius.circular(AppConstants.borderRadiusS),
// //                     ),
                    
// //                     const SizedBox(height: AppConstants.spacingS),
                    
// //                     // Footer with steps and date
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         Text(
// //                           '${widget.workflow.steps.where((s) => s.isCompleted).length}'
// //                           '/${widget.workflow.steps.length} steps',
// //                           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
// //                             color: AppColors.textTertiary,
// //                           ),
// //                         ),
// //                         Text(
// //                           _formatDate(widget.workflow.createdAt),
// //                           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
// //                             color: AppColors.textTertiary,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }
  
// //   String _formatDate(DateTime date) {
// //     final now = DateTime.now();
// //     final difference = now.difference(date);
    
// //     if (difference.inDays > 7) {
// //       return '${date.day}/${date.month}/${date.year}';
// //     } else if (difference.inDays > 0) {
// //       return '${difference.inDays}d ago';
// //     } else if (difference.inHours > 0) {
// //       return '${difference.inHours}h ago';
// //     } else {
// //       return '${difference.inMinutes}m ago';
// //     }
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:uruella_ai/config/app_colors.dart';
// import 'package:uruella_ai/config/constants.dart';
// import 'package:uruella_ai/models/workflow.dart';

// class WorkflowCard extends StatelessWidget {
//   final Workflow workflow;
//   final VoidCallback? onTap;
//   final VoidCallback? onLongPress;
  
//   const WorkflowCard({
//     super.key,
//     required this.workflow,
//     this.onTap,
//     this.onLongPress,
//   });
  
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: AppConstants.spacingM),
//       color: AppColors.surface,
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
//       ),
//       child: InkWell(
//         onTap: onTap,
//         onLongPress: onLongPress,
//         borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
//         child: Container(
//           padding: AppConstants.paddingCard,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header with status
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       workflow.title,
//                       style: Theme.of(context).textTheme.titleLarge,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: AppConstants.spacingS,
//                       vertical: AppConstants.spacingXS,
//                     ),
//                     decoration: BoxDecoration(
//                       color: workflow.statusColor.withValues(alpha: 0.1),
//                       borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
//                       border: Border.all(
//                         color: workflow.statusColor,
//                         width: 1,
//                       ),
//                     ),
//                     child: Text(
//                       workflow.statusText.toUpperCase(),
//                       style: TextStyle(
//                         color: workflow.statusColor,
//                         fontSize: AppConstants.fontSizeXS,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
              
//               const SizedBox(height: AppConstants.spacingS),
              
//               // Description
//               Text(
//                 workflow.description,
//                 style: Theme.of(context).textTheme.bodyMedium,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
              
//               const SizedBox(height: AppConstants.spacingM),
              
//               // Progress bar
//               LinearProgressIndicator(
//                 value: workflow.progress / 100,
//                 backgroundColor: AppColors.backgroundDark,
//                 valueColor: AlwaysStoppedAnimation(workflow.statusColor),
//                 borderRadius: BorderRadius.circular(AppConstants.borderRadiusS),
//               ),
              
//               const SizedBox(height: AppConstants.spacingS),
              
//               // Footer with steps and date
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     '${workflow.steps.where((s) => s.isCompleted).length}'
//                     '/${workflow.steps.length} steps',
//                     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                       color: AppColors.textTertiary,
//                     ),
//                   ),
//                   Text(
//                     _formatDate(workflow.createdAt),
//                     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                       color: AppColors.textTertiary,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
  
//   String _formatDate(DateTime date) {
//     final now = DateTime.now();
//     final difference = now.difference(date);
    
//     if (difference.inDays > 7) {
//       return '${date.day}/${date.month}/${date.year}';
//     } else if (difference.inDays > 0) {
//       return '${difference.inDays}d ago';
//     } else if (difference.inHours > 0) {
//       return '${difference.inHours}h ago';
//     } else {
//       return '${difference.inMinutes}m ago';
//     }
//   }
// }




import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:uruella_ai/models/workflow.dart';

class WorkflowCard extends StatelessWidget {
  final Workflow workflow;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  
  const WorkflowCard({
    super.key,
    required this.workflow,
    this.onTap,
    this.onLongPress,
  });
  
  // Helper to get status color without AppColors
  Color get _statusColor {
    switch (workflow.status) {
      case WorkflowStatus.completed: return const Color(0xFF8DA385); // Soft Green
      case WorkflowStatus.active: return Colors.white;
      case WorkflowStatus.pending: return const Color(0xFFB5A642); // Olive Gold
      case WorkflowStatus.error: return const Color(0xFFD95D5D); // Muted Red
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              onLongPress: onLongPress,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            workflow.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // Status Dot
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _statusColor.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: _statusColor.withValues(alpha: 0.5)),
                          ),
                          child: Text(
                            workflow.statusText.toUpperCase(),
                            style: TextStyle(
                              color: _statusColor,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 8),
                    
                    Text(
                      workflow.description,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Progress Bar (Thin and clean)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: LinearProgressIndicator(
                        value: workflow.progress / 100,
                        backgroundColor: Colors.white.withValues(alpha: 0.1),
                        valueColor: AlwaysStoppedAnimation(_statusColor),
                        minHeight: 4,
                      ),
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Footer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${workflow.steps.where((s) => s.isCompleted).length}/${workflow.steps.length} steps',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          _formatDate(workflow.createdAt),
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inDays > 7) {
      return '${date.day}/${date.month}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else {
      return 'Just now';
    }
  }
}