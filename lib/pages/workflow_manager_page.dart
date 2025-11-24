import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../config/constants.dart';
import '../models/workflow.dart';
import '../widgets/animated_button.dart';
import '../widgets/workflow_card.dart';

class WorkflowManagerPage extends StatefulWidget {
  const WorkflowManagerPage({super.key});

  @override
  State<WorkflowManagerPage> createState() => _WorkflowManagerPageState();
}

class _WorkflowManagerPageState extends State<WorkflowManagerPage> {
  final List<Workflow> _workflows = [];
  final List<Workflow> _filteredWorkflows = [];
  String _currentFilter = 'All';
  bool _isLoading = true;

  final List<String> _filters = ['All', 'Active', 'Completed', 'Pending', 'Error'];

  @override
  void initState() {
    super.initState();
    _loadWorkflows();
  }

  void _loadWorkflows() {
    // Simulate loading delay
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _workflows.addAll(_getMockWorkflows());
        _filteredWorkflows.addAll(_workflows);
        _isLoading = false;
      });
    });
  }

  List<Workflow> _getMockWorkflows() {
    return [
      Workflow(
        id: '1',
        title: 'Data Processing Pipeline',
        description: 'Automated data cleaning and transformation workflow',
        status: WorkflowStatus.active,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        progress: 75,
        steps: [
          WorkflowStep(id: '1-1', title: 'Data Collection', description: 'Gather data from sources', isCompleted: true),
          WorkflowStep(id: '1-2', title: 'Data Cleaning', description: 'Remove duplicates and errors', isCompleted: true),
          WorkflowStep(id: '1-3', title: 'Transformation', description: 'Convert data formats', isCompleted: false),
          WorkflowStep(id: '1-4', title: 'Export Results', description: 'Save processed data', isCompleted: false),
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
          WorkflowStep(id: '2-1', title: 'Data Aggregation', description: 'Collect daily metrics', isCompleted: true),
          WorkflowStep(id: '2-2', title: 'Report Generation', description: 'Create PDF report', isCompleted: true),
          WorkflowStep(id: '2-3', title: 'Distribution', description: 'Send to stakeholders', isCompleted: true),
        ],
      ),
      Workflow(
        id: '3',
        title: 'AI Model Training',
        description: 'Train machine learning model on new dataset',
        status: WorkflowStatus.pending,
        createdAt: DateTime.now().subtract(const Duration(hours: 6)),
        progress: 0,
        steps: [
          WorkflowStep(id: '3-1', title: 'Data Preparation', description: 'Prepare training data', isCompleted: false),
          WorkflowStep(id: '3-2', title: 'Model Configuration', description: 'Set up model parameters', isCompleted: false),
          WorkflowStep(id: '3-3', title: 'Training', description: 'Train model on data', isCompleted: false),
          WorkflowStep(id: '3-4', title: 'Validation', description: 'Test model performance', isCompleted: false),
        ],
      ),
      Workflow(
        id: '4',
        title: 'Backup System',
        description: 'Automated cloud backup process',
        status: WorkflowStatus.error,
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
        progress: 40,
        steps: [
          WorkflowStep(id: '4-1', title: 'File Collection', description: 'Gather files for backup', isCompleted: true),
          WorkflowStep(id: '4-2', title: 'Compression', description: 'Compress backup files', isCompleted: true),
          WorkflowStep(id: '4-3', title: 'Upload', description: 'Upload to cloud storage', isCompleted: false),
        ],
      ),
      Workflow(
        id: '5',
        title: 'Email Campaign',
        description: 'Send marketing emails to subscriber list',
        status: WorkflowStatus.active,
        createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
        progress: 25,
        steps: [
          WorkflowStep(id: '5-1', title: 'List Segmentation', description: 'Segment email lists', isCompleted: true),
          WorkflowStep(id: '5-2', title: 'Content Preparation', description: 'Prepare email content', isCompleted: false),
          WorkflowStep(id: '5-3', title: 'Send Emails', description: 'Execute email campaign', isCompleted: false),
          WorkflowStep(id: '5-4', title: 'Analytics', description: 'Track campaign performance', isCompleted: false),
        ],
      ),
    ];
  }

  void _filterWorkflows(String filter) {
    setState(() {
      _currentFilter = filter;
      if (filter == 'All') {
        _filteredWorkflows.clear();
        _filteredWorkflows.addAll(_workflows);
      } else {
        _filteredWorkflows.clear();
        _filteredWorkflows.addAll(_workflows.where((workflow) {
          return workflow.status.toString().split('.').last.toLowerCase() == filter.toLowerCase();
        }).toList());
      }
    });
  }

  void _createNewWorkflow() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _buildCreateWorkflowSheet(),
    );
  }

  void _deleteWorkflow(String workflowId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        ),
        title: const Text(
          'Delete Workflow?',
          style: TextStyle(
            color: AppColors.error,
            fontSize: AppConstants.fontSizeXL,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: const Text(
          'This action cannot be undone. The workflow will be permanently deleted.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: AppConstants.fontSizeM,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: AppColors.textTertiary,
                fontSize: AppConstants.fontSizeM,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha:0.8),
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
            ),
            child: TextButton(
              onPressed: () {
                setState(() {
                  _workflows.removeWhere((workflow) => workflow.id == workflowId);
                  _filterWorkflows(_currentFilter);
                });
                Navigator.pop(context);
              },
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: AppConstants.fontSizeM,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingL,
                vertical: AppConstants.spacingM,
              ),
              decoration: BoxDecoration(
                color: AppColors.backgroundDarker,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha:0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Text(
                    'Workflows',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: AppColors.neonCyan,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: AppColors.neonCyan,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.filter_list,
                      color: AppColors.neonCyan,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Filter Chips
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingL,
                vertical: AppConstants.spacingM,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _filters.map((filter) {
                    final isSelected = _currentFilter == filter;
                    return Container(
                      margin: const EdgeInsets.only(right: AppConstants.spacingS),
                      child: FilterChip(
                        label: Text(
                          filter,
                          style: TextStyle(
                            color: isSelected ? AppColors.backgroundDark : AppColors.textPrimary,
                            fontSize: AppConstants.fontSizeS,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        selected: isSelected,
                        onSelected: (selected) => _filterWorkflows(filter),
                        backgroundColor: AppColors.surface,
                        selectedColor: AppColors.neonCyan,
                        checkmarkColor: AppColors.backgroundDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            // Workflows List
            Expanded(
              child: _isLoading
                  ? _buildLoadingState()
                  : _filteredWorkflows.isEmpty
                      ? _buildEmptyState()
                      : _buildWorkflowsList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewWorkflow,
        backgroundColor: AppColors.neonCyan,
        foregroundColor: AppColors.backgroundDark,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation(AppColors.neonCyan),
            ),
          ),
          const SizedBox(height: AppConstants.spacingL),
          Text(
            'Loading Workflows...',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.work_outline,
            size: 80,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: AppConstants.spacingL),
          Text(
            'No Workflows Found',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppConstants.spacingM),
          Text(
            _currentFilter == 'All'
                ? 'Create your first workflow to get started'
                : 'No $_currentFilter.toLowerCase() workflows found',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textTertiary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.spacingXL),
          AnimatedButton(
            text: 'Create Workflow',
            onPressed: _createNewWorkflow,
            width: 200,
          ),
        ],
      ),
    );
  }

  Widget _buildWorkflowsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.spacingL),
      itemCount: _filteredWorkflows.length,
      itemBuilder: (context, index) {
        final workflow = _filteredWorkflows[index];
        return WorkflowCard(
          workflow: workflow,
          onTap: () => _showWorkflowDetails(workflow),
          onLongPress: () => _showWorkflowActions(workflow),
        );
      },
    );
  }

  Widget _buildCreateWorkflowSheet() {
    return Container(
      margin: const EdgeInsets.all(AppConstants.spacingL),
      padding: const EdgeInsets.all(AppConstants.spacingL),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        boxShadow: AppColors.neonGlow(AppColors.neonCyan),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create New Workflow',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.neonCyan,
            ),
          ),
          const SizedBox(height: AppConstants.spacingL),
          TextField(
            decoration: InputDecoration(
              labelText: 'Workflow Name',
              labelStyle: const TextStyle(color: AppColors.textSecondary),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                borderSide: const BorderSide(color: AppColors.surface),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                borderSide: const BorderSide(color: AppColors.neonCyan),
              ),
            ),
            style: const TextStyle(color: AppColors.textPrimary),
          ),
          const SizedBox(height: AppConstants.spacingM),
          TextField(
            decoration: InputDecoration(
              labelText: 'Description',
              labelStyle: const TextStyle(color: AppColors.textSecondary),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                borderSide: const BorderSide(color: AppColors.surface),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                borderSide: const BorderSide(color: AppColors.neonCyan),
              ),
            ),
            maxLines: 3,
            style: const TextStyle(color: AppColors.textPrimary),
          ),
          const SizedBox(height: AppConstants.spacingL),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingM),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
                      side: const BorderSide(color: AppColors.textTertiary),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: AppColors.textTertiary,
                      fontSize: AppConstants.fontSizeM,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.spacingM),
              Expanded(
                child: AnimatedButton(
                  text: 'Create',
                  onPressed: () {
                    // Create workflow logic
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showWorkflowDetails(Workflow workflow) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        ),
        title: Text(
          workflow.title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: AppConstants.fontSizeXL,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              workflow.description,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: AppConstants.fontSizeM,
              ),
            ),
            const SizedBox(height: AppConstants.spacingL),
            ...workflow.steps.map((step) => _buildStepRow(step)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Close',
              style: TextStyle(
                color: AppColors.textTertiary,
                fontSize: AppConstants.fontSizeM,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepRow(WorkflowStep step) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingS),
      child: Row(
        children: [
          Icon(
            step.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
            color: step.isCompleted ? AppColors.neonGreen : AppColors.textTertiary,
            size: AppConstants.iconSizeM,
          ),
          const SizedBox(width: AppConstants.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: AppConstants.fontSizeM,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  step.description,
                  style: const TextStyle(
                    color: AppColors.textTertiary,
                    fontSize: AppConstants.fontSizeS,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showWorkflowActions(Workflow workflow) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: const EdgeInsets.all(AppConstants.spacingL),
        padding: const EdgeInsets.all(AppConstants.spacingL),
        decoration: BoxDecoration(
          gradient: AppColors.cardGradient,
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
          boxShadow: AppColors.neonGlow(AppColors.neonPurple),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.play_arrow, color: AppColors.neonGreen),
              title: const Text('Start Workflow', style: TextStyle(color: AppColors.textPrimary)),
              onTap: () {
                Navigator.pop(context);
                // Start workflow logic
              },
            ),
            ListTile(
              leading: const Icon(Icons.pause, color: AppColors.oliveGold),
              title: const Text('Pause Workflow', style: TextStyle(color: AppColors.textPrimary)),
              onTap: () {
                Navigator.pop(context);
                // Pause workflow logic
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit, color: AppColors.neonCyan),
              title: const Text('Edit Workflow', style: TextStyle(color: AppColors.textPrimary)),
              onTap: () {
                Navigator.pop(context);
                // Edit workflow logic
              },
            ),
            const Divider(color: AppColors.surface),
            ListTile(
              leading: const Icon(Icons.delete, color: AppColors.error),
              title: const Text('Delete Workflow', style: TextStyle(color: AppColors.error)),
              onTap: () {
                Navigator.pop(context);
                _deleteWorkflow(workflow.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}