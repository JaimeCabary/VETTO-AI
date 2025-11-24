import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/constants.dart';
import '../../utils/animations.dart';
import '../../utils/custom_icons.dart';

class OnboardingSlide3 extends StatefulWidget {
  const OnboardingSlide3({super.key});

  @override
  State<OnboardingSlide3> createState() => _OnboardingSlide3State();
}

class _OnboardingSlide3State extends State<OnboardingSlide3> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _mainImageAnimation;
  late Animation<double> _doodle1Animation;
  late Animation<double> _doodle2Animation;
  late Animation<double> _featureAnimation;
  late Animation<double> _floatingAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _mainImageAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
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

    _floatingAnimation = Tween<double>(begin: -0.1, end: 0.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundDark,
      padding: const EdgeInsets.all(AppConstants.spacingXL),
      child: Stack(
        children: [
          // Background Doodles
          Positioned(
            top: 60,
            left: 25,
            child: FadeTransition(
              opacity: _doodle1Animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(_doodle1Animation),
                child: Container(
                  width: 55,
                  height: 55,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/undraw_fill-the-blank_n29z.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 120,
            right: 30,
            child: FadeTransition(
              opacity: _doodle2Animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(_doodle2Animation),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/undraw_typing_gcve.png'),
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
              // Main Image with Floating Animation
              AnimatedBuilder(
                animation: _floatingAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _floatingAnimation.value * 20),
                    child: ScaleTransition(
                      scale: _mainImageAnimation,
                      child: Container(
                        width: 200,
                        height: 150,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/undraw_online-resume_z4sp.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: AppConstants.spacingXL),

              // Title
              const Text(
                'Instant Site Builder',
                style: TextStyle(
                  fontSize: AppConstants.fontSizeXXL,
                  fontWeight: FontWeight.w800,
                  color: AppColors.neonPurple,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppConstants.spacingL),

              // Description
              const Text(
                'Create stunning websites with our cyberpunk templates. No coding required - just drag, drop, and deploy instantly.',
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
                    _buildFeatureItem(CustomIcons.template, '50+ Templates', 'Cyberpunk designs'),
                    const SizedBox(height: AppConstants.spacingM),
                    _buildFeatureItem(CustomIcons.rocket, 'No Coding Required', 'Visual builder'),
                    const SizedBox(height: AppConstants.spacingM),
                    _buildFeatureItem(CustomIcons.globe, 'Instant Deployment', 'Go live in minutes'),
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
        border: Border.all(color: AppColors.neonPurple.withValues(alpha:0.3)),
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
                    color: AppColors.neonPurple,
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