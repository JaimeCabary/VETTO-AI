import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/constants.dart';
import '../../utils/animations.dart';
import '../../utils/custom_icons.dart';

class OnboardingSlide5 extends StatefulWidget {
  const OnboardingSlide5({super.key});

  @override
  State<OnboardingSlide5> createState() => _OnboardingSlide5State();
}

class _OnboardingSlide5State extends State<OnboardingSlide5> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _mainImageAnimation;
  late Animation<double> _doodle1Animation;
  late Animation<double> _doodle2Animation;
  late Animation<double> _featureAnimation;
  late Animation<double> _glowAnimation;

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
        curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
      ),
    );

    _doodle2Animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
      ),
    );

    _featureAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    _glowAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
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
            top: 40,
            left: 30,
            child: FadeTransition(
              opacity: _doodle1Animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, -1),
                  end: Offset.zero,
                ).animate(_doodle1Animation),
                child: Container(
                  width: 65,
                  height: 65,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/undraw_join_6quk.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 80,
            right: 25,
            child: FadeTransition(
              opacity: _doodle2Animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 1),
                  end: Offset.zero,
                ).animate(_doodle2Animation),
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/undraw_online-community_3o0l.png'),
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
              // Main Image with Glow Effect
              AnimatedBuilder(
                animation: _glowAnimation,
                builder: (context, child) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.neonCyan.withValues(alpha:_glowAnimation.value * 0.5),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: ScaleTransition(
                      scale: _mainImageAnimation,
                      child: Container(
                        width: 190,
                        height: 140,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/undraw_powerful_e1sw.png'),
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
                'Ready to Begin?',
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
                'Join thousands of users building the future today. Start creating amazing workflows, websites, and AI-powered solutions.',
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
                    _buildFeatureItem(CustomIcons.rocket, 'Get Started Now', 'Begin your journey'),
                    const SizedBox(height: AppConstants.spacingM),
                    _buildFeatureItem(CustomIcons.customize, 'Customize Your Experience', 'Tailor to your needs'),
                    const SizedBox(height: AppConstants.spacingM),
                    _buildFeatureItem(CustomIcons.globe, 'Join Community', 'Connect with others'),
                  ],
                ),
              ),

              const SizedBox(height: AppConstants.spacingXL),

              // Final Glowing Element
              AnimatedBuilder(
                animation: _glowAnimation,
                builder: (context, child) {
                  return Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.neonCyan,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.neonCyan.withValues(alpha:_glowAnimation.value),
                          blurRadius: 15,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                  );
                },
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