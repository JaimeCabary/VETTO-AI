import 'package:flutter/material.dart';
import 'package:vetto_ai/pages/site_builder_page.dart';
import '../config/app_colors.dart';
import '../config/constants.dart';

class TemplateCard extends StatelessWidget {
  final WebsiteTemplate template;
  final VoidCallback onTap;
  final VoidCallback onUseTemplate;

  const TemplateCard({
    super.key,
    required this.template,
    required this.onTap,
    required this.onUseTemplate,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: AppColors.cardGradient,
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
          boxShadow: AppColors.neonGlow(
            template.isPremium ? AppColors.oliveGold : AppColors.neonPurple,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Preview Image
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(AppConstants.spacingM),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.neonCyan.withValues(alpha:0.3),
                      AppColors.neonPurple.withValues(alpha:0.3),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    const Center(
                      child: Icon(
                        Icons.dashboard,
                        size: 40,
                        color: AppColors.neonCyan,
                      ),
                    ),
                    if (template.isPremium)
                      Positioned(
                        top: AppConstants.spacingS,
                        right: AppConstants.spacingS,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppConstants.spacingS,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppColors.oliveGold, AppColors.oliveGold.withValues(alpha:0.7)],
                            ),
                            borderRadius: BorderRadius.circular(AppConstants.borderRadiusS),
                          ),
                          child: const Text(
                            'PRO',
                            style: TextStyle(
                              color: AppColors.backgroundDark,
                              fontSize: AppConstants.fontSizeXS,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Template Info
            Padding(
              padding: const EdgeInsets.all(AppConstants.spacingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          template.title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: AppColors.oliveGold,
                            size: AppConstants.iconSizeS,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            template.rating.toString(),
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: AppConstants.fontSizeS,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.spacingXS),
                  Text(
                    template.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textTertiary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppConstants.spacingM),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.spacingS,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.neonPurple.withValues(alpha:0.2),
                          borderRadius: BorderRadius.circular(AppConstants.borderRadiusS),
                          border: Border.all(color: AppColors.neonPurple),
                        ),
                        child: Text(
                          template.category,
                          style: const TextStyle(
                            color: AppColors.neonPurple,
                            fontSize: AppConstants.fontSizeXS,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${template.uses} uses',
                        style: const TextStyle(
                          color: AppColors.textTertiary,
                          fontSize: AppConstants.fontSizeXS,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.spacingM),
                  SizedBox(
                    width: double.infinity,
                    height: 36,
                    child: ElevatedButton(
                      onPressed: onUseTemplate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: template.isPremium 
                            ? AppColors.oliveGold 
                            : AppColors.neonCyan,
                        foregroundColor: AppColors.backgroundDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        template.isPremium ? 'Use Pro' : 'Use Template',
                        style: const TextStyle(
                          fontSize: AppConstants.fontSizeS,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}