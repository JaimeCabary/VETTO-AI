import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/constants.dart';
import '../../utils/animations.dart';
import '../../utils/custom_icons.dart';

class OnboardingSlide1 extends StatefulWidget {
  const OnboardingSlide1({super.key});

  @override
  State<OnboardingSlide1> createState() => _OnboardingSlide1State();
}

class _OnboardingSlide1State extends State<OnboardingSlide1> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _titleAnimation;
  late Animation<double> _descriptionAnimation;
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

    _titleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    _descriptionAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.5, curve: Curves.easeOut),
      ),
    );

    _mainImageAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.7, curve: Curves.elasticOut),
      ),
    );

    _doodle1Animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
      ),
    );

    _doodle2Animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.9, curve: Curves.easeOut),
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
      color: AppColors.darkOlive,
      padding: const EdgeInsets.all(AppConstants.spacingXL),
      child: Stack(
        children: [
          // Background Doodles
          Positioned(
            top: 50,
            left: 20,
            child: FadeTransition(
              opacity: _doodle1Animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(_doodle1Animation),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/undraw_around-the-world_vgcy.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 100,
            right: 20,
            child: FadeTransition(
              opacity: _doodle2Animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(_doodle2Animation),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/undraw_the-world-is-mine_wnib.png'),
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
                  width: 200,
                  height: 150,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/undraw_connected-world_anke.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppConstants.spacingXL),

              // Title
              FadeTransition(
                opacity: _titleAnimation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.5),
                    end: Offset.zero,
                  ).animate(_titleAnimation),
                  child: const Text(
                    'Welcome to Vetto AI',
                    style: TextStyle(
                      fontSize: AppConstants.fontSizeXXL,
                      fontWeight: FontWeight.w800,
                      color: AppColors.oliveGold,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              const SizedBox(height: AppConstants.spacingL),

              // Description
              FadeTransition(
                opacity: _descriptionAnimation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.3),
                    end: Offset.zero,
                  ).animate(_descriptionAnimation),
                  child: const Text(
                    'Your offline-first AI ecosystem for global productivity. Built for areas with limited connectivity.',
                    style: TextStyle(
                      fontSize: AppConstants.fontSizeL,
                      color: AppColors.textPrimary,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              const SizedBox(height: AppConstants.spacingXL),

              // Features
              FadeTransition(
                opacity: _featureAnimation,
                child: Column(
                  children: [
                    _buildFeatureItem(CustomIcons.brain, 'Fully Offline AI', 'Works without internet'),
                    const SizedBox(height: AppConstants.spacingM),
                    _buildFeatureItem(CustomIcons.rocket, 'Cyberpunk Design', 'Futuristic interface'),
                    const SizedBox(height: AppConstants.spacingM),
                    _buildFeatureItem(CustomIcons.globe, 'Global Accessibility', 'Built for everyone'),
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
        color: AppColors.backgroundDark.withValues(alpha:0.3),
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        border: Border.all(color: AppColors.oliveGold.withValues(alpha:0.3)),
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
                    color: AppColors.oliveGold,
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