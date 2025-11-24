import 'dart:ui';

import 'package:vetto_ai/config/app_colors.dart';

enum WorkflowStatus {
  pending,
  active,
  completed,
  error,
  paused,
}

class Workflow {
  final String id;
  final String title;
  final String description;
  final WorkflowStatus status;
  final DateTime createdAt;
  final DateTime? completedAt;
  final List<WorkflowStep> steps;
  final Map<String, dynamic>? triggerConditions;
  final int progress;
  
  Workflow({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
    this.completedAt,
    required this.steps,
    this.triggerConditions,
    this.progress = 0,
  });
  
  Color get statusColor {
    switch (status) {
      case WorkflowStatus.completed:
        return AppColors.neonGreen;
      case WorkflowStatus.active:
        return AppColors.neonCyan;
      case WorkflowStatus.pending:
        return AppColors.oliveGold;
      case WorkflowStatus.error:
        return AppColors.error;
      case WorkflowStatus.paused:
        return AppColors.textTertiary;
    }
  }
  
  String get statusText {
    return status.toString().split('.').last;
  }
}

class WorkflowStep {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime? completedAt;
  
  WorkflowStep({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.completedAt,
  });
}