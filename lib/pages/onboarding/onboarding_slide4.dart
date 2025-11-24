import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/constants.dart';
import '../../utils/animations.dart';
import '../../utils/custom_icons.dart';

class OnboardingSlide4 extends StatefulWidget {
  const OnboardingSlide4({super.key});

  @override
  State<OnboardingSlide4> createState() => _OnboardingSlide4State();
}

class _OnboardingSlide4State extends State<OnboardingSlide4> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _mainImageAnimation;
  late Animation<double> _doodle1Animation;
  late Animation<double> _doodle2Animation;
  late Animation<double> _featureAnimation;
  late Animation<double> _pulseAnimation;

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

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
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
      color: AppColors.cardBackground,
      padding: const EdgeInsets.all(AppConstants.spacingXL),
      child: Stack(
        children: [
          // Background Doodles
          Positioned(
            top: 50,
            right: 25,
            child: FadeTransition(
              opacity: _doodle1Animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, -1),
                  end: Offset.zero,
                ).animate(_doodle1Animation),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/undraw_chat-with-ai_ir62.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 100,
            left: 20,
            child: FadeTransition(
              opacity: _doodle2Animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 1),
                  end: Offset.zero,
                ).animate(_doodle2Animation),
                child: Container(
                  width: 55,
                  height: 55,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/undraw_messages_okui.png'),
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
              // Main Image with Pulse Animation
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _pulseAnimation.value,
                    child: ScaleTransition(
                      scale: _mainImageAnimation,
                      child: Container(
                        width: 180,
                        height: 140,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/undraw_voice-assistant_k27k.png'),
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
                'AI Assistant',
                style: TextStyle(
                  fontSize: AppConstants.fontSizeXXL,
                  fontWeight: FontWeight.w800,
                  color: AppColors.neonGreen,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppConstants.spacingL),

              // Description
              const Text(
                'Your personal AI companion, always ready to help. Get instant answers, automate tasks, and boost your productivity.',
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
                    _buildFeatureItem(CustomIcons.chat, '24/7 Available', 'Always ready to help'),
                    const SizedBox(height: AppConstants.spacingM),
                    _buildFeatureItem(CustomIcons.brain, 'Context Aware', 'Understands your needs'),
                    const SizedBox(height: AppConstants.spacingM),
                    _buildFeatureItem(CustomIcons.globe, 'Multi-language', 'Speaks your language'),
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
        border: Border.all(color: AppColors.neonGreen.withValues(alpha:0.3)),
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
                    color: AppColors.neonGreen,
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