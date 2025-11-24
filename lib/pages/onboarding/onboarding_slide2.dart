import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/constants.dart';
import '../../utils/animations.dart';
import '../../utils/custom_icons.dart';

class OnboardingSlide2 extends StatefulWidget {
  const OnboardingSlide2({super.key});

  @override
  State<OnboardingSlide2> createState() => _OnboardingSlide2State();
}

class _OnboardingSlide2State extends State<OnboardingSlide2> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _mainImageAnimation;
  late Animation<double> _doodle1Animation;
  late Animation<double> _doodle2Animation;
  late Animation<double> _featureAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _mainImageAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      ),
    );

    _doodle1Animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.7, curve: Curves.easeOut),
      ),
    );

    _doodle2Animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
      ),
    );

    _featureAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundDarker,
      padding: const EdgeInsets.all(AppConstants.spacingXL),
      child: Stack(
        children: [
          // Background Doodles
          Positioned(
            top: 40,
            right: 30,
            child: FadeTransition(
              opacity: _doodle1Animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, -1),
                  end: Offset.zero,
                ).animate(_doodle1Animation),
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/undraw_work-friends_g4mn.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 80,
            left: 25,
            child: FadeTransition(
              opacity: _doodle2Animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 1),
                  end: Offset.zero,
                ).animate(_doodle2Animation),
                child: Container(
                  width: 65,
                  height: 65,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/undraw_work-chat_hc3y.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Main Image
              ScaleTransition(
                scale: _mainImageAnimation,
                child: Container(
                  width: 220,
                  height: 160,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/undraw_document-analysis_3c0y.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppConstants.spacingXL),

              // Title
              const Text(
                'Smart Workflows',
                style: TextStyle(
                  fontSize: AppConstants.fontSizeXXL,
                  fontWeight: FontWeight.w800,
                  color: AppColors.neonCyan,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppConstants.spacingL),

              // Description
              const Text(
                'Automate tasks with AI-powered workflows that work anywhere, even offline. Drag and drop to create complex automations.',
                style: TextStyle(
                  fontSize: AppConstants.fontSizeL,
                  color: AppColors.textPrimary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppConstants.spacingXL),

              // Features
              FadeTransition(
                opacity: _featureAnimation,
                child: Column(
                  children: [
                    _buildFeatureItem(CustomIcons.workflow, 'Drag & Drop Builder', 'Visual workflow creation'),
                    const SizedBox(height: AppConstants.spacingM),
                    _buildFeatureItem(CustomIcons.zap, 'AI Automation', 'Smart task execution'),
                    const SizedBox(height: AppConstants.spacingM),
                    _buildFeatureItem(CustomIcons.performance, 'Real-time Monitoring', 'Track workflow progress'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingM),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha:0.3),
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        border: Border.all(color: AppColors.neonCyan.withValues(alpha:0.3)),
      ),
      child: Row(
        children: [
          Text(
            icon,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(width: AppConstants.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.neonCyan,
                    fontSize: AppConstants.fontSizeM,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
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
}