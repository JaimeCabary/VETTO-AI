import 'package:flutter/material.dart';
import 'package:vetto_ai/config/app_colors.dart';
import 'package:vetto_ai/config/constants.dart';
import 'package:vetto_ai/models/user.dart';
import 'package:vetto_ai/utils/animations.dart';
import 'package:vetto_ai/widgets/animated_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> 
    with SingleTickerProviderStateMixin {
  late User _user;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  
  @override
  void initState() {
    super.initState();
    _user = _getMockUser();
    _animationController = AnimationController(
      duration: AppAnimations.slow,
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _slideAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));
    
    _animationController.forward();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  User _getMockUser() {
    return User(
      id: '1',
      name: 'Alex Chen',
      email: 'alex.chen@vetto.ai',
      isOnline: true,
      lastActive: DateTime.now(),
      stats: const UserStats(
        workflowCompletions: 42,
        aiSuggestions: 128,
        activeTasks: 7,
        templatesCreated: 15,
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _slideAnimation.value),
              child: Opacity(
                opacity: _fadeAnimation.value,
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: AppConstants.paddingPage,
                        child: Column(
                          children: [
                            _buildProfileHeader(),
                            const SizedBox(height: AppConstants.spacingXL),
                            _buildStatsGrid(),
                            const SizedBox(height: AppConstants.spacingXL),
                            _buildRecentActivity(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  
  Widget _buildProfileHeader() {
    return Container(
      padding: AppConstants.paddingCard,
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        // boxShadow: AppColors.neonGlow(AppColors.neonCyan),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.primaryGradient,
                  // boxShadow: AppColors.neonGlow(AppColors.neonCyan),
                ),
                child: const Icon(
                  Icons.person,
                  size: AppConstants.iconSizeXL,
                  color: AppColors.backgroundDark,
                ),
              ),
              // Online status indicator
              Positioned(
                bottom: 4,
                right: 4,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: _user.isOnline 
                        ? AppColors.neonGreen 
                        : AppColors.textTertiary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.backgroundDark,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: AppConstants.spacingL),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _user.name,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: AppConstants.spacingXS),
                Text(
                  _user.email,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppConstants.spacingM),
                AnimatedButton(
                  text: 'Edit Profile',
                  onPressed: () {},
                  type: ButtonType.secondary,
                  width: 160,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatsGrid() {
  const stats = [
    {'label': 'Workflows', 'value': '42', 'color': AppColors.neonCyan},
    {'label': 'AI Suggestions', 'value': '128', 'color': AppColors.neonPurple},
    {'label': 'Active Tasks', 'value': '7', 'color': AppColors.oliveGold},
    {'label': 'Templates', 'value': '15', 'color': AppColors.neonGreen},
  ];

  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: AppConstants.spacingM,
      mainAxisSpacing: AppConstants.spacingM,
      childAspectRatio: 1.2,
    ),
    itemCount: stats.length,
    itemBuilder: (context, index) {
      final stat = stats[index];
      return HoverAnimationBuilder(
        child: Container(
          padding: AppConstants.paddingCard,
          decoration: BoxDecoration(
            gradient: AppColors.cardGradient,
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
            
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                stat['value']!.toString(), // <-- cast to String
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: stat['color'] as Color,
                    ),
              ),
              const SizedBox(height: AppConstants.spacingS),
              Text(
                stat['label']!.toString(), // <-- cast to String
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildRecentActivity() {
  final activities = [
    {'action': 'Workflow completed', 'time': '2 min ago', 'icon': Icons.verified_user},
    {'action': 'AI suggestion received', 'time': '15 min ago', 'icon': Icons.auto_awesome},
    {'action': 'Template created', 'time': '1 hour ago', 'icon': Icons.dashboard},
    {'action': 'Chat session started', 'time': '3 hours ago', 'icon': Icons.chat},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Recent Activity',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      const SizedBox(height: AppConstants.spacingL),
      ...activities.map((activity) {
        return Container(
          margin: const EdgeInsets.only(bottom: AppConstants.spacingM),
          padding: AppConstants.paddingCard,
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.neonCyan.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                ),
                child: Icon(
                  activity['icon'] as IconData,
                  color: AppColors.neonCyan,
                  size: AppConstants.iconSizeM,
                ),
              ),
              const SizedBox(width: AppConstants.spacingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity['action']!.toString(), // <-- cast to String
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: AppConstants.spacingXS),
                    Text(
                      activity['time']!.toString(), // <-- cast to String
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.textTertiary),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    ],
  );
}
}