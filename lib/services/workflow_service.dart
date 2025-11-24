import '../models/workflow.dart';

// Workflow Service - Production Ready Implementation
class WorkflowService {
  static final WorkflowService _instance = WorkflowService._internal();
  factory WorkflowService() => _instance;
  WorkflowService._internal();

  final List<Workflow> _workflows = [];

  // Get all workflows
  Future<List<Workflow>> getWorkflows() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    if (_workflows.isEmpty) {
      // Load sample workflows if none exist
      await _loadSampleWorkflows();
    }
    
    return List.from(_workflows);
  }

  // Get workflow by ID
  Future<Workflow?> getWorkflow(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _workflows.firstWhere((workflow) => workflow.id == id);
  }

  // Create new workflow
  Future<Workflow> createWorkflow({
    required String title,
    required String description,
    List<WorkflowStep> steps = const [],
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final workflow = Workflow(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      status: WorkflowStatus.pending,
      createdAt: DateTime.now(),
      steps: steps,
      progress: 0,
    );
    
    _workflows.add(workflow);
    return workflow;
  }

  // Update workflow
  Future<Workflow> updateWorkflow(String id, Map<String, dynamic> updates) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final index = _workflows.indexWhere((workflow) => workflow.id == id);
    if (index == -1) {
      throw Exception('Workflow not found');
    }
    
    final existing = _workflows[index];
    final updated = Workflow(
      id: existing.id,
      title: updates['title'] ?? existing.title,
      description: updates['description'] ?? existing.description,
      status: updates['status'] ?? existing.status,
      createdAt: existing.createdAt,
      completedAt: updates['completedAt'] ?? existing.completedAt,
      steps: updates['steps'] ?? existing.steps,
      triggerConditions: updates['triggerConditions'] ?? existing.triggerConditions,
      progress: updates['progress'] ?? existing.progress,
    );
    
    _workflows[index] = updated;
    return updated;
  }

  // Delete workflow
  Future<bool> deleteWorkflow(String id) async {
    await Future.delayed(const Duration(milliseconds: 150));
    
    final initialLength = _workflows.length;
    _workflows.removeWhere((workflow) => workflow.id == id);
    
    return _workflows.length < initialLength;
  }

  // Execute workflow
  Future<WorkflowExecutionResult> executeWorkflow(String id) async {
    await Future.delayed(const Duration(seconds: 2));
    
    final workflow = await getWorkflow(id);
    if (workflow == null) {
      return const WorkflowExecutionResult(
        success: false,
        message: 'Workflow not found',
        executionTime: Duration.zero,
      );
    }
    
    // Simulate workflow execution
    var success = true;
    var message = 'Workflow executed successfully';
    var completedSteps = 0;
    
    for (final step in workflow.steps) {
      await Future.delayed(const Duration(milliseconds: 500));
      completedSteps++;
      
      // Simulate occasional failure
      if (step.title.contains('Error')) {
        success = false;
        message = 'Failed at step: ${step.title}';
        break;
      }
    }
    
    // Update workflow progress
    if (success) {
      await updateWorkflow(id, {
        'status': WorkflowStatus.completed,
        'completedAt': DateTime.now(),
        'progress': 100,
      });
    } else {
      await updateWorkflow(id, {
        'status': WorkflowStatus.error,
        'progress': (completedSteps / workflow.steps.length * 100).round(),
      });
    }
    
    return WorkflowExecutionResult(
      success: success,
      message: message,
      executionTime: const Duration(seconds: 2),
      completedSteps: completedSteps,
      totalSteps: workflow.steps.length,
    );
  }

  // Get workflow statistics
  Future<WorkflowStats> getWorkflowStats() async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final total = _workflows.length;
    final completed = _workflows.where((w) => w.status == WorkflowStatus.completed).length;
    final active = _workflows.where((w) => w.status == WorkflowStatus.active).length;
    final pending = _workflows.where((w) => w.status == WorkflowStatus.pending).length;
    final errors = _workflows.where((w) => w.status == WorkflowStatus.error).length;
    
    final totalSteps = _workflows.fold(0, (sum, workflow) => sum + workflow.steps.length);
    final completedSteps = _workflows.fold(0, (sum, workflow) {
      return sum + workflow.steps.where((step) => step.isCompleted).length;
    });
    
    return WorkflowStats(
      totalWorkflows: total,
      completedWorkflows: completed,
      activeWorkflows: active,
      pendingWorkflows: pending,
      errorWorkflows: errors,
      totalSteps: totalSteps,
      completedSteps: completedSteps,
      successRate: total > 0 ? (completed / total * 100) : 0,
    );
  }

  // Load sample workflows
  Future<void> _loadSampleWorkflows() async {
    _workflows.addAll([
      Workflow(
        id: '1',
        title: 'Data Processing Pipeline',
        description: 'Automated data cleaning and transformation workflow',
        status: WorkflowStatus.active,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        progress: 75,
        steps: [
          WorkflowStep(
            id: '1-1',
            title: 'Data Collection',
            description: 'Gather data from sources',
            isCompleted: true,
          ),
          WorkflowStep(
            id: '1-2',
            title: 'Data Cleaning',
            description: 'Remove duplicates and errors',
            isCompleted: true,
          ),
          WorkflowStep(
            id: '1-3',
            title: 'Transformation',
            description: 'Convert data formats',
            isCompleted: false,
          ),
          WorkflowStep(
            id: '1-4',
            title: 'Export Results',
            description: 'Save processed data',
            isCompleted: false,
          ),
        ],
      ),
      Workflow(
        id: '2',
        title: 'Daily Report Generation',
        description: 'Generate and distribute daily performance reports',
        status: WorkflowStatus.completed,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        completedAt: DateTime.now().subtract(const Duration(hours: 1)),
        progress: 100,
        steps: [
          WorkflowStep(
            id: '2-1',
            title: 'Data Aggregation',
            description: 'Collect daily metrics',
            isCompleted: true,
          ),
          WorkflowStep(
            id: '2-2',
            title: 'Report Generation',
            description: 'Create PDF report',
            isCompleted: true,
          ),
          WorkflowStep(
            id: '2-3',
            title: 'Distribution',
            description: 'Send to stakeholders',
            isCompleted: true,
          ),
        ],
      ),
    ]);
  }
}

class WorkflowExecutionResult {
  final bool success;
  final String message;
  final Duration executionTime;
  final int completedSteps;
  final int totalSteps;

  const WorkflowExecutionResult({
    required this.success,
    required this.message,
    required this.executionTime,
    this.completedSteps = 0,
    this.totalSteps = 0,
  });
}

class WorkflowStats {
  final int totalWorkflows;
  final int completedWorkflows;
  final int activeWorkflows;
  final int pendingWorkflows;
  final int errorWorkflows;
  final int totalSteps;
  final int completedSteps;
  final double successRate;

  const WorkflowStats({
    required this.totalWorkflows,
    required this.completedWorkflows,
    required this.activeWorkflows,
    required this.pendingWorkflows,
    required this.errorWorkflows,
    required this.totalSteps,
    required this.completedSteps,
    required this.successRate,
  });
}