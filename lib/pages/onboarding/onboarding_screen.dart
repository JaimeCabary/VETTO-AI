import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/constants.dart';
import '../../models/onboarding_slide.dart';
import '../../utils/custom_icons.dart';
import '../../widgets/animated_button.dart';
import '../../widgets/page_indicators.dart';
import 'onboarding_slide1.dart';
import 'onboarding_slide2.dart';
import 'onboarding_slide3.dart';
import 'onboarding_slide4.dart';
import 'onboarding_slide5.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  final List<OnboardingSlide> _slides = [];
  int _currentPage = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _loadSlides();
    _animationController.forward();
  }

  void _loadSlides() {
    _slides.addAll([
      const OnboardingSlide(
        id: '1',
        title: 'Welcome to Vetto AI',
        description: 'Your offline-first AI ecosystem for global productivity',
        mainImage: 'assets/images/undraw_connected-world_anke.svg',
        doodleImages: [
          'assets/images/undraw_around-the-world_vgcy.svg',
          'assets/images/undraw_the-world-is-mine_wnib.svg',
        ],
        backgroundColor: AppColors.darkOlive,
        textColor: AppColors.oliveGold,
        features: ['Fully Offline AI', 'Cyberpunk Design', 'Global Accessibility'],
      ),
      const OnboardingSlide(
        id: '2',
        title: 'Smart Workflows',
        description: 'Automate tasks with AI-powered workflows that work anywhere',
        mainImage: 'assets/images/undraw_document-analysis_3c0y.svg',
        doodleImages: [
          'assets/images/undraw_work-friends_g4mn.svg',
          'assets/images/undraw_work-chat_hc3y.svg',
        ],
        backgroundColor: AppColors.backgroundDarker,
        textColor: AppColors.neonCyan,
        features: ['Drag & Drop Builder', 'AI Automation', 'Real-time Monitoring'],
      ),
      const OnboardingSlide(
        id: '3',
        title: 'Instant Site Builder',
        description: 'Create stunning websites with our cyberpunk templates',
        mainImage: 'assets/images/undraw_online-resume_z4sp.svg',
        doodleImages: [
          'assets/images/undraw_fill-the-blank_n29z.svg',
          'assets/images/undraw_typing_gcve.svg',
        ],
        backgroundColor: AppColors.backgroundDark,
        textColor: AppColors.neonPurple,
        features: ['50+ Templates', 'No Coding Required', 'Instant Deployment'],
      ),
      const OnboardingSlide(
        id: '4',
        title: 'AI Assistant',
        description: 'Your personal AI companion, always ready to help',
        mainImage: 'assets/images/undraw_voice-assistant_k27k.svg',
        doodleImages: [
          'assets/images/undraw_chat-with-ai_ir62.svg',
          'assets/images/undraw_messages_okui.svg',
        ],
        backgroundColor: AppColors.cardBackground,
        textColor: AppColors.neonGreen,
        features: ['24/7 Available', 'Context Aware', 'Multi-language'],
      ),
      const OnboardingSlide(
        id: '5',
        title: 'Ready to Begin?',
        description: 'Join thousands of users building the future today',
        mainImage: 'assets/images/undraw_powerful_e1sw.svg',
        doodleImages: [
          'assets/images/undraw_join_6quk.svg',
          'assets/images/undraw_online-community_3o0l.svg',
        ],
        backgroundColor: AppColors.backgroundDark,
        textColor: AppColors.neonCyan,
        features: ['Get Started Now', 'Customize Your Experience', 'Join Community'],
      ),
    ]);
  }

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _completeOnboarding() {
    Navigator.pushReplacementNamed(context, '/profile');
  }

  void _skipOnboarding() {
    _completeOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _slides.isEmpty ? AppColors.backgroundDark : _slides[_currentPage].backgroundColor,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _fadeAnimation,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  // Skip Button
                  if (_currentPage < _slides.length - 1)
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(AppConstants.spacingL),
                        child: TextButton(
                          onPressed: _skipOnboarding,
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              color: _slides[_currentPage].textColor,
                              fontSize: AppConstants.fontSizeM,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),

                  // Page View
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: const [
                        OnboardingSlide1(),
                        OnboardingSlide2(),
                        OnboardingSlide3(),
                        OnboardingSlide4(),
                        OnboardingSlide5(),
                      ],
                    ),
                  ),

                  // Bottom Section
                  Container(
                    padding: const EdgeInsets.all(AppConstants.spacingXL),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          _slides.isEmpty ? AppColors.backgroundDark : _slides[_currentPage].backgroundColor.withValues(alpha:0.9),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        // Page Indicators
                        PageIndicators(
                          currentPage: _currentPage,
                          totalPages: _slides.length,
                          activeColor: _slides.isEmpty ? AppColors.neonCyan : _slides[_currentPage].textColor,
                          inactiveColor: AppColors.textTertiary,
                        ),

                        const SizedBox(height: AppConstants.spacingXL),

                        // Navigation Buttons
                        Row(
                          children: [
                            if (_currentPage > 0)
                              Expanded(
                                child: TextButton(
                                  onPressed: _previousPage,
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingM),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
                                      side: BorderSide(color: _slides[_currentPage].textColor),
                                    ),
                                  ),
                                  child: Text(
                                    'Back',
                                    style: TextStyle(
                                      color: _slides[_currentPage].textColor,
                                      fontSize: AppConstants.fontSizeM,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            if (_currentPage > 0) const SizedBox(width: AppConstants.spacingM),
                            Expanded(
                              flex: _currentPage > 0 ? 1 : 2,
                              child: AnimatedButton(
                                text: _currentPage == _slides.length - 1 ? 'Get Started' : 'Next',
                                onPressed: _nextPage,
                                type: ButtonType.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}