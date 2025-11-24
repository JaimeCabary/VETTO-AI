import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../config/constants.dart';
import '../widgets/animated_button.dart';
import '../widgets/template_card.dart';

class SiteBuilderPage extends StatefulWidget {
  const SiteBuilderPage({super.key});

  @override
  State<SiteBuilderPage> createState() => _SiteBuilderPageState();
}

class _SiteBuilderPageState extends State<SiteBuilderPage> {
  final List<WebsiteTemplate> _templates = [];
  final List<WebsiteTemplate> _filteredTemplates = [];
  String _currentCategory = 'All';
  bool _isLoading = true;

  final List<String> _categories = ['All', 'Business', 'Portfolio', 'E-commerce', 'Blog', 'Landing Page'];

  @override
  void initState() {
    super.initState();
    _loadTemplates();
  }

  void _loadTemplates() {
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        _templates.addAll(_getMockTemplates());
        _filteredTemplates.addAll(_templates);
        _isLoading = false;
      });
    });
  }

  List<WebsiteTemplate> _getMockTemplates() {
    return [
      WebsiteTemplate(
        id: '1',
        title: 'Neon Portfolio',
        description: 'Modern portfolio with cyberpunk aesthetics',
        category: 'Portfolio',
        previewImage: 'assets/images/templates/portfolio1.jpg',
        isPremium: false,
        rating: 4.8,
        uses: 1247,
      ),
      WebsiteTemplate(
        id: '2',
        title: 'Cyber Business',
        description: 'Professional business website with futuristic design',
        category: 'Business',
        previewImage: 'assets/images/templates/business1.jpg',
        isPremium: true,
        rating: 4.9,
        uses: 892,
      ),
      WebsiteTemplate(
        id: '3',
        title: 'Digital Store',
        description: 'E-commerce template with glowing elements',
        category: 'E-commerce',
        previewImage: 'assets/images/templates/ecommerce1.jpg',
        isPremium: true,
        rating: 4.7,
        uses: 1563,
      ),
      WebsiteTemplate(
        id: '4',
        title: 'Tech Blog',
        description: 'Blog template optimized for tech content',
        category: 'Blog',
        previewImage: 'assets/images/templates/blog1.jpg',
        isPremium: false,
        rating: 4.5,
        uses: 734,
      ),
      WebsiteTemplate(
        id: '5',
        title: 'Startup Launch',
        description: 'Landing page for startups and products',
        category: 'Landing Page',
        previewImage: 'assets/images/templates/landing1.jpg',
        isPremium: false,
        rating: 4.6,
        uses: 1023,
      ),
      WebsiteTemplate(
        id: '6',
        title: 'Agency Pro',
        description: 'Premium agency website with animations',
        category: 'Business',
        previewImage: 'assets/images/templates/agency1.jpg',
        isPremium: true,
        rating: 5.0,
        uses: 567,
      ),
    ];
  }

  void _filterTemplates(String category) {
    setState(() {
      _currentCategory = category;
      if (category == 'All') {
        _filteredTemplates.clear();
        _filteredTemplates.addAll(_templates);
      } else {
        _filteredTemplates.clear();
        _filteredTemplates.addAll(_templates.where((template) => template.category == category).toList());
      }
    });
  }

  void _createNewSite() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _buildCreateSiteSheet(),
    );
  }

  void _previewTemplate(WebsiteTemplate template) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TemplatePreviewPage(template: template),
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
                    'Site Builder',
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
                    onPressed: _showSearchDialog,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.dashboard,
                      color: AppColors.neonCyan,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Category Filter
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingL,
                vertical: AppConstants.spacingM,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _categories.map((category) {
                    final isSelected = _currentCategory == category;
                    return Container(
                      margin: const EdgeInsets.only(right: AppConstants.spacingS),
                      child: FilterChip(
                        label: Text(
                          category,
                          style: TextStyle(
                            color: isSelected ? AppColors.backgroundDark : AppColors.textPrimary,
                            fontSize: AppConstants.fontSizeS,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        selected: isSelected,
                        onSelected: (selected) => _filterTemplates(category),
                        backgroundColor: AppColors.surface,
                        selectedColor: AppColors.neonPurple,
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

            // Templates Grid
            Expanded(
              child: _isLoading
                  ? _buildLoadingState()
                  : _filteredTemplates.isEmpty
                      ? _buildEmptyState()
                      : _buildTemplatesGrid(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewSite,
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
            'Loading Templates...',
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
            Icons.dashboard_outlined,
            size: 80,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: AppConstants.spacingL),
          Text(
            'No Templates Found',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppConstants.spacingM),
          Text(
            'Try selecting a different category',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textTertiary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTemplatesGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(AppConstants.spacingL),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppConstants.spacingL,
        mainAxisSpacing: AppConstants.spacingL,
        childAspectRatio: 0.8,
      ),
      itemCount: _filteredTemplates.length,
      itemBuilder: (context, index) {
        final template = _filteredTemplates[index];
        return TemplateCard(
          template: template,
          onTap: () => _previewTemplate(template),
          onUseTemplate: () => _useTemplate(template),
        );
      },
    );
  }

  Widget _buildCreateSiteSheet() {
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
            'Create New Site',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.neonCyan,
            ),
          ),
          const SizedBox(height: AppConstants.spacingL),
          TextField(
            decoration: InputDecoration(
              labelText: 'Site Name',
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
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Template Category',
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
            initialValue: 'Business',
            items: _categories.where((cat) => cat != 'All').map((category) {
              return DropdownMenuItem(
                value: category,
                child: Text(
                  category,
                  style: const TextStyle(color: AppColors.textPrimary),
                ),
              );
            }).toList(),
            onChanged: (value) {},
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
                  text: 'Create Site',
                  onPressed: () {
                    // Create site logic
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

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        ),
        title: const Text(
          'Search Templates',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: AppConstants.fontSizeXL,
          ),
        ),
        content: TextField(
          decoration: InputDecoration(
            hintText: 'Enter template name...',
            hintStyle: const TextStyle(color: AppColors.textTertiary),
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
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.textTertiary),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
            ),
            child: TextButton(
              onPressed: () {
                // Search logic
                Navigator.pop(context);
              },
              child: const Text(
                'Search',
                style: TextStyle(
                  color: AppColors.backgroundDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _useTemplate(WebsiteTemplate template) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        ),
        title: const Text(
          'Use Template?',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: AppConstants.fontSizeXL,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create a new site using "${template.title}" template?',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: AppConstants.fontSizeM,
              ),
            ),
            if (template.isPremium) ...[
              const SizedBox(height: AppConstants.spacingM),
              Container(
                padding: const EdgeInsets.all(AppConstants.spacingM),
                decoration: BoxDecoration(
                  color: AppColors.oliveGold.withValues(alpha:0.2),
                  borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                  border: Border.all(color: AppColors.oliveGold),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.star, color: AppColors.oliveGold, size: 16),
                    SizedBox(width: AppConstants.spacingS),
                    Text(
                      'Premium Template',
                      style: TextStyle(
                        color: AppColors.oliveGold,
                        fontSize: AppConstants.fontSizeS,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.textTertiary),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: template.isPremium 
                  ? LinearGradient(
                      colors: [AppColors.oliveGold, AppColors.oliveGold.withValues(alpha:0.8)],
                    )
                  : AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                _createSiteFromTemplate(template);
              },
              child: Text(
                template.isPremium ? 'Use Premium' : 'Use Template',
                style: const TextStyle(
                  color: AppColors.backgroundDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _createSiteFromTemplate(WebsiteTemplate template) {
    // Implementation for creating site from template
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.neonGreen,
        content: Text(
          'Site created from "${template.title}"!',
          style: const TextStyle(color: AppColors.backgroundDark),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class TemplatePreviewPage extends StatelessWidget {
  final WebsiteTemplate template;

  const TemplatePreviewPage({super.key, required this.template});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          template.title,
          style: const TextStyle(color: AppColors.neonCyan),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
            color: AppColors.textPrimary,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Template Preview Image
            Container(
              height: 300,
              margin: const EdgeInsets.all(AppConstants.spacingL),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.neonCyan.withValues(alpha:0.3), AppColors.neonPurple.withValues(alpha:0.3)],
                ),
                boxShadow: AppColors.neonGlow(AppColors.neonCyan),
              ),
              child: const Center(
                child: Icon(
                  Icons.dashboard,
                  size: 80,
                  color: AppColors.neonCyan,
                ),
              ),
            ),

            // Template Details
            Container(
              margin: const EdgeInsets.all(AppConstants.spacingL),
              padding: const EdgeInsets.all(AppConstants.spacingL),
              decoration: BoxDecoration(
                gradient: AppColors.cardGradient,
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          template.title,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      if (template.isPremium)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppConstants.spacingM,
                            vertical: AppConstants.spacingXS,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppColors.oliveGold, AppColors.oliveGold.withValues(alpha:0.7)],
                            ),
                            borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                          ),
                          child: const Text(
                            'PREMIUM',
                            style: TextStyle(
                              color: AppColors.backgroundDark,
                              fontSize: AppConstants.fontSizeXS,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.spacingM),
                  Text(
                    template.description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingL),
                  Row(
                    children: [
                      _buildDetailItem(Icons.category, template.category),
                      const SizedBox(width: AppConstants.spacingL),
                      _buildDetailItem(Icons.star, '${template.rating}'),
                      const SizedBox(width: AppConstants.spacingL),
                      _buildDetailItem(Icons.people, '${template.uses} uses'),
                    ],
                  ),
                ],
              ),
            ),

            // Features
            Container(
              margin: const EdgeInsets.all(AppConstants.spacingL),
              padding: const EdgeInsets.all(AppConstants.spacingL),
              decoration: BoxDecoration(
                gradient: AppColors.cardGradient,
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Features',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.neonCyan,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingM),
                  _buildFeatureItem('Responsive Design'),
                  _buildFeatureItem('Dark Mode Support'),
                  _buildFeatureItem('Fast Loading'),
                  _buildFeatureItem('SEO Optimized'),
                  _buildFeatureItem('Easy Customization'),
                ],
              ),
            ),

            // Action Button
            Container(
              margin: const EdgeInsets.all(AppConstants.spacingL),
              child: AnimatedButton(
                text: template.isPremium ? 'Use Premium Template' : 'Use This Template',
                onPressed: () {
                  Navigator.pop(context);
                  // Use template logic
                },
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.neonCyan, size: AppConstants.iconSizeS),
        const SizedBox(width: AppConstants.spacingXS),
        Text(
          text,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: AppConstants.fontSizeS,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingS),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: AppColors.neonGreen,
            size: AppConstants.iconSizeS,
          ),
          const SizedBox(width: AppConstants.spacingM),
          Text(
            feature,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: AppConstants.fontSizeM,
            ),
          ),
        ],
      ),
    );
  }
}

class WebsiteTemplate {
  final String id;
  final String title;
  final String description;
  final String category;
  final String previewImage;
  final bool isPremium;
  final double rating;
  final int uses;

  WebsiteTemplate({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.previewImage,
    required this.isPremium,
    required this.rating,
    required this.uses,
  });
}