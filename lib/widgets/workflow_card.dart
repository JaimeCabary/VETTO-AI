import 'package:flutter/material.dart';
import 'package:vetto_ai/config/app_colors.dart';
import 'package:vetto_ai/config/constants.dart';
import 'package:vetto_ai/models/workflow.dart';
import 'package:vetto_ai/utils/animations.dart';

class WorkflowCard extends StatefulWidget {
  final Workflow workflow;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool isDragging;
  
  const WorkflowCard({
    super.key,
    required this.workflow,
    this.onTap,
    this.onLongPress,
    this.isDragging = false,
  });
  
  @override
  State<WorkflowCard> createState() => _WorkflowCardState();
}

class _WorkflowCardState extends State<WorkflowCard> 
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  
  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pulseAnimation = AppAnimations.createPulseAnimation(_pulseController);
    
    if (widget.workflow.status == WorkflowStatus.active) {
      _pulseController.repeat(reverse: true);
    }
  }
  
  @override
  void didUpdateWidget(WorkflowCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.workflow.status == WorkflowStatus.active) {
      _pulseController.repeat(reverse: true);
    } else {
      _pulseController.stop();
      _pulseController.value = 0;
    }
  }
  
  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: widget.isDragging ? 1.05 : _pulseAnimation.value,
          child: HoverAnimationBuilder(
            child: GestureDetector(
              onTap: widget.onTap,
              onLongPress: widget.onLongPress,
              child: Container(
                margin: const EdgeInsets.only(bottom: AppConstants.spacingM),
                padding: AppConstants.paddingCard,
                decoration: BoxDecoration(
                  gradient: AppColors.cardGradient,
                  borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
                  boxShadow: [
                    ...AppColors.neonGlow(widget.workflow.statusColor),
                    if (widget.isDragging)
                      BoxShadow(
                        color: widget.workflow.statusColor.withValues(alpha: 0.5),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.workflow.title,
                            style: Theme.of(context).textTheme.titleLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppConstants.spacingS,
                            vertical: AppConstants.spacingXS,
                          ),
                          decoration: BoxDecoration(
                            color: widget.workflow.statusColor.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                            border: Border.all(
                              color: widget.workflow.statusColor,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            widget.workflow.statusText.toUpperCase(),
                            style: TextStyle(
                              color: widget.workflow.statusColor,
                              fontSize: AppConstants.fontSizeXS,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: AppConstants.spacingS),
                    
                    // Description
                    Text(
                      widget.workflow.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: AppConstants.spacingM),
                    
                    // Progress bar
                    LinearProgressIndicator(
                      value: widget.workflow.progress / 100,
                      backgroundColor: AppColors.surface,
                      valueColor: AlwaysStoppedAnimation(widget.workflow.statusColor),
                      borderRadius: BorderRadius.circular(AppConstants.borderRadiusS),
                    ),
                    
                    const SizedBox(height: AppConstants.spacingS),
                    
                    // Footer with steps and date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.workflow.steps.where((s) => s.isCompleted).length}'
                          '/${widget.workflow.steps.length} steps',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                        Text(
                          _formatDate(widget.workflow.createdAt),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 7) {
      return '${date.day}/${date.month}/${date.year}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inMinutes}m ago';
    }
  }
}