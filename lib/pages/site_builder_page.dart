// // // // // import 'package:flutter/material.dart';
// // // // // import '../config/app_colors.dart';
// // // // // import '../config/constants.dart';
// // // // // import '../widgets/animated_button.dart';
// // // // // import '../widgets/template_card.dart';

// // // // // class SiteBuilderPage extends StatefulWidget {
// // // // //   const SiteBuilderPage({super.key});

// // // // //   @override
// // // // //   State<SiteBuilderPage> createState() => _SiteBuilderPageState();
// // // // // }

// // // // // class _SiteBuilderPageState extends State<SiteBuilderPage> {
// // // // //   final List<WebsiteTemplate> _templates = [];
// // // // //   final List<WebsiteTemplate> _filteredTemplates = [];
// // // // //   String _currentCategory = 'All';
// // // // //   bool _isLoading = true;

// // // // //   final List<String> _categories = ['All', 'Business', 'Portfolio', 'E-commerce', 'Blog', 'Landing Page'];

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     _loadTemplates();
// // // // //   }

// // // // //   void _loadTemplates() {
// // // // //     Future.delayed(const Duration(milliseconds: 800), () {
// // // // //       setState(() {
// // // // //         _templates.addAll(_getMockTemplates());
// // // // //         _filteredTemplates.addAll(_templates);
// // // // //         _isLoading = false;
// // // // //       });
// // // // //     });
// // // // //   }

// // // // //   List<WebsiteTemplate> _getMockTemplates() {
// // // // //     return [
// // // // //       WebsiteTemplate(
// // // // //         id: '1',
// // // // //         title: 'Neon Portfolio',
// // // // //         description: 'Modern portfolio with cyberpunk aesthetics',
// // // // //         category: 'Portfolio',
// // // // //         previewImage: 'assets/images/templates/portfolio1.jpg',
// // // // //         isPremium: false,
// // // // //         rating: 4.8,
// // // // //         uses: 1247,
// // // // //       ),
// // // // //       WebsiteTemplate(
// // // // //         id: '2',
// // // // //         title: 'Cyber Business',
// // // // //         description: 'Professional business website with futuristic design',
// // // // //         category: 'Business',
// // // // //         previewImage: 'assets/images/templates/business1.jpg',
// // // // //         isPremium: true,
// // // // //         rating: 4.9,
// // // // //         uses: 892,
// // // // //       ),
// // // // //       WebsiteTemplate(
// // // // //         id: '3',
// // // // //         title: 'Digital Store',
// // // // //         description: 'E-commerce template with glowing elements',
// // // // //         category: 'E-commerce',
// // // // //         previewImage: 'assets/images/templates/ecommerce1.jpg',
// // // // //         isPremium: true,
// // // // //         rating: 4.7,
// // // // //         uses: 1563,
// // // // //       ),
// // // // //       WebsiteTemplate(
// // // // //         id: '4',
// // // // //         title: 'Tech Blog',
// // // // //         description: 'Blog template optimized for tech content',
// // // // //         category: 'Blog',
// // // // //         previewImage: 'assets/images/templates/blog1.jpg',
// // // // //         isPremium: false,
// // // // //         rating: 4.5,
// // // // //         uses: 734,
// // // // //       ),
// // // // //       WebsiteTemplate(
// // // // //         id: '5',
// // // // //         title: 'Startup Launch',
// // // // //         description: 'Landing page for startups and products',
// // // // //         category: 'Landing Page',
// // // // //         previewImage: 'assets/images/templates/landing1.jpg',
// // // // //         isPremium: false,
// // // // //         rating: 4.6,
// // // // //         uses: 1023,
// // // // //       ),
// // // // //       WebsiteTemplate(
// // // // //         id: '6',
// // // // //         title: 'Agency Pro',
// // // // //         description: 'Premium agency website with animations',
// // // // //         category: 'Business',
// // // // //         previewImage: 'assets/images/templates/agency1.jpg',
// // // // //         isPremium: true,
// // // // //         rating: 5.0,
// // // // //         uses: 567,
// // // // //       ),
// // // // //     ];
// // // // //   }

// // // // //   void _filterTemplates(String category) {
// // // // //     setState(() {
// // // // //       _currentCategory = category;
// // // // //       if (category == 'All') {
// // // // //         _filteredTemplates.clear();
// // // // //         _filteredTemplates.addAll(_templates);
// // // // //       } else {
// // // // //         _filteredTemplates.clear();
// // // // //         _filteredTemplates.addAll(_templates.where((template) => template.category == category).toList());
// // // // //       }
// // // // //     });
// // // // //   }

// // // // //   void _createNewSite() {
// // // // //     showModalBottomSheet(
// // // // //       context: context,
// // // // //       backgroundColor: Colors.transparent,
// // // // //       isScrollControlled: true,
// // // // //       builder: (context) => _buildCreateSiteSheet(),
// // // // //     );
// // // // //   }

// // // // //   void _previewTemplate(WebsiteTemplate template) {
// // // // //     Navigator.push(
// // // // //       context,
// // // // //       MaterialPageRoute(
// // // // //         builder: (context) => TemplatePreviewPage(template: template),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       backgroundColor: AppColors.backgroundDark,
// // // // //       body: SafeArea(
// // // // //         child: Column(
// // // // //           children: [
// // // // //             // Header
// // // // //             Container(
// // // // //               padding: const EdgeInsets.symmetric(
// // // // //                 horizontal: AppConstants.spacingL,
// // // // //                 vertical: AppConstants.spacingM,
// // // // //               ),
// // // // //               decoration: BoxDecoration(
// // // // //                 color: AppColors.backgroundDarker,
// // // // //                 boxShadow: [
// // // // //                   BoxShadow(
// // // // //                     color: Colors.black.withValues(alpha:0.3),
// // // // //                     blurRadius: 8,
// // // // //                     offset: const Offset(0, 2),
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //               child: Row(
// // // // //                 children: [
// // // // //                   Text(
// // // // //                     'Site Builder',
// // // // //                     style: Theme.of(context).textTheme.displayMedium?.copyWith(
// // // // //                       color: AppColors.neonCyan,
// // // // //                     ),
// // // // //                   ),
// // // // //                   const Spacer(),
// // // // //                   IconButton(
// // // // //                     icon: const Icon(
// // // // //                       Icons.search,
// // // // //                       color: AppColors.neonCyan,
// // // // //                     ),
// // // // //                     onPressed: _showSearchDialog,
// // // // //                   ),
// // // // //                   IconButton(
// // // // //                     icon: const Icon(
// // // // //                       Icons.dashboard,
// // // // //                       color: AppColors.neonCyan,
// // // // //                     ),
// // // // //                     onPressed: () {},
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //             ),

// // // // //             // Category Filter
// // // // //             Container(
// // // // //               padding: const EdgeInsets.symmetric(
// // // // //                 horizontal: AppConstants.spacingL,
// // // // //                 vertical: AppConstants.spacingM,
// // // // //               ),
// // // // //               child: SingleChildScrollView(
// // // // //                 scrollDirection: Axis.horizontal,
// // // // //                 child: Row(
// // // // //                   children: _categories.map((category) {
// // // // //                     final isSelected = _currentCategory == category;
// // // // //                     return Container(
// // // // //                       margin: const EdgeInsets.only(right: AppConstants.spacingS),
// // // // //                       child: FilterChip(
// // // // //                         label: Text(
// // // // //                           category,
// // // // //                           style: TextStyle(
// // // // //                             color: isSelected ? AppColors.backgroundDark : AppColors.textPrimary,
// // // // //                             fontSize: AppConstants.fontSizeS,
// // // // //                             fontWeight: FontWeight.w600,
// // // // //                           ),
// // // // //                         ),
// // // // //                         selected: isSelected,
// // // // //                         onSelected: (selected) => _filterTemplates(category),
// // // // //                         backgroundColor: AppColors.surface,
// // // // //                         selectedColor: AppColors.neonPurple,
// // // // //                         checkmarkColor: AppColors.backgroundDark,
// // // // //                         shape: RoundedRectangleBorder(
// // // // //                           borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
// // // // //                         ),
// // // // //                       ),
// // // // //                     );
// // // // //                   }).toList(),
// // // // //                 ),
// // // // //               ),
// // // // //             ),

// // // // //             // Templates Grid
// // // // //             Expanded(
// // // // //               child: _isLoading
// // // // //                   ? _buildLoadingState()
// // // // //                   : _filteredTemplates.isEmpty
// // // // //                       ? _buildEmptyState()
// // // // //                       : _buildTemplatesGrid(),
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //       floatingActionButton: FloatingActionButton(
// // // // //         onPressed: _createNewSite,
// // // // //         backgroundColor: AppColors.neonCyan,
// // // // //         foregroundColor: AppColors.backgroundDark,
// // // // //         child: const Icon(Icons.add),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _buildLoadingState() {
// // // // //     return Center(
// // // // //       child: Column(
// // // // //         mainAxisAlignment: MainAxisAlignment.center,
// // // // //         children: [
// // // // //           const SizedBox(
// // // // //             width: 60,
// // // // //             height: 60,
// // // // //             child: CircularProgressIndicator(
// // // // //               strokeWidth: 3,
// // // // //               valueColor: AlwaysStoppedAnimation(AppColors.neonCyan),
// // // // //             ),
// // // // //           ),
// // // // //           const SizedBox(height: AppConstants.spacingL),
// // // // //           Text(
// // // // //             'Loading Templates...',
// // // // //             style: Theme.of(context).textTheme.bodyLarge?.copyWith(
// // // // //               color: AppColors.textSecondary,
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _buildEmptyState() {
// // // // //     return Center(
// // // // //       child: Column(
// // // // //         mainAxisAlignment: MainAxisAlignment.center,
// // // // //         children: [
// // // // //           const Icon(
// // // // //             Icons.dashboard_outlined,
// // // // //             size: 80,
// // // // //             color: AppColors.textTertiary,
// // // // //           ),
// // // // //           const SizedBox(height: AppConstants.spacingL),
// // // // //           Text(
// // // // //             'No Templates Found',
// // // // //             style: Theme.of(context).textTheme.headlineMedium?.copyWith(
// // // // //               color: AppColors.textSecondary,
// // // // //             ),
// // // // //           ),
// // // // //           const SizedBox(height: AppConstants.spacingM),
// // // // //           Text(
// // // // //             'Try selecting a different category',
// // // // //             style: Theme.of(context).textTheme.bodyLarge?.copyWith(
// // // // //               color: AppColors.textTertiary,
// // // // //             ),
// // // // //             textAlign: TextAlign.center,
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _buildTemplatesGrid() {
// // // // //     return GridView.builder(
// // // // //       padding: const EdgeInsets.all(AppConstants.spacingL),
// // // // //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// // // // //         crossAxisCount: 2,
// // // // //         crossAxisSpacing: AppConstants.spacingL,
// // // // //         mainAxisSpacing: AppConstants.spacingL,
// // // // //         childAspectRatio: 0.8,
// // // // //       ),
// // // // //       itemCount: _filteredTemplates.length,
// // // // //       itemBuilder: (context, index) {
// // // // //         final template = _filteredTemplates[index];
// // // // //         return TemplateCard(
// // // // //           template: template,
// // // // //           onTap: () => _previewTemplate(template),
// // // // //           onUseTemplate: () => _useTemplate(template),
// // // // //         );
// // // // //       },
// // // // //     );
// // // // //   }

// // // // //   Widget _buildCreateSiteSheet() {
// // // // //     return Container(
// // // // //       margin: const EdgeInsets.all(AppConstants.spacingL),
// // // // //       padding: const EdgeInsets.all(AppConstants.spacingL),
// // // // //       decoration: BoxDecoration(
// // // // //         gradient: AppColors.cardGradient,
// // // // //         borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
// // // // //         // boxShadow: AppColors.neonGlow(AppColors.neonCyan),
// // // // //       ),
// // // // //       child: Column(
// // // // //         mainAxisSize: MainAxisSize.min,
// // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // //         children: [
// // // // //           Text(
// // // // //             'Create New Site',
// // // // //             style: Theme.of(context).textTheme.headlineMedium?.copyWith(
// // // // //               color: AppColors.neonCyan,
// // // // //             ),
// // // // //           ),
// // // // //           const SizedBox(height: AppConstants.spacingL),
// // // // //           TextField(
// // // // //             decoration: InputDecoration(
// // // // //               labelText: 'Site Name',
// // // // //               labelStyle: const TextStyle(color: AppColors.textSecondary),
// // // // //               border: OutlineInputBorder(
// // // // //                 borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
// // // // //                 borderSide: const BorderSide(color: AppColors.surface),
// // // // //               ),
// // // // //               focusedBorder: OutlineInputBorder(
// // // // //                 borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
// // // // //                 borderSide: const BorderSide(color: AppColors.neonCyan),
// // // // //               ),
// // // // //             ),
// // // // //             style: const TextStyle(color: AppColors.textPrimary),
// // // // //           ),
// // // // //           const SizedBox(height: AppConstants.spacingM),
// // // // //           DropdownButtonFormField<String>(
// // // // //             decoration: InputDecoration(
// // // // //               labelText: 'Template Category',
// // // // //               labelStyle: const TextStyle(color: AppColors.textSecondary),
// // // // //               border: OutlineInputBorder(
// // // // //                 borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
// // // // //                 borderSide: const BorderSide(color: AppColors.surface),
// // // // //               ),
// // // // //               focusedBorder: OutlineInputBorder(
// // // // //                 borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
// // // // //                 borderSide: const BorderSide(color: AppColors.neonCyan),
// // // // //               ),
// // // // //             ),
// // // // //             initialValue: 'Business',
// // // // //             items: _categories.where((cat) => cat != 'All').map((category) {
// // // // //               return DropdownMenuItem(
// // // // //                 value: category,
// // // // //                 child: Text(
// // // // //                   category,
// // // // //                   style: const TextStyle(color: AppColors.textPrimary),
// // // // //                 ),
// // // // //               );
// // // // //             }).toList(),
// // // // //             onChanged: (value) {},
// // // // //           ),
// // // // //           const SizedBox(height: AppConstants.spacingL),
// // // // //           Row(
// // // // //             children: [
// // // // //               Expanded(
// // // // //                 child: TextButton(
// // // // //                   onPressed: () => Navigator.pop(context),
// // // // //                   style: TextButton.styleFrom(
// // // // //                     padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingM),
// // // // //                     shape: RoundedRectangleBorder(
// // // // //                       borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
// // // // //                       side: const BorderSide(color: AppColors.textTertiary),
// // // // //                     ),
// // // // //                   ),
// // // // //                   child: const Text(
// // // // //                     'Cancel',
// // // // //                     style: TextStyle(
// // // // //                       color: AppColors.textTertiary,
// // // // //                       fontSize: AppConstants.fontSizeM,
// // // // //                     ),
// // // // //                   ),
// // // // //                 ),
// // // // //               ),
// // // // //               const SizedBox(width: AppConstants.spacingM),
// // // // //               Expanded(
// // // // //                 child: AnimatedButton(
// // // // //                   text: 'Create Site',
// // // // //                   onPressed: () {
// // // // //                     // Create site logic
// // // // //                     Navigator.pop(context);
// // // // //                   },
// // // // //                 ),
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   void _showSearchDialog() {
// // // // //     showDialog(
// // // // //       context: context,
// // // // //       builder: (context) => AlertDialog(
// // // // //         backgroundColor: AppColors.cardBackground,
// // // // //         shape: RoundedRectangleBorder(
// // // // //           borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
// // // // //         ),
// // // // //         title: const Text(
// // // // //           'Search Templates',
// // // // //           style: TextStyle(
// // // // //             color: AppColors.textPrimary,
// // // // //             fontSize: AppConstants.fontSizeXL,
// // // // //           ),
// // // // //         ),
// // // // //         content: TextField(
// // // // //           decoration: InputDecoration(
// // // // //             hintText: 'Enter template name...',
// // // // //             hintStyle: const TextStyle(color: AppColors.textTertiary),
// // // // //             border: OutlineInputBorder(
// // // // //               borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
// // // // //               borderSide: const BorderSide(color: AppColors.surface),
// // // // //             ),
// // // // //             focusedBorder: OutlineInputBorder(
// // // // //               borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
// // // // //               borderSide: const BorderSide(color: AppColors.neonCyan),
// // // // //             ),
// // // // //           ),
// // // // //           style: const TextStyle(color: AppColors.textPrimary),
// // // // //         ),
// // // // //         actions: [
// // // // //           TextButton(
// // // // //             onPressed: () => Navigator.pop(context),
// // // // //             child: const Text(
// // // // //               'Cancel',
// // // // //               style: TextStyle(color: AppColors.textTertiary),
// // // // //             ),
// // // // //           ),
// // // // //           Container(
// // // // //             decoration: BoxDecoration(
// // // // //               gradient: AppColors.primaryGradient,
// // // // //               borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
// // // // //             ),
// // // // //             child: TextButton(
// // // // //               onPressed: () {
// // // // //                 // Search logic
// // // // //                 Navigator.pop(context);
// // // // //               },
// // // // //               child: const Text(
// // // // //                 'Search',
// // // // //                 style: TextStyle(
// // // // //                   color: AppColors.backgroundDark,
// // // // //                   fontWeight: FontWeight.w600,
// // // // //                 ),
// // // // //               ),
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   void _useTemplate(WebsiteTemplate template) {
// // // // //     showDialog(
// // // // //       context: context,
// // // // //       builder: (context) => AlertDialog(
// // // // //         backgroundColor: AppColors.cardBackground,
// // // // //         shape: RoundedRectangleBorder(
// // // // //           borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
// // // // //         ),
// // // // //         title: const Text(
// // // // //           'Use Template?',
// // // // //           style: TextStyle(
// // // // //             color: AppColors.textPrimary,
// // // // //             fontSize: AppConstants.fontSizeXL,
// // // // //           ),
// // // // //         ),
// // // // //         content: Column(
// // // // //           mainAxisSize: MainAxisSize.min,
// // // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // // //           children: [
// // // // //             Text(
// // // // //               'Create a new site using "${template.title}" template?',
// // // // //               style: const TextStyle(
// // // // //                 color: AppColors.textSecondary,
// // // // //                 fontSize: AppConstants.fontSizeM,
// // // // //               ),
// // // // //             ),
// // // // //             if (template.isPremium) ...[
// // // // //               const SizedBox(height: AppConstants.spacingM),
// // // // //               Container(
// // // // //                 padding: const EdgeInsets.all(AppConstants.spacingM),
// // // // //                 decoration: BoxDecoration(
// // // // //                   color: AppColors.oliveGold.withValues(alpha:0.2),
// // // // //                   borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
// // // // //                   border: Border.all(color: AppColors.oliveGold),
// // // // //                 ),
// // // // //                 child: const Row(
// // // // //                   children: [
// // // // //                     Icon(Icons.star, color: AppColors.oliveGold, size: 16),
// // // // //                     SizedBox(width: AppConstants.spacingS),
// // // // //                     Text(
// // // // //                       'Premium Template',
// // // // //                       style: TextStyle(
// // // // //                         color: AppColors.oliveGold,
// // // // //                         fontSize: AppConstants.fontSizeS,
// // // // //                         fontWeight: FontWeight.w600,
// // // // //                       ),
// // // // //                     ),
// // // // //                   ],
// // // // //                 ),
// // // // //               ),
// // // // //             ],
// // // // //           ],
// // // // //         ),
// // // // //         actions: [
// // // // //           TextButton(
// // // // //             onPressed: () => Navigator.pop(context),
// // // // //             child: const Text(
// // // // //               'Cancel',
// // // // //               style: TextStyle(color: AppColors.textTertiary),
// // // // //             ),
// // // // //           ),
// // // // //           Container(
// // // // //             decoration: BoxDecoration(
// // // // //               gradient: template.isPremium 
// // // // //                   ? LinearGradient(
// // // // //                       colors: [AppColors.oliveGold, AppColors.oliveGold.withValues(alpha:0.8)],
// // // // //                     )
// // // // //                   : AppColors.primaryGradient,
// // // // //               borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
// // // // //             ),
// // // // //             child: TextButton(
// // // // //               onPressed: () {
// // // // //                 Navigator.pop(context);
// // // // //                 _createSiteFromTemplate(template);
// // // // //               },
// // // // //               child: Text(
// // // // //                 template.isPremium ? 'Use Premium' : 'Use Template',
// // // // //                 style: const TextStyle(
// // // // //                   color: AppColors.backgroundDark,
// // // // //                   fontWeight: FontWeight.w600,
// // // // //                 ),
// // // // //               ),
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   void _createSiteFromTemplate(WebsiteTemplate template) {
// // // // //     // Implementation for creating site from template
// // // // //     ScaffoldMessenger.of(context).showSnackBar(
// // // // //       SnackBar(
// // // // //         backgroundColor: AppColors.neonGreen,
// // // // //         content: Text(
// // // // //           'Site created from "${template.title}"!',
// // // // //           style: const TextStyle(color: AppColors.backgroundDark),
// // // // //         ),
// // // // //         duration: const Duration(seconds: 2),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // // class TemplatePreviewPage extends StatelessWidget {
// // // // //   final WebsiteTemplate template;

// // // // //   const TemplatePreviewPage({super.key, required this.template});

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       backgroundColor: AppColors.backgroundDark,
// // // // //       appBar: AppBar(
// // // // //         backgroundColor: Colors.transparent,
// // // // //         elevation: 0,
// // // // //         title: Text(
// // // // //           template.title,
// // // // //           style: const TextStyle(color: AppColors.neonCyan),
// // // // //         ),
// // // // //         actions: [
// // // // //           IconButton(
// // // // //             icon: const Icon(Icons.close),
// // // // //             onPressed: () => Navigator.pop(context),
// // // // //             color: AppColors.textPrimary,
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //       body: SingleChildScrollView(
// // // // //         child: Column(
// // // // //           children: [
// // // // //             // Template Preview Image
// // // // //             Container(
// // // // //               height: 300,
// // // // //               margin: const EdgeInsets.all(AppConstants.spacingL),
// // // // //               decoration: BoxDecoration(
// // // // //                 borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
// // // // //                 gradient: LinearGradient(
// // // // //                   begin: Alignment.topLeft,
// // // // //                   end: Alignment.bottomRight,
// // // // //                   colors: [AppColors.neonCyan.withValues(alpha:0.3), AppColors.neonPurple.withValues(alpha:0.3)],
// // // // //                 ),
// // // // //                 // boxShadow: AppColors.neonGlow(AppColors.neonCyan),
// // // // //               ),
// // // // //               child: const Center(
// // // // //                 child: Icon(
// // // // //                   Icons.dashboard,
// // // // //                   size: 80,
// // // // //                   color: AppColors.neonCyan,
// // // // //                 ),
// // // // //               ),
// // // // //             ),

// // // // //             // Template Details
// // // // //             Container(
// // // // //               margin: const EdgeInsets.all(AppConstants.spacingL),
// // // // //               padding: const EdgeInsets.all(AppConstants.spacingL),
// // // // //               decoration: BoxDecoration(
// // // // //                 gradient: AppColors.cardGradient,
// // // // //                 borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
// // // // //               ),
// // // // //               child: Column(
// // // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                 children: [
// // // // //                   Row(
// // // // //                     children: [
// // // // //                       Expanded(
// // // // //                         child: Text(
// // // // //                           template.title,
// // // // //                           style: Theme.of(context).textTheme.headlineMedium?.copyWith(
// // // // //                             color: AppColors.textPrimary,
// // // // //                           ),
// // // // //                         ),
// // // // //                       ),
// // // // //                       if (template.isPremium)
// // // // //                         Container(
// // // // //                           padding: const EdgeInsets.symmetric(
// // // // //                             horizontal: AppConstants.spacingM,
// // // // //                             vertical: AppConstants.spacingXS,
// // // // //                           ),
// // // // //                           decoration: BoxDecoration(
// // // // //                             gradient: LinearGradient(
// // // // //                               colors: [AppColors.oliveGold, AppColors.oliveGold.withValues(alpha:0.7)],
// // // // //                             ),
// // // // //                             borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
// // // // //                           ),
// // // // //                           child: const Text(
// // // // //                             'PREMIUM',
// // // // //                             style: TextStyle(
// // // // //                               color: AppColors.backgroundDark,
// // // // //                               fontSize: AppConstants.fontSizeXS,
// // // // //                               fontWeight: FontWeight.w700,
// // // // //                             ),
// // // // //                           ),
// // // // //                         ),
// // // // //                     ],
// // // // //                   ),
// // // // //                   const SizedBox(height: AppConstants.spacingM),
// // // // //                   Text(
// // // // //                     template.description,
// // // // //                     style: Theme.of(context).textTheme.bodyLarge?.copyWith(
// // // // //                       color: AppColors.textSecondary,
// // // // //                     ),
// // // // //                   ),
// // // // //                   const SizedBox(height: AppConstants.spacingL),
// // // // //                   Row(
// // // // //                     children: [
// // // // //                       _buildDetailItem(Icons.category, template.category),
// // // // //                       const SizedBox(width: AppConstants.spacingL),
// // // // //                       _buildDetailItem(Icons.star, '${template.rating}'),
// // // // //                       const SizedBox(width: AppConstants.spacingL),
// // // // //                       _buildDetailItem(Icons.people, '${template.uses} uses'),
// // // // //                     ],
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //             ),

// // // // //             // Features
// // // // //             Container(
// // // // //               margin: const EdgeInsets.all(AppConstants.spacingL),
// // // // //               padding: const EdgeInsets.all(AppConstants.spacingL),
// // // // //               decoration: BoxDecoration(
// // // // //                 gradient: AppColors.cardGradient,
// // // // //                 borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
// // // // //               ),
// // // // //               child: Column(
// // // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                 children: [
// // // // //                   Text(
// // // // //                     'Features',
// // // // //                     style: Theme.of(context).textTheme.titleLarge?.copyWith(
// // // // //                       color: AppColors.neonCyan,
// // // // //                     ),
// // // // //                   ),
// // // // //                   const SizedBox(height: AppConstants.spacingM),
// // // // //                   _buildFeatureItem('Responsive Design'),
// // // // //                   _buildFeatureItem('Dark Mode Support'),
// // // // //                   _buildFeatureItem('Fast Loading'),
// // // // //                   _buildFeatureItem('SEO Optimized'),
// // // // //                   _buildFeatureItem('Easy Customization'),
// // // // //                 ],
// // // // //               ),
// // // // //             ),

// // // // //             // Action Button
// // // // //             Container(
// // // // //               margin: const EdgeInsets.all(AppConstants.spacingL),
// // // // //               child: AnimatedButton(
// // // // //                 text: template.isPremium ? 'Use Premium Template' : 'Use This Template',
// // // // //                 onPressed: () {
// // // // //                   Navigator.pop(context);
// // // // //                   // Use template logic
// // // // //                 },
// // // // //                 width: double.infinity,
// // // // //               ),
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _buildDetailItem(IconData icon, String text) {
// // // // //     return Row(
// // // // //       children: [
// // // // //         Icon(icon, color: AppColors.neonCyan, size: AppConstants.iconSizeS),
// // // // //         const SizedBox(width: AppConstants.spacingXS),
// // // // //         Text(
// // // // //           text,
// // // // //           style: const TextStyle(
// // // // //             color: AppColors.textSecondary,
// // // // //             fontSize: AppConstants.fontSizeS,
// // // // //           ),
// // // // //         ),
// // // // //       ],
// // // // //     );
// // // // //   }

// // // // //   Widget _buildFeatureItem(String feature) {
// // // // //     return Padding(
// // // // //       padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingS),
// // // // //       child: Row(
// // // // //         children: [
// // // // //           const Icon(
// // // // //             Icons.check_circle,
// // // // //             color: AppColors.neonGreen,
// // // // //             size: AppConstants.iconSizeS,
// // // // //           ),
// // // // //           const SizedBox(width: AppConstants.spacingM),
// // // // //           Text(
// // // // //             feature,
// // // // //             style: const TextStyle(
// // // // //               color: AppColors.textPrimary,
// // // // //               fontSize: AppConstants.fontSizeM,
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // // class WebsiteTemplate {
// // // // //   final String id;
// // // // //   final String title;
// // // // //   final String description;
// // // // //   final String category;
// // // // //   final String previewImage;
// // // // //   final bool isPremium;
// // // // //   final double rating;
// // // // //   final int uses;

// // // // //   WebsiteTemplate({
// // // // //     required this.id,
// // // // //     required this.title,
// // // // //     required this.description,
// // // // //     required this.category,
// // // // //     required this.previewImage,
// // // // //     required this.isPremium,
// // // // //     required this.rating,
// // // // //     required this.uses,
// // // // //   });
// // // // // }



// // // // import 'dart:ui';
// // // // import 'package:flutter/material.dart';
// // // // // import 'package:vetto_ai/config/constants.dart';
// // // // // import 'package:vetto_ai/widgets/animated_button.dart';
// // // // import 'package:vetto_ai/widgets/glass_card.dart';
// // // // import 'package:vetto_ai/widgets/template_card.dart';
// // // // import 'package:vetto_ai/widgets/vetto_scaffold.dart';

// // // // class SiteBuilderPage extends StatefulWidget {
// // // //   const SiteBuilderPage({super.key});

// // // //   @override
// // // //   State<SiteBuilderPage> createState() => _SiteBuilderPageState();
// // // // }

// // // // class _SiteBuilderPageState extends State<SiteBuilderPage> {
// // // //   final List<WebsiteTemplate> _templates = [];
// // // //   final List<WebsiteTemplate> _filteredTemplates = [];
// // // //   String _currentCategory = 'All';
// // // //   bool _isLoading = true;

// // // //   final List<String> _categories = ['All', 'Business', 'Portfolio', 'E-commerce', 'Blog', 'Landing Page'];

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     _loadTemplates();
// // // //   }

// // // //   void _loadTemplates() {
// // // //     Future.delayed(const Duration(milliseconds: 800), () {
// // // //       if (!mounted) return;
// // // //       setState(() {
// // // //         _templates.addAll(_getMockTemplates());
// // // //         _filteredTemplates.addAll(_templates);
// // // //         _isLoading = false;
// // // //       });
// // // //     });
// // // //   }

// // // //   List<WebsiteTemplate> _getMockTemplates() {
// // // //     return [
// // // //       WebsiteTemplate(
// // // //         id: '1',
// // // //         title: 'Neon Portfolio',
// // // //         description: 'Modern portfolio with cyberpunk aesthetics',
// // // //         category: 'Portfolio',
// // // //         previewImage: 'assets/images/templates/portfolio1.jpg',
// // // //         isPremium: false,
// // // //         rating: 4.8,
// // // //         uses: 1247,
// // // //       ),
// // // //       WebsiteTemplate(
// // // //         id: '2',
// // // //         title: 'Cyber Business',
// // // //         description: 'Professional business website with futuristic design',
// // // //         category: 'Business',
// // // //         previewImage: 'assets/images/templates/business1.jpg',
// // // //         isPremium: true,
// // // //         rating: 4.9,
// // // //         uses: 892,
// // // //       ),
// // // //       WebsiteTemplate(
// // // //         id: '3',
// // // //         title: 'Digital Store',
// // // //         description: 'E-commerce template with glowing elements',
// // // //         category: 'E-commerce',
// // // //         previewImage: 'assets/images/templates/ecommerce1.jpg',
// // // //         isPremium: true,
// // // //         rating: 4.7,
// // // //         uses: 1563,
// // // //       ),
// // // //       WebsiteTemplate(
// // // //         id: '4',
// // // //         title: 'Tech Blog',
// // // //         description: 'Blog template optimized for tech content',
// // // //         category: 'Blog',
// // // //         previewImage: 'assets/images/templates/blog1.jpg',
// // // //         isPremium: false,
// // // //         rating: 4.5,
// // // //         uses: 734,
// // // //       ),
// // // //       WebsiteTemplate(
// // // //         id: '5',
// // // //         title: 'Startup Launch',
// // // //         description: 'Landing page for startups and products',
// // // //         category: 'Landing Page',
// // // //         previewImage: 'assets/images/templates/landing1.jpg',
// // // //         isPremium: false,
// // // //         rating: 4.6,
// // // //         uses: 1023,
// // // //       ),
// // // //       WebsiteTemplate(
// // // //         id: '6',
// // // //         title: 'Agency Pro',
// // // //         description: 'Premium agency website with animations',
// // // //         category: 'Business',
// // // //         previewImage: 'assets/images/templates/agency1.jpg',
// // // //         isPremium: true,
// // // //         rating: 5.0,
// // // //         uses: 567,
// // // //       ),
// // // //     ];
// // // //   }

// // // //   void _filterTemplates(String category) {
// // // //     setState(() {
// // // //       _currentCategory = category;
// // // //       if (category == 'All') {
// // // //         _filteredTemplates.clear();
// // // //         _filteredTemplates.addAll(_templates);
// // // //       } else {
// // // //         _filteredTemplates.clear();
// // // //         _filteredTemplates.addAll(_templates.where((template) => template.category == category).toList());
// // // //       }
// // // //     });
// // // //   }

// // // //   void _createNewSite() {
// // // //     showModalBottomSheet(
// // // //       context: context,
// // // //       backgroundColor: Colors.transparent,
// // // //       isScrollControlled: true,
// // // //       builder: (context) => _buildCreateSiteSheet(),
// // // //     );
// // // //   }

// // // //   void _previewTemplate(WebsiteTemplate template) {
// // // //     Navigator.push(
// // // //       context,
// // // //       MaterialPageRoute(
// // // //         builder: (context) => TemplatePreviewPage(template: template),
// // // //       ),
// // // //     );
// // // //   }

// // // //   void _useTemplate(WebsiteTemplate template) {
// // // //     showDialog(
// // // //       context: context,
// // // //       builder: (context) => AlertDialog(
// // // //         backgroundColor: const Color(0xFF2F3A2F), // Vetto Dark Green
// // // //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// // // //         title: const Text(
// // // //           'Use Template?',
// // // //           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
// // // //         ),
// // // //         content: Text(
// // // //           'Create a new site using "${template.title}" template?',
// // // //           style: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
// // // //         ),
// // // //         actions: [
// // // //           TextButton(
// // // //             onPressed: () => Navigator.pop(context),
// // // //             child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
// // // //           ),
// // // //           ElevatedButton(
// // // //             onPressed: () {
// // // //               Navigator.pop(context);
// // // //               // Actual creation logic would go here
// // // //               ScaffoldMessenger.of(context).showSnackBar(
// // // //                 SnackBar(
// // // //                   backgroundColor: const Color(0xFF7E8F77),
// // // //                   content: Text('Site created from "${template.title}"!', style: const TextStyle(color: Colors.white)),
// // // //                 ),
// // // //               );
// // // //             },
// // // //             style: ElevatedButton.styleFrom(
// // // //               backgroundColor: Colors.white,
// // // //               foregroundColor: const Color(0xFF2F3A2F),
// // // //             ),
// // // //             child: Text(template.isPremium ? 'Unlock' : 'Create'),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return VettoScaffold(
// // // //       floatingActionButton: FloatingActionButton(
// // // //         onPressed: _createNewSite,
// // // //         backgroundColor: Colors.white,
// // // //         foregroundColor: const Color(0xFF2F3A2F),
// // // //         child: const Icon(Icons.add),
// // // //       ),
// // // //       body: Column(
// // // //         children: [
// // // //           // --- Header ---
// // // //           Padding(
// // // //             padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
// // // //             child: GlassCard(
// // // //               child: Row(
// // // //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //                 children: [
// // // //                   const Text(
// // // //                     'Site Builder',
// // // //                     style: TextStyle(
// // // //                       fontSize: 24,
// // // //                       fontWeight: FontWeight.w800,
// // // //                       color: Colors.white,
// // // //                     ),
// // // //                   ),
// // // //                   Row(
// // // //                     children: [
// // // //                       IconButton(
// // // //                         icon: const Icon(Icons.search, color: Colors.white),
// // // //                         onPressed: () {}, // Placeholder
// // // //                       ),
// // // //                       IconButton(
// // // //                         icon: const Icon(Icons.dashboard_customize, color: Colors.white),
// // // //                         onPressed: () {}, // Placeholder
// // // //                       ),
// // // //                     ],
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //           ),

// // // //           // --- Category Filter ---
// // // //           Container(
// // // //             height: 50,
// // // //             margin: const EdgeInsets.symmetric(vertical: 10),
// // // //             child: ListView.builder(
// // // //               scrollDirection: Axis.horizontal,
// // // //               padding: const EdgeInsets.symmetric(horizontal: 20),
// // // //               itemCount: _categories.length,
// // // //               itemBuilder: (context, index) {
// // // //                 final category = _categories[index];
// // // //                 final isSelected = _currentCategory == category;
// // // //                 return GestureDetector(
// // // //                   onTap: () => _filterTemplates(category),
// // // //                   child: Container(
// // // //                     margin: const EdgeInsets.only(right: 10),
// // // //                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
// // // //                     decoration: BoxDecoration(
// // // //                       color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.1),
// // // //                       borderRadius: BorderRadius.circular(20),
// // // //                       border: Border.all(
// // // //                         color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.2),
// // // //                       ),
// // // //                     ),
// // // //                     alignment: Alignment.center,
// // // //                     child: Text(
// // // //                       category,
// // // //                       style: TextStyle(
// // // //                         color: isSelected ? const Color(0xFF2F3A2F) : Colors.white,
// // // //                         fontWeight: FontWeight.bold,
// // // //                         fontSize: 12,
// // // //                       ),
// // // //                     ),
// // // //                   ),
// // // //                 );
// // // //               },
// // // //             ),
// // // //           ),

// // // //           // --- Templates Grid ---
// // // //           Expanded(
// // // //             child: _isLoading
// // // //                 ? const Center(
// // // //                     child: CircularProgressIndicator(color: Colors.white),
// // // //                   )
// // // //                 : _filteredTemplates.isEmpty
// // // //                     ? _buildEmptyState()
// // // //                     : GridView.builder(
// // // //                         padding: const EdgeInsets.all(20),
// // // //                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// // // //                           crossAxisCount: 2,
// // // //                           crossAxisSpacing: 16,
// // // //                           mainAxisSpacing: 16,
// // // //                           childAspectRatio: 0.75,
// // // //                         ),
// // // //                         itemCount: _filteredTemplates.length,
// // // //                         itemBuilder: (context, index) {
// // // //                           final template = _filteredTemplates[index];
// // // //                           return TemplateCard(
// // // //                             template: template,
// // // //                             onTap: () => _previewTemplate(template),
// // // //                             onUseTemplate: () => _useTemplate(template),
// // // //                           );
// // // //                         },
// // // //                       ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildEmptyState() {
// // // //     return Center(
// // // //       child: Column(
// // // //         mainAxisAlignment: MainAxisAlignment.center,
// // // //         children: [
// // // //           Icon(Icons.web_asset_off, size: 60, color: Colors.white.withValues(alpha: 0.3)),
// // // //           const SizedBox(height: 16),
// // // //           Text(
// // // //             'No Templates Found',
// // // //             style: TextStyle(
// // // //               color: Colors.white.withValues(alpha: 0.5),
// // // //               fontSize: 16,
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildCreateSiteSheet() {
// // // //     // Using Glass effect for bottom sheet
// // // //     return ClipRRect(
// // // //       borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
// // // //       child: BackdropFilter(
// // // //         filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
// // // //         child: Container(
// // // //           padding: const EdgeInsets.all(24),
// // // //           decoration: BoxDecoration(
// // // //             color: const Color(0xFF2F3A2F).withValues(alpha: 0.9),
// // // //             borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
// // // //             border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.2))),
// // // //           ),
// // // //           child: Column(
// // // //             mainAxisSize: MainAxisSize.min,
// // // //             crossAxisAlignment: CrossAxisAlignment.start,
// // // //             children: [
// // // //               Center(
// // // //                 child: Container(
// // // //                   width: 40,
// // // //                   height: 4,
// // // //                   decoration: BoxDecoration(
// // // //                     color: Colors.white.withValues(alpha: 0.3),
// // // //                     borderRadius: BorderRadius.circular(2),
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //               const SizedBox(height: 24),
// // // //               const Text(
// // // //                 'Create New Site',
// // // //                 style: TextStyle(
// // // //                   color: Colors.white,
// // // //                   fontSize: 20,
// // // //                   fontWeight: FontWeight.bold,
// // // //                 ),
// // // //               ),
// // // //               const SizedBox(height: 24),
// // // //               TextField(
// // // //                 style: const TextStyle(color: Colors.white),
// // // //                 decoration: InputDecoration(
// // // //                   labelText: 'Site Name',
// // // //                   labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
// // // //                   enabledBorder: OutlineInputBorder(
// // // //                     borderRadius: BorderRadius.circular(12),
// // // //                     borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
// // // //                   ),
// // // //                   focusedBorder: OutlineInputBorder(
// // // //                     borderRadius: BorderRadius.circular(12),
// // // //                     borderSide: const BorderSide(color: Colors.white),
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //               const SizedBox(height: 24),
// // // //               Row(
// // // //                 children: [
// // // //                   Expanded(
// // // //                     child: TextButton(
// // // //                       onPressed: () => Navigator.pop(context),
// // // //                       child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
// // // //                     ),
// // // //                   ),
// // // //                   const SizedBox(width: 16),
// // // //                   Expanded(
// // // //                     child: ElevatedButton(
// // // //                       onPressed: () => Navigator.pop(context),
// // // //                       style: ElevatedButton.styleFrom(
// // // //                         backgroundColor: Colors.white,
// // // //                         foregroundColor: const Color(0xFF2F3A2F),
// // // //                         padding: const EdgeInsets.symmetric(vertical: 16),
// // // //                         shape: RoundedRectangleBorder(
// // // //                           borderRadius: BorderRadius.circular(12),
// // // //                         ),
// // // //                       ),
// // // //                       child: const Text('Create Site', style: TextStyle(fontWeight: FontWeight.bold)),
// // // //                     ),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //               const SizedBox(height: 20), // Keyboard spacing
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // class TemplatePreviewPage extends StatelessWidget {
// // // //   final WebsiteTemplate template;

// // // //   const TemplatePreviewPage({super.key, required this.template});

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return VettoScaffold(
// // // //       appBar: AppBar(
// // // //         backgroundColor: Colors.transparent,
// // // //         elevation: 0,
// // // //         leading: IconButton(
// // // //           icon: const Icon(Icons.arrow_back, color: Colors.white),
// // // //           onPressed: () => Navigator.pop(context),
// // // //         ),
// // // //         title: Text(template.title, style: const TextStyle(color: Colors.white)),
// // // //       ),
// // // //       body: SingleChildScrollView(
// // // //         padding: const EdgeInsets.all(20),
// // // //         child: Column(
// // // //           children: [
// // // //             // Large Preview Card
// // // //             GlassCard(
// // // //               padding: EdgeInsets.zero,
// // // //               child: Column(
// // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // //                 children: [
// // // //                   Container(
// // // //                     height: 250,
// // // //                     width: double.infinity,
// // // //                     margin: const EdgeInsets.all(16),
// // // //                     decoration: BoxDecoration(
// // // //                       color: Colors.black.withValues(alpha: 0.3),
// // // //                       borderRadius: BorderRadius.circular(16),
// // // //                     ),
// // // //                     child: const Center(
// // // //                       child: Icon(Icons.image, size: 60, color: Colors.white54),
// // // //                     ),
// // // //                   ),
// // // //                   Padding(
// // // //                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// // // //                     child: Row(
// // // //                       children: [
// // // //                         if (template.isPremium)
// // // //                           Container(
// // // //                             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// // // //                             margin: const EdgeInsets.only(right: 10),
// // // //                             decoration: BoxDecoration(
// // // //                               color: const Color(0xFFB5A642), // Gold
// // // //                               borderRadius: BorderRadius.circular(6),
// // // //                             ),
// // // //                             child: const Text('PRO', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
// // // //                           ),
// // // //                         Text(
// // // //                           template.category,
// // // //                           style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12),
// // // //                         ),
// // // //                         const Spacer(),
// // // //                         const Icon(Icons.star, size: 14, color: Color(0xFFB5A642)),
// // // //                         const SizedBox(width: 4),
// // // //                         Text(
// // // //                           '${template.rating}',
// // // //                           style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
// // // //                         ),
// // // //                       ],
// // // //                     ),
// // // //                   ),
// // // //                   Padding(
// // // //                     padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
// // // //                     child: Text(
// // // //                       template.description,
// // // //                       style: TextStyle(color: Colors.white.withValues(alpha: 0.8), height: 1.5),
// // // //                     ),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
            
// // // //             const SizedBox(height: 20),
            
// // // //             // Action Button
// // // //             SizedBox(
// // // //               width: double.infinity,
// // // //               child: ElevatedButton(
// // // //                 onPressed: () => Navigator.pop(context), // Placeholder for "Use"
// // // //                 style: ElevatedButton.styleFrom(
// // // //                   backgroundColor: Colors.white,
// // // //                   foregroundColor: const Color(0xFF2F3A2F),
// // // //                   padding: const EdgeInsets.symmetric(vertical: 16),
// // // //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// // // //                 ),
// // // //                 child: Text(
// // // //                   template.isPremium ? 'Unlock Template' : 'Use Template',
// // // //                   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // // Re-declaring here since it was in the original file snippet
// // // // class WebsiteTemplate {
// // // //   final String id;
// // // //   final String title;
// // // //   final String description;
// // // //   final String category;
// // // //   final String previewImage;
// // // //   final bool isPremium;
// // // //   final double rating;
// // // //   final int uses;

// // // //   WebsiteTemplate({
// // // //     required this.id,
// // // //     required this.title,
// // // //     required this.description,
// // // //     required this.category,
// // // //     required this.previewImage,
// // // //     required this.isPremium,
// // // //     required this.rating,
// // // //     required this.uses,
// // // //   });
// // // // }




// // // import 'dart:ui';
// // // import 'package:flutter/material.dart';
// // // import 'package:vetto_ai/widgets/glass_card.dart';
// // // import 'package:vetto_ai/widgets/vetto_scaffold.dart';

// // // // --- 1. MODEL ---
// // // class WebsiteTemplate {
// // //   final String id;
// // //   final String title;
// // //   final String description;
// // //   final String category;
// // //   final String imagePath; // Changed from previewImage to use your 3D assets
// // //   final bool isPremium;
// // //   final double rating;
// // //   final int uses;
// // //   final List<String> features; // Added features list

// // //   WebsiteTemplate({
// // //     required this.id,
// // //     required this.title,
// // //     required this.description,
// // //     required this.category,
// // //     required this.imagePath,
// // //     required this.isPremium,
// // //     required this.rating,
// // //     required this.uses,
// // //     this.features = const [],
// // //   });
// // // }

// // // // --- 2. MAIN PAGE ---
// // // class SiteBuilderPage extends StatefulWidget {
// // //   const SiteBuilderPage({super.key});

// // //   @override
// // //   State<SiteBuilderPage> createState() => _SiteBuilderPageState();
// // // }

// // // class _SiteBuilderPageState extends State<SiteBuilderPage> {
// // //   final List<WebsiteTemplate> _templates = [];
// // //   final List<WebsiteTemplate> _filteredTemplates = [];
// // //   String _currentCategory = 'All';
// // //   bool _isLoading = true;

// // //   final List<String> _categories = ['All', 'Business', 'Portfolio', 'Store', 'Blog', 'Landing'];

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _loadTemplates();
// // //   }

// // //   void _loadTemplates() {
// // //     Future.delayed(const Duration(milliseconds: 800), () {
// // //       if (!mounted) return;
// // //       setState(() {
// // //         _templates.addAll(_getMockTemplates());
// // //         _filteredTemplates.addAll(_templates);
// // //         _isLoading = false;
// // //       });
// // //     });
// // //   }

// // //   // Using your provided 3D assets as the "Template Previews" for a modern abstract look
// // //   List<WebsiteTemplate> _getMockTemplates() {
// // //     return [
// // //       WebsiteTemplate(
// // //         id: '1',
// // //         title: 'Neon Portfolio',
// // //         description: 'High-impact personal branding template.',
// // //         category: 'Portfolio',
// // //         imagePath: 'assets/images/3dgraphics/image-8HR0ctKWczS8YFn67f3UW0M0cvWXBw.png',
// // //         isPremium: false,
// // //         rating: 4.8,
// // //         uses: 1247,
// // //         features: ['Dark Mode', 'Animations', 'Contact Form'],
// // //       ),
// // //       WebsiteTemplate(
// // //         id: '2',
// // //         title: 'Cyber Business',
// // //         description: 'Corporate layout with futuristic elements.',
// // //         category: 'Business',
// // //         imagePath: 'assets/images/3dgraphics/image-aM6jkL7K10n261cCFKqEY7FqQfeaMP.png',
// // //         isPremium: true,
// // //         rating: 4.9,
// // //         uses: 892,
// // //         features: ['SEO Optimized', 'Team Section', 'Analytics'],
// // //       ),
// // //       WebsiteTemplate(
// // //         id: '3',
// // //         title: 'Quantum Store',
// // //         description: 'E-commerce ready with Stripe integration.',
// // //         category: 'Store',
// // //         imagePath: 'assets/images/3dgraphics/image-ElUJAyxcRVHJkNw7oBRIsG5GF7hIgt.png',
// // //         isPremium: true,
// // //         rating: 4.7,
// // //         uses: 1563,
// // //         features: ['Cart System', 'Payment Gateway', 'Inventory'],
// // //       ),
// // //       WebsiteTemplate(
// // //         id: '4',
// // //         title: 'Tech Blog',
// // //         description: 'Minimalist layout for technical writing.',
// // //         category: 'Blog',
// // //         imagePath: 'assets/images/3dgraphics/image-IU0LQSM0ihtW1G0IZB5bYpEFwG97T6.png',
// // //         isPremium: false,
// // //         rating: 4.5,
// // //         uses: 734,
// // //         features: ['Markdown Support', 'Newsletter', 'Comments'],
// // //       ),
// // //       WebsiteTemplate(
// // //         id: '5',
// // //         title: 'Startup Launch',
// // //         description: 'High conversion landing page.',
// // //         category: 'Landing',
// // //         imagePath: 'assets/images/3dgraphics/image-k1htnek7frg4W1bRqSfOnMuNzJGdmX.png',
// // //         isPremium: false,
// // //         rating: 4.6,
// // //         uses: 1023,
// // //         features: ['A/B Testing', 'Hero Section', 'Email Capture'],
// // //       ),
// // //       WebsiteTemplate(
// // //         id: '6',
// // //         title: 'Agency Pro',
// // //         description: 'Showcase your work with style.',
// // //         category: 'Business',
// // //         imagePath: 'assets/images/3dgraphics/image-keoWINYYBgXx7vwibZe2cbllJ4SaQA.png',
// // //         isPremium: true,
// // //         rating: 5.0,
// // //         uses: 567,
// // //         features: ['Case Studies', 'Client Portal', 'Gallery'],
// // //       ),
// // //     ];
// // //   }

// // //   void _filterTemplates(String category) {
// // //     setState(() {
// // //       _currentCategory = category;
// // //       if (category == 'All') {
// // //         _filteredTemplates.clear();
// // //         _filteredTemplates.addAll(_templates);
// // //       } else {
// // //         _filteredTemplates.clear();
// // //         _filteredTemplates.addAll(_templates.where((template) => template.category == category).toList());
// // //       }
// // //     });
// // //   }

// // //   void _createNewSite() {
// // //     showModalBottomSheet(
// // //       context: context,
// // //       backgroundColor: Colors.transparent,
// // //       isScrollControlled: true,
// // //       builder: (context) => _buildCreateSiteSheet(),
// // //     );
// // //   }

// // //   void _previewTemplate(WebsiteTemplate template) {
// // //     Navigator.push(
// // //       context,
// // //       MaterialPageRoute(builder: (context) => TemplatePreviewPage(template: template)),
// // //     );
// // //   }

// // //   // void _useTemplate(WebsiteTemplate template) {
// // //   //   // Logic to use template
// // //   //   Navigator.pop(context); // Close preview if open
// // //   //   ScaffoldMessenger.of(context).showSnackBar(
// // //   //     SnackBar(
// // //   //       backgroundColor: const Color(0xFF6A7B66),
// // //   //       content: Text('Initializing ${template.title}...', style: const TextStyle(color: Colors.white)),
// // //   //     ),
// // //   //   );
// // //   // }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return VettoScaffold(
// // //       floatingActionButton: FloatingActionButton(
// // //         onPressed: _createNewSite,
// // //         backgroundColor: Colors.white,
// // //         foregroundColor: const Color(0xFF2F3A2F),
// // //         child: const Icon(Icons.add),
// // //       ),
// // //       body: Column(
// // //         children: [
// // //           // --- Header ---
// // //           Padding(
// // //             padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
// // //             child: GlassCard(
// // //               child: Row(
// // //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                 children: [
// // //                   const Text(
// // //                     'Site Builder',
// // //                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.white),
// // //                   ),
// // //                   Row(
// // //                     children: [
// // //                       IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {}),
// // //                       IconButton(icon: const Icon(Icons.dashboard_customize, color: Colors.white), onPressed: () {}),
// // //                     ],
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ),

// // //           // --- Category Filter ---
// // //           Container(
// // //             height: 45,
// // //             margin: const EdgeInsets.symmetric(vertical: 10),
// // //             child: ListView.builder(
// // //               scrollDirection: Axis.horizontal,
// // //               padding: const EdgeInsets.symmetric(horizontal: 20),
// // //               itemCount: _categories.length,
// // //               itemBuilder: (context, index) {
// // //                 final category = _categories[index];
// // //                 final isSelected = _currentCategory == category;
// // //                 return GestureDetector(
// // //                   onTap: () => _filterTemplates(category),
// // //                   child: AnimatedContainer(
// // //                     duration: const Duration(milliseconds: 200),
// // //                     margin: const EdgeInsets.only(right: 10),
// // //                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
// // //                     decoration: BoxDecoration(
// // //                       color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.05),
// // //                       borderRadius: BorderRadius.circular(20),
// // //                       border: Border.all(
// // //                         color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.1),
// // //                       ),
// // //                     ),
// // //                     alignment: Alignment.center,
// // //                     child: Text(
// // //                       category,
// // //                       style: TextStyle(
// // //                         color: isSelected ? const Color(0xFF2F3A2F) : Colors.white,
// // //                         fontWeight: FontWeight.bold,
// // //                         fontSize: 12,
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 );
// // //               },
// // //             ),
// // //           ),

// // //           // --- Templates Grid ---
// // //           Expanded(
// // //             child: _isLoading
// // //                 ? const Center(child: CircularProgressIndicator(color: Colors.white))
// // //                 : _filteredTemplates.isEmpty
// // //                     ? _buildEmptyState()
// // //                     : GridView.builder(
// // //                         padding: const EdgeInsets.fromLTRB(20, 10, 20, 80),
// // //                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// // //                           crossAxisCount: 2,
// // //                           crossAxisSpacing: 16,
// // //                           mainAxisSpacing: 16,
// // //                           childAspectRatio: 0.7, // Taller for images
// // //                         ),
// // //                         itemCount: _filteredTemplates.length,
// // //                         itemBuilder: (context, index) {
// // //                           return TemplateCard(
// // //                             template: _filteredTemplates[index],
// // //                             onTap: () => _previewTemplate(_filteredTemplates[index]),
// // //                           );
// // //                         },
// // //                       ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildEmptyState() {
// // //     return Center(
// // //       child: Column(
// // //         mainAxisAlignment: MainAxisAlignment.center,
// // //         children: [
// // //           Icon(Icons.web_asset_off, size: 60, color: Colors.white.withValues(alpha: 0.3)),
// // //           const SizedBox(height: 16),
// // //           Text('No Templates Found', style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 16)),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildCreateSiteSheet() {
// // //     return ClipRRect(
// // //       borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
// // //       child: BackdropFilter(
// // //         filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
// // //         child: Container(
// // //           padding: const EdgeInsets.all(24),
// // //           decoration: BoxDecoration(
// // //             color: const Color(0xFF1E2B1E).withValues(alpha: 0.9),
// // //             borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
// // //             border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.2))),
// // //           ),
// // //           child: Column(
// // //             mainAxisSize: MainAxisSize.min,
// // //             children: [
// // //               Container(
// // //                 width: 40, height: 4,
// // //                 margin: const EdgeInsets.only(bottom: 20),
// // //                 decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2)),
// // //               ),
// // //               const Text('Create New Site', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
// // //               const SizedBox(height: 24),
// // //               TextField(
// // //                 style: const TextStyle(color: Colors.white),
// // //                 decoration: InputDecoration(
// // //                   labelText: 'Site Name',
// // //                   labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
// // //                   enabledBorder: OutlineInputBorder(
// // //                     borderRadius: BorderRadius.circular(12),
// // //                     borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
// // //                   ),
// // //                   focusedBorder: OutlineInputBorder(
// // //                     borderRadius: BorderRadius.circular(12),
// // //                     borderSide: const BorderSide(color: Colors.white),
// // //                   ),
// // //                 ),
// // //               ),
// // //               const SizedBox(height: 24),
// // //               SizedBox(
// // //                 width: double.infinity,
// // //                 child: ElevatedButton(
// // //                   onPressed: () => Navigator.pop(context),
// // //                   style: ElevatedButton.styleFrom(
// // //                     backgroundColor: Colors.white,
// // //                     foregroundColor: const Color(0xFF2F3A2F),
// // //                     padding: const EdgeInsets.symmetric(vertical: 16),
// // //                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // //                   ),
// // //                   child: const Text('Start Building', style: TextStyle(fontWeight: FontWeight.bold)),
// // //                 ),
// // //               ),
// // //               const SizedBox(height: 20),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // // // --- 3. TEMPLATE CARD WIDGET ---
// // // class TemplateCard extends StatelessWidget {
// // //   final WebsiteTemplate template;
// // //   final VoidCallback onTap;

// // //   const TemplateCard({super.key, required this.template, required this.onTap});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return GestureDetector(
// // //       onTap: onTap,
// // //       child: Container(
// // //         decoration: BoxDecoration(
// // //           borderRadius: BorderRadius.circular(20),
// // //           boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 10, offset: const Offset(0, 4))],
// // //         ),
// // //         child: ClipRRect(
// // //           borderRadius: BorderRadius.circular(20),
// // //           child: BackdropFilter(
// // //             filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
// // //             child: Container(
// // //               decoration: BoxDecoration(
// // //                 color: Colors.white.withValues(alpha: 0.05),
// // //                 borderRadius: BorderRadius.circular(20),
// // //                 border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
// // //               ),
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   // Image Container
// // //                   Expanded(
// // //                     child: Stack(
// // //                       fit: StackFit.expand,
// // //                       children: [
// // //                         // The 3D Image
// // //                         Padding(
// // //                           padding: const EdgeInsets.all(16.0), // Padding so image floats
// // //                           child: Image.asset(
// // //                             template.imagePath,
// // //                             fit: BoxFit.contain,
// // //                             errorBuilder: (_,__,___) => const Icon(Icons.image_not_supported, color: Colors.white24),
// // //                           ),
// // //                         ),
// // //                         // Pro Badge
// // //                         if (template.isPremium)
// // //                           Positioned(
// // //                             top: 12,
// // //                             right: 12,
// // //                             child: Container(
// // //                               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// // //                               decoration: BoxDecoration(
// // //                                 color: const Color(0xFFB5A642), // Gold
// // //                                 borderRadius: BorderRadius.circular(8),
// // //                               ),
// // //                               child: const Text('PRO', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
// // //                             ),
// // //                           ),
// // //                       ],
// // //                     ),
// // //                   ),
// // //                   // Info
// // //                   Padding(
// // //                     padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
// // //                     child: Column(
// // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // //                       children: [
// // //                         Text(
// // //                           template.title,
// // //                           style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
// // //                           maxLines: 1,
// // //                           overflow: TextOverflow.ellipsis,
// // //                         ),
// // //                         const SizedBox(height: 4),
// // //                         Row(
// // //                           children: [
// // //                             Text(
// // //                               template.category,
// // //                               style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 11),
// // //                             ),
// // //                             const Spacer(),
// // //                             const Icon(Icons.star, size: 12, color: Color(0xFFB5A642)),
// // //                             Text(
// // //                               '${template.rating}',
// // //                               style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
// // //                             ),
// // //                           ],
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // // // --- 4. PREVIEW PAGE ---
// // // class TemplatePreviewPage extends StatelessWidget {
// // //   final WebsiteTemplate template;

// // //   const TemplatePreviewPage({super.key, required this.template});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return VettoScaffold(
// // //       appBar: AppBar(
// // //         backgroundColor: Colors.transparent,
// // //         elevation: 0,
// // //         iconTheme: const IconThemeData(color: Colors.white),
// // //         title: Text(template.title, style: const TextStyle(color: Colors.white)),
// // //       ),
// // //       body: SingleChildScrollView(
// // //         padding: const EdgeInsets.all(20),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             // Big Hero Image
// // //             Container(
// // //               height: 300,
// // //               width: double.infinity,
// // //               padding: const EdgeInsets.all(20),
// // //               decoration: BoxDecoration(
// // //                 color: Colors.white.withValues(alpha: 0.05),
// // //                 borderRadius: BorderRadius.circular(20),
// // //                 border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
// // //               ),
// // //               child: Image.asset(template.imagePath, fit: BoxFit.contain),
// // //             ),
// // //             const SizedBox(height: 24),
            
// // //             // Title & Rating
// // //             Row(
// // //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //               children: [
// // //                 Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     Text(template.title, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
// // //                     Text(template.category, style: const TextStyle(color: Color(0xFF8DA385), fontSize: 16)),
// // //                   ],
// // //                 ),
// // //                 Container(
// // //                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
// // //                   decoration: BoxDecoration(
// // //                     color: Colors.white.withValues(alpha: 0.1),
// // //                     borderRadius: BorderRadius.circular(20),
// // //                   ),
// // //                   child: Row(
// // //                     children: [
// // //                       const Icon(Icons.star, color: Color(0xFFB5A642), size: 18),
// // //                       const SizedBox(width: 4),
// // //                       Text('${template.rating}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
// // //                     ],
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //             const SizedBox(height: 16),
            
// // //             Text(
// // //               template.description,
// // //               style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 16, height: 1.5),
// // //             ),
            
// // //             const SizedBox(height: 24),
// // //             const Text("Features", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
// // //             const SizedBox(height: 12),
            
// // //             Wrap(
// // //               spacing: 10,
// // //               runSpacing: 10,
// // //               children: template.features.map((feature) => Container(
// // //                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// // //                 decoration: BoxDecoration(
// // //                   color: Colors.white.withValues(alpha: 0.08),
// // //                   borderRadius: BorderRadius.circular(8),
// // //                   border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
// // //                 ),
// // //                 child: Text(feature, style: const TextStyle(color: Colors.white70, fontSize: 12)),
// // //               )).toList(),
// // //             ),

// // //             const SizedBox(height: 40),
            
// // //             // Sticky-ish Footer Button
// // //             SizedBox(
// // //               width: double.infinity,
// // //               child: ElevatedButton(
// // //                 onPressed: () {
// // //                   Navigator.pop(context);
// // //                   ScaffoldMessenger.of(context).showSnackBar(
// // //                     SnackBar(
// // //                       backgroundColor: const Color(0xFF6A7B66),
// // //                       content: Text('Using ${template.title} template', style: const TextStyle(color: Colors.white)),
// // //                     ),
// // //                   );
// // //                 },
// // //                 style: ElevatedButton.styleFrom(
// // //                   backgroundColor: Colors.white,
// // //                   foregroundColor: const Color(0xFF2F3A2F),
// // //                   padding: const EdgeInsets.symmetric(vertical: 18),
// // //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// // //                 ),
// // //                 child: Text(
// // //                   template.isPremium ? 'Unlock Premium Template' : 'Use Template',
// // //                   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// // //                 ),
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }


// // // import 'dart:ui';
// // import 'package:flutter/material.dart';
// // import 'package:vetto_ai/widgets/vetto_scaffold.dart';

// // // --- 1. MODEL ---
// // class WebsiteTemplate {
// //   final String id;
// //   final String title;
// //   final String description;
// //   final String category;
// //   final String imagePath;
// //   final bool isPremium;
// //   final double rating;
// //   final int uses;
// //   final List<String> features;

// //   WebsiteTemplate({
// //     required this.id,
// //     required this.title,
// //     required this.description,
// //     required this.category,
// //     required this.imagePath,
// //     required this.isPremium,
// //     required this.rating,
// //     required this.uses,
// //     this.features = const [],
// //   });
// // }

// // // --- 2. MAIN PAGE ---
// // class SiteBuilderPage extends StatefulWidget {
// //   const SiteBuilderPage({super.key});

// //   @override
// //   State<SiteBuilderPage> createState() => _SiteBuilderPageState();
// // }

// // class _SiteBuilderPageState extends State<SiteBuilderPage> {
// //   final List<WebsiteTemplate> _templates = [];
// //   final List<WebsiteTemplate> _filteredTemplates = [];
// //   String _currentCategory = 'All';
// //   bool _isLoading = true;

// //   final List<String> _categories = ['All', 'Business', 'Portfolio', 'Store', 'Blog', 'Landing'];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadTemplates();
// //   }

// //   void _loadTemplates() {
// //     // Simulating network delay
// //     Future.delayed(const Duration(milliseconds: 2000), () {
// //       if (!mounted) return;
// //       setState(() {
// //         _templates.addAll(_getMockTemplates());
// //         _filteredTemplates.addAll(_templates);
// //         _isLoading = false;
// //       });
// //     });
// //   }

// //   List<WebsiteTemplate> _getMockTemplates() {
// //     return [
// //       WebsiteTemplate(
// //         id: '1',
// //         title: 'Neon Portfolio',
// //         description: 'High-impact personal branding template.',
// //         category: 'Portfolio',
// //         imagePath: 'assets/images/3dgraphics/image-8HR0ctKWczS8YFn67f3UW0M0cvWXBw.png',
// //         isPremium: false,
// //         rating: 4.8,
// //         uses: 1247,
// //         features: ['Dark Mode', 'Animations', 'Contact Form'],
// //       ),
// //       WebsiteTemplate(
// //         id: '2',
// //         title: 'Cyber Business',
// //         description: 'Corporate layout with futuristic elements.',
// //         category: 'Business',
// //         imagePath: 'assets/images/3dgraphics/image-aM6jkL7K10n261cCFKqEY7FqQfeaMP.png',
// //         isPremium: true,
// //         rating: 4.9,
// //         uses: 892,
// //         features: ['SEO Optimized', 'Team Section', 'Analytics'],
// //       ),
// //       WebsiteTemplate(
// //         id: '3',
// //         title: 'Quantum Store',
// //         description: 'E-commerce ready with Stripe integration.',
// //         category: 'Store',
// //         imagePath: 'assets/images/3dgraphics/image-ElUJAyxcRVHJkNw7oBRIsG5GF7hIgt.png',
// //         isPremium: true,
// //         rating: 4.7,
// //         uses: 1563,
// //         features: ['Cart System', 'Payment Gateway', 'Inventory'],
// //       ),
// //       WebsiteTemplate(
// //         id: '4',
// //         title: 'Tech Blog',
// //         description: 'Minimalist layout for technical writing.',
// //         category: 'Blog',
// //         imagePath: 'assets/images/3dgraphics/image-IU0LQSM0ihtW1G0IZB5bYpEFwG97T6.png',
// //         isPremium: false,
// //         rating: 4.5,
// //         uses: 734,
// //         features: ['Markdown Support', 'Newsletter', 'Comments'],
// //       ),
// //       WebsiteTemplate(
// //         id: '5',
// //         title: 'Startup Launch',
// //         description: 'High conversion landing page.',
// //         category: 'Landing',
// //         imagePath: 'assets/images/3dgraphics/image-k1htnek7frg4W1bRqSfOnMuNzJGdmX.png',
// //         isPremium: false,
// //         rating: 4.6,
// //         uses: 1023,
// //         features: ['A/B Testing', 'Hero Section', 'Email Capture'],
// //       ),
// //       WebsiteTemplate(
// //         id: '6',
// //         title: 'Agency Pro',
// //         description: 'Showcase your work with style.',
// //         category: 'Business',
// //         imagePath: 'assets/images/3dgraphics/image-keoWINYYBgXx7vwibZe2cbllJ4SaQA.png',
// //         isPremium: true,
// //         rating: 5.0,
// //         uses: 567,
// //         features: ['Case Studies', 'Client Portal', 'Gallery'],
// //       ),
// //     ];
// //   }

// //   void _filterTemplates(String category) {
// //     setState(() {
// //       _currentCategory = category;
// //       if (category == 'All') {
// //         _filteredTemplates.clear();
// //         _filteredTemplates.addAll(_templates);
// //       } else {
// //         _filteredTemplates.clear();
// //         _filteredTemplates.addAll(_templates.where((template) => template.category == category).toList());
// //       }
// //     });
// //   }

// //   void _createNewSite() {
// //     showModalBottomSheet(
// //       context: context,
// //       backgroundColor: Colors.transparent,
// //       isScrollControlled: true,
// //       builder: (context) => _buildCreateSiteSheet(),
// //     );
// //   }

// //   void _previewTemplate(WebsiteTemplate template) {
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(builder: (context) => TemplatePreviewPage(template: template)),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return VettoScaffold(
// //       floatingActionButton: FloatingActionButton.extended(
// //         onPressed: _createNewSite,
// //         backgroundColor: Colors.white,
// //         label: const Text('NEW SITE', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black)),
// //         icon: const Icon(Icons.add, color: Colors.black),
// //       ),
// //       body: SafeArea(
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             // --- HEADER ---
// //             Padding(
// //               padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   const Text(
// //                     'SITE BUILDER',
// //                     style: TextStyle(
// //                       fontSize: 36,
// //                       fontWeight: FontWeight.w900,
// //                       color: Colors.white,
// //                       letterSpacing: -1.0
// //                     ),
// //                   ),
// //                   Row(
// //                     children: [
// //                       IconButton(icon: const Icon(Icons.search, color: Colors.white54), onPressed: () {}),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),

// //             // --- CATEGORY FILTER ---
// //             Container(
// //               height: 40,
// //               margin: const EdgeInsets.only(bottom: 20),
// //               child: ListView.separated(
// //                 scrollDirection: Axis.horizontal,
// //                 padding: const EdgeInsets.symmetric(horizontal: 24),
// //                 itemCount: _categories.length,
// //                 separatorBuilder: (_,__) => const SizedBox(width: 10),
// //                 itemBuilder: (context, index) {
// //                   final category = _categories[index];
// //                   final isSelected = _currentCategory == category;
// //                   const activeColor = Color.fromARGB(255, 113, 153, 52);

// //                   return GestureDetector(
// //                     onTap: () => _filterTemplates(category),
// //                     child: AnimatedContainer(
// //                       duration: const Duration(milliseconds: 200),
// //                       padding: const EdgeInsets.symmetric(horizontal: 20),
// //                       alignment: Alignment.center,
// //                       decoration: BoxDecoration(
// //                         color: isSelected ? activeColor : Colors.transparent,
// //                         borderRadius: BorderRadius.circular(40),
// //                         border: Border.all(
// //                           color: isSelected ? activeColor : Colors.white24,
// //                         ),
// //                       ),
// //                       child: Text(
// //                         category.toUpperCase(),
// //                         style: TextStyle(
// //                           color: isSelected ? Colors.black : Colors.white,
// //                           fontWeight: FontWeight.w900,
// //                           fontSize: 11,
// //                         ),
// //                       ),
// //                     ),
// //                   );
// //                 },
// //               ),
// //             ),

// //             // --- GRID (SKELETON vs CONTENT) ---
// //             Expanded(
// //               child: _isLoading
// //                   ? _buildSkeletonGrid() // NEW: Skeleton Loading
// //                   : GridView.builder(
// //                       padding: const EdgeInsets.fromLTRB(24, 0, 24, 80),
// //                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //                         crossAxisCount: 2,
// //                         crossAxisSpacing: 16,
// //                         mainAxisSpacing: 16,
// //                         childAspectRatio: 0.7,
// //                       ),
// //                       itemCount: _filteredTemplates.length,
// //                       itemBuilder: (context, index) {
// //                         return _buildTemplateCard(_filteredTemplates[index]);
// //                       },
// //                     ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   // --- NEW: SKELETON GRID ---
// //   Widget _buildSkeletonGrid() {
// //     return GridView.builder(
// //       padding: const EdgeInsets.fromLTRB(24, 0, 24, 80),
// //       physics: const NeverScrollableScrollPhysics(), // Disable scroll during load
// //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //         crossAxisCount: 2,
// //         crossAxisSpacing: 16,
// //         mainAxisSpacing: 16,
// //         childAspectRatio: 0.7,
// //       ),
// //       itemCount: 6, // Show 6 placeholders
// //       itemBuilder: (context, index) {
// //         return const SkeletonCard();
// //       },
// //     );
// //   }

// //   Widget _buildTemplateCard(WebsiteTemplate template) {
// //     return GestureDetector(
// //       onTap: () => _previewTemplate(template),
// //       child: Container(
// //         decoration: BoxDecoration(
// //           color: const Color(0xFF1A1A1A),
// //           borderRadius: BorderRadius.circular(24),
// //           border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
// //         ),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             // Image
// //             Expanded(
// //               child: Padding(
// //                 padding: const EdgeInsets.all(20.0),
// //                 child: Center(
// //                   child: Image.asset(
// //                     template.imagePath,
// //                     fit: BoxFit.contain,
// //                     errorBuilder: (_,__,___) => const Icon(Icons.image, color: Colors.white24, size: 40),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             // Info
// //             Padding(
// //               padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     template.title.toUpperCase(),
// //                     style: const TextStyle(
// //                       color: Colors.white,
// //                       fontWeight: FontWeight.w900,
// //                       fontSize: 14,
// //                       height: 1.1
// //                     ),
// //                     maxLines: 2,
// //                     overflow: TextOverflow.ellipsis,
// //                   ),
// //                   const SizedBox(height: 6),
// //                   Row(
// //                     children: [
// //                       Text(
// //                         template.category.toUpperCase(),
// //                         style: TextStyle(
// //                           color: Colors.white.withValues(alpha: 0.5), fontWeight: FontWeight.w700, fontSize: 10
// //                         ),
// //                       ),
// //                       const Spacer(),
// //                       if (template.isPremium)
// //                         Container(
// //                           padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
// //                           decoration: BoxDecoration(
// //                             color: Colors.white,
// //                             borderRadius: BorderRadius.circular(4)
// //                           ),
// //                           child: const Text("PRO", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: Colors.black)),
// //                         )
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildCreateSiteSheet() {
// //     return Container(
// //       padding: const EdgeInsets.all(30),
// //       decoration: BoxDecoration(
// //         color: const Color(0xFF121212),
// //         borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
// //         border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.2))),
// //       ),
// //       child: Column(
// //         mainAxisSize: MainAxisSize.min,
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Center(
// //             child: Container(
// //               width: 40, height: 4,
// //               margin: const EdgeInsets.only(bottom: 30),
// //               decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(2)),
// //             ),
// //           ),
// //           const Text('CREATE SITE', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: -1.0)),
// //           const SizedBox(height: 30),
// //           TextField(
// //             style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
// //             decoration: InputDecoration(
// //               labelText: 'PROJECT NAME',
// //               labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 12, fontWeight: FontWeight.w800),
// //               enabledBorder: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(12),
// //                 borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
// //               ),
// //               focusedBorder: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(12),
// //                 borderSide: const BorderSide(color: Color(0xFF1ED760)),
// //               ),
// //               contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
// //             ),
// //           ),
// //           const SizedBox(height: 30),
// //           SizedBox(
// //             width: double.infinity,
// //             height: 60,
// //             child: ElevatedButton(
// //               onPressed: () => Navigator.pop(context),
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: Colors.white,
// //                 foregroundColor: Colors.black,
// //                 elevation: 0,
// //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// //               ),
// //               child: const Text('START BUILDING', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 1)),
// //             ),
// //           ),
// //           const SizedBox(height: 20),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // // --- 5. PREVIEW PAGE ---
// // class TemplatePreviewPage extends StatelessWidget {
// //   final WebsiteTemplate template;

// //   const TemplatePreviewPage({super.key, required this.template});

// //   @override
// //   Widget build(BuildContext context) {
// //     return VettoScaffold(
// //       appBar: AppBar(
// //         backgroundColor: Colors.transparent,
// //         elevation: 0,
// //         iconTheme: const IconThemeData(color: Colors.white),
// //       ),
// //       body: SingleChildScrollView(
// //         padding: const EdgeInsets.all(30),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             // Hero Image
// //             Container(
// //               height: 350,
// //               width: double.infinity,
// //               padding: const EdgeInsets.all(40),
// //               decoration: BoxDecoration(
// //                 color: const Color(0xFF1A1A1A),
// //                 borderRadius: BorderRadius.circular(30),
// //                 border: Border.all(color: Colors.white12),
// //               ),
// //               child: Image.asset(template.imagePath, fit: BoxFit.contain),
// //             ),
// //             const SizedBox(height: 40),
            
// //             // Title & Info
// //             Text(
// //               template.title.toUpperCase(),
// //               style: const TextStyle(
// //                 color: Colors.white, fontSize: 36, fontWeight: FontWeight.w900, letterSpacing: -1.5, height: 0.9
// //               ),
// //             ),
// //             const SizedBox(height: 10),
// //             Text(
// //               template.category.toUpperCase(),
// //               style: TextStyle(
// //                 color: Colors.white.withValues(alpha: 0.4), fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 1
// //               ),
// //             ),
            
// //             const SizedBox(height: 30),
            
// //             Text(
// //               template.description,
// //               style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 16, height: 1.6, fontWeight: FontWeight.w500),
// //             ),
            
// //             const SizedBox(height: 40),
// //             const Text("FEATURES", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 1)),
// //             const SizedBox(height: 16),
            
// //             Wrap(
// //               spacing: 10,
// //               runSpacing: 10,
// //               children: template.features.map((feature) => Container(
// //                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //                 decoration: BoxDecoration(
// //                   color: const Color(0xFF1A1A1A),
// //                   borderRadius: BorderRadius.circular(100),
// //                   border: Border.all(color: Colors.white12),
// //                 ),
// //                 child: Text(feature.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
// //               )).toList(),
// //             ),

// //             const SizedBox(height: 60),
            
// //             // Action Button
// //             SizedBox(
// //               width: double.infinity,
// //               height: 64,
// //               child: ElevatedButton(
// //                 onPressed: () {
// //                   Navigator.pop(context);
// //                   ScaffoldMessenger.of(context).showSnackBar(
// //                     const SnackBar(
// //                       backgroundColor: Colors.white,
// //                       content: Text('INITIALIZING PROJECT...', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800)),
// //                     ),
// //                   );
// //                 },
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: Colors.white,
// //                   foregroundColor: Colors.black,
// //                   elevation: 0,
// //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
// //                 ),
// //                 child: Text(
// //                   template.isPremium ? 'UNLOCK PREMIUM' : 'USE TEMPLATE',
// //                   style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 1.5),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // --- 6. SKELETON CARD WIDGET ---
// // class SkeletonCard extends StatefulWidget {
// //   const SkeletonCard({super.key});

// //   @override
// //   State<SkeletonCard> createState() => _SkeletonCardState();
// // }

// // class _SkeletonCardState extends State<SkeletonCard> with SingleTickerProviderStateMixin {
// //   late AnimationController _controller;
// //   late Animation<Color?> _colorAnimation;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _controller = AnimationController(
// //       duration: const Duration(milliseconds: 1000),
// //       vsync: this,
// //     )..repeat(reverse: true);

// //     // Pulsing from very dark grey to slightly lighter grey
// //     _colorAnimation = ColorTween(
// //       begin: Colors.white.withValues(alpha: 0.05),
// //       end: Colors.white.withValues(alpha: 0.1),
// //     ).animate(_controller);
// //   }

// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return AnimatedBuilder(
// //       animation: _controller,
// //       builder: (context, child) {
// //         return Container(
// //           decoration: BoxDecoration(
// //             color: const Color(0xFF1A1A1A), // Base Card Color
// //             borderRadius: BorderRadius.circular(24),
// //             border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
// //           ),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               // Image Placeholder
// //               Expanded(
// //                 child: Container(
// //                   margin: const EdgeInsets.all(20),
// //                   decoration: BoxDecoration(
// //                     color: _colorAnimation.value, // Animated Color
// //                     borderRadius: BorderRadius.circular(16),
// //                   ),
// //                 ),
// //               ),
// //               // Text Placeholders
// //               Padding(
// //                 padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     // Title Line
// //                     Container(
// //                       width: 80,
// //                       height: 14,
// //                       decoration: BoxDecoration(
// //                         color: _colorAnimation.value,
// //                         borderRadius: BorderRadius.circular(4),
// //                       ),
// //                     ),
// //                     const SizedBox(height: 8),
// //                     // Subtitle Line
// //                     Container(
// //                       width: 120, 
// //                       height: 10,
// //                       decoration: BoxDecoration(
// //                         color: _colorAnimation.value,
// //                         borderRadius: BorderRadius.circular(4),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }



// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:vetto_ai/widgets/vetto_scaffold.dart';

// // --- 1. MODEL ---
// class WebsiteTemplate {
//   final String id;
//   final String title;
//   final String description;
//   final String category;
//   final String imagePath;
//   final bool isPremium;
//   final double rating;
//   final int uses;
//   final List<String> features;

//   WebsiteTemplate({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.category,
//     required this.imagePath,
//     required this.isPremium,
//     required this.rating,
//     required this.uses,
//     this.features = const [],
//   });
// }

// // --- 2. MAIN PAGE ---
// class SiteBuilderPage extends StatefulWidget {
//   const SiteBuilderPage({super.key});

//   @override
//   State<SiteBuilderPage> createState() => _SiteBuilderPageState();
// }

// class _SiteBuilderPageState extends State<SiteBuilderPage> with SingleTickerProviderStateMixin {
//   final List<WebsiteTemplate> _templates = [];
//   final List<WebsiteTemplate> _filteredTemplates = [];
//   String _currentCategory = 'All';
//   bool _isLoading = true;

//   final List<String> _categories = ['All', 'Business', 'Portfolio', 'Store', 'Blog', 'Landing'];
  
//   // Animation Controller for smooth entry
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );
//     _fadeAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeOut);
    
//     _loadTemplates();
//   }
  
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   void _loadTemplates() {
//     // Simulating network delay
//     Future.delayed(const Duration(milliseconds: 2000), () {
//       if (!mounted) return;
//       setState(() {
//         _templates.addAll(_getMockTemplates());
//         _filteredTemplates.addAll(_templates);
//         _isLoading = false;
//         _animationController.forward();
//       });
//     });
//   }

//   List<WebsiteTemplate> _getMockTemplates() {
//     return [
//       WebsiteTemplate(
//         id: '1',
//         title: 'Neon Portfolio',
//         description: 'High-impact personal branding template.',
//         category: 'Portfolio',
//         imagePath: 'assets/images/3dgraphics/image-8HR0ctKWczS8YFn67f3UW0M0cvWXBw.png',
//         isPremium: false,
//         rating: 4.8,
//         uses: 1247,
//         features: ['Dark Mode', 'Animations', 'Contact Form'],
//       ),
//       WebsiteTemplate(
//         id: '2',
//         title: 'Cyber Business',
//         description: 'Corporate layout with futuristic elements.',
//         category: 'Business',
//         imagePath: 'assets/images/3dgraphics/image-aM6jkL7K10n261cCFKqEY7FqQfeaMP.png',
//         isPremium: true,
//         rating: 4.9,
//         uses: 892,
//         features: ['SEO Optimized', 'Team Section', 'Analytics'],
//       ),
//       WebsiteTemplate(
//         id: '3',
//         title: 'Quantum Store',
//         description: 'E-commerce ready with Stripe integration.',
//         category: 'Store',
//         imagePath: 'assets/images/3dgraphics/image-ElUJAyxcRVHJkNw7oBRIsG5GF7hIgt.png',
//         isPremium: true,
//         rating: 4.7,
//         uses: 1563,
//         features: ['Cart System', 'Payment Gateway', 'Inventory'],
//       ),
//       WebsiteTemplate(
//         id: '4',
//         title: 'Tech Blog',
//         description: 'Minimalist layout for technical writing.',
//         category: 'Blog',
//         imagePath: 'assets/images/3dgraphics/image-IU0LQSM0ihtW1G0IZB5bYpEFwG97T6.png',
//         isPremium: false,
//         rating: 4.5,
//         uses: 734,
//         features: ['Markdown Support', 'Newsletter', 'Comments'],
//       ),
//       WebsiteTemplate(
//         id: '5',
//         title: 'Startup Launch',
//         description: 'High conversion landing page.',
//         category: 'Landing',
//         imagePath: 'assets/images/3dgraphics/image-k1htnek7frg4W1bRqSfOnMuNzJGdmX.png',
//         isPremium: false,
//         rating: 4.6,
//         uses: 1023,
//         features: ['A/B Testing', 'Hero Section', 'Email Capture'],
//       ),
//       WebsiteTemplate(
//         id: '6',
//         title: 'Agency Pro',
//         description: 'Showcase your work with style.',
//         category: 'Business',
//         imagePath: 'assets/images/3dgraphics/image-keoWINYYBgXx7vwibZe2cbllJ4SaQA.png',
//         isPremium: true,
//         rating: 5.0,
//         uses: 567,
//         features: ['Case Studies', 'Client Portal', 'Gallery'],
//       ),
//     ];
//   }

//   void _filterTemplates(String category) {
//     setState(() {
//       _currentCategory = category;
//       if (category == 'All') {
//         _filteredTemplates.clear();
//         _filteredTemplates.addAll(_templates);
//       } else {
//         _filteredTemplates.clear();
//         _filteredTemplates.addAll(_templates.where((template) => template.category == category).toList());
//       }
//     });
//   }

//   void _createNewSite() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//       isScrollControlled: true,
//       builder: (context) => _buildCreateSiteSheet(),
//     );
//   }

//   void _previewTemplate(WebsiteTemplate template) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => TemplatePreviewPage(template: template)),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return VettoScaffold(
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _createNewSite,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)), // Sharp FAB
//         label: const Text('NEW SITE', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black, letterSpacing: 0.5)),
//         icon: const Icon(Icons.add, color: Colors.black, weight: 600),
//       ),
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           // --- 1. PREMIUM DARK BACKGROUND ---
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [Color(0xFF121212), Color(0xFF000000)],
//               ),
//             ),
//           ),
          
//           // Radial Spotlight
//           Positioned(
//             top: -200, left: -200,
//             child: Container(
//               width: 600, height: 600,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: RadialGradient(
//                   colors: [Colors.white.withValues(alpha: 0.05), Colors.transparent],
//                   stops: const [0.0, 1.0],
//                 ),
//               ),
//             ),
//           ),

//           // Geometric Typography Texture
//           Positioned(
//             top: 100, left: -20,
//             child: Text(
//               "SITES",
//               style: TextStyle(
//                 fontSize: 160, fontWeight: FontWeight.w900,
//                 color: Colors.white.withValues(alpha: 0.03),
//                 letterSpacing: -10.0, height: 0.8,
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: -50, right: -20,
//             child: Text(
//               "04",
//               style: TextStyle(
//                 fontSize: 250, fontWeight: FontWeight.w900,
//                 color: Colors.white.withValues(alpha: 0.02),
//                 letterSpacing: -15.0,
//               ),
//             ),
//           ),

//           // --- 2. CONTENT ---
//           SafeArea(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // --- HEADER ---
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         'SITE BUILDER',
//                         style: TextStyle(
//                           fontSize: 32,
//                           fontWeight: FontWeight.w900, // Swiss Bold
//                           color: Colors.white,
//                           letterSpacing: -1.5,
//                           height: 1.0,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           IconButton(
//                             icon: Icon(Icons.search, color: Colors.white.withValues(alpha: 0.5)), 
//                             onPressed: () {},
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),

//                 // --- CATEGORY FILTER ---
//                 Container(
//                   height: 36,
//                   margin: const EdgeInsets.only(bottom: 24),
//                   child: ListView.separated(
//                     scrollDirection: Axis.horizontal,
//                     padding: const EdgeInsets.symmetric(horizontal: 24),
//                     itemCount: _categories.length,
//                     separatorBuilder: (_,__) => const SizedBox(width: 8),
//                     itemBuilder: (context, index) {
//                       final category = _categories[index];
//                       final isSelected = _currentCategory == category;
                      
//                       return GestureDetector(
//                         onTap: () => _filterTemplates(category),
//                         child: AnimatedContainer(
//                           duration: const Duration(milliseconds: 200),
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.03),
//                             borderRadius: BorderRadius.circular(4), // Sharp corners
//                             border: Border.all(
//                               color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.1),
//                             ),
//                           ),
//                           child: Text(
//                             category.toUpperCase(),
//                             style: TextStyle(
//                               color: isSelected ? Colors.black : Colors.white.withValues(alpha: 0.6),
//                               fontWeight: FontWeight.w800,
//                               fontSize: 11,
//                               letterSpacing: 0.5,
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),

//                 // --- GRID (SKELETON vs CONTENT) ---
//                 Expanded(
//                   child: _isLoading
//                       ? _buildSkeletonGrid() // Skeleton Loading
//                       : FadeTransition(
//                           opacity: _fadeAnimation,
//                           child: GridView.builder(
//                             padding: const EdgeInsets.fromLTRB(24, 0, 24, 100), // Bottom padding for FAB
//                             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 2,
//                               crossAxisSpacing: 16,
//                               mainAxisSpacing: 16,
//                               childAspectRatio: 0.75, // Slightly taller
//                             ),
//                             itemCount: _filteredTemplates.length,
//                             itemBuilder: (context, index) {
//                               return _buildTemplateCard(_filteredTemplates[index]);
//                             },
//                           ),
//                         ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // --- SKELETON GRID ---
//   Widget _buildSkeletonGrid() {
//     return GridView.builder(
//       padding: const EdgeInsets.fromLTRB(24, 0, 24, 80),
//       physics: const NeverScrollableScrollPhysics(), // Disable scroll during load
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 16,
//         mainAxisSpacing: 16,
//         childAspectRatio: 0.75,
//       ),
//       itemCount: 6, // Show 6 placeholders
//       itemBuilder: (context, index) {
//         return const SkeletonCard();
//       },
//     );
//   }

//   Widget _buildTemplateCard(WebsiteTemplate template) {
//     return GestureDetector(
//       onTap: () => _previewTemplate(template),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white.withValues(alpha: 0.03), // 3% White Fill
//           borderRadius: BorderRadius.circular(4), // Sharp corners
//           border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Image Area
//             Expanded(
//               child: Container(
//                 margin: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.black, // Dark background for image
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//                 child: Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Image.asset(
//                       template.imagePath,
//                       fit: BoxFit.contain,
//                       errorBuilder: (_,__,___) => const Icon(Icons.image, color: Colors.white24, size: 30),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             // Info Area
//             Padding(
//               padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           template.category.toUpperCase(),
//                           style: const TextStyle(
//                             color: Color(0xFFB5A642), // Gold/Olive accent
//                             fontWeight: FontWeight.w800, 
//                             fontSize: 9,
//                             letterSpacing: 0.5
//                           ),
//                           maxLines: 1, overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       if (template.isPremium)
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.white24),
//                             borderRadius: BorderRadius.circular(2)
//                           ),
//                           child: const Text("PRO", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: Colors.white)),
//                         )
//                     ],
//                   ),
//                   const SizedBox(height: 6),
//                   Text(
//                     template.title.toUpperCase(),
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w900,
//                       fontSize: 14,
//                       height: 1.0,
//                       letterSpacing: -0.5,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 4),
//                   // Rating Star
//                   Row(
//                     children: [
//                       Icon(Icons.star, size: 10, color: Colors.white.withValues(alpha: 0.3)),
//                       const SizedBox(width: 4),
//                       Text(
//                         template.rating.toString(),
//                         style: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 10, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCreateSiteSheet() {
//     return ClipRRect(
//       borderRadius: const BorderRadius.vertical(top: Radius.circular(4)), // Sharp
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//         child: Container(
//           padding: const EdgeInsets.all(30),
//           decoration: BoxDecoration(
//             color: const Color(0xFF121212).withValues(alpha: 0.9), // Deep Matte
//             border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.1))),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Container(
//                   width: 40, height: 2,
//                   margin: const EdgeInsets.only(bottom: 30),
//                   decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(0)),
//                 ),
//               ),
//               const Text('CREATE PROJECT', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: -1.0)),
//               const SizedBox(height: 30),
//               TextField(
//                 style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
//                 cursorColor: Colors.white,
//                 decoration: InputDecoration(
//                   labelText: 'PROJECT NAME',
//                   labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1.0),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(2),
//                     borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(2),
//                     borderSide: const BorderSide(color: Colors.white),
//                   ),
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               SizedBox(
//                 width: double.infinity,
//                 height: 56,
//                 child: ElevatedButton(
//                   onPressed: () => Navigator.pop(context),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     foregroundColor: Colors.black,
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
//                   ),
//                   child: const Text('START BUILDING', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13, letterSpacing: 1.0)),
//                 ),
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // --- 5. PREVIEW PAGE ---
// class TemplatePreviewPage extends StatelessWidget {
//   final WebsiteTemplate template;

//   const TemplatePreviewPage({super.key, required this.template});

//   @override
//   Widget build(BuildContext context) {
//     return VettoScaffold(
//       body: Stack(
//         children: [
//           // Background
//           Container(color: const Color(0xFF000000)),
          
//           SafeArea(
//             child: Column(
//               children: [
//                 // Custom AppBar
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   child: Row(
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.arrow_back, color: Colors.white),
//                         onPressed: () => Navigator.pop(context),
//                       ),
//                       const Spacer(),
//                       const Icon(Icons.share, color: Colors.white54),
//                     ],
//                   ),
//                 ),
                
//                 Expanded(
//                   child: SingleChildScrollView(
//                     padding: const EdgeInsets.fromLTRB(30, 0, 30, 40),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Hero Image Frame
//                         Container(
//                           height: 350,
//                           width: double.infinity,
//                           padding: const EdgeInsets.all(40),
//                           decoration: BoxDecoration(
//                             color: const Color(0xFF121212),
//                             borderRadius: BorderRadius.circular(4), // Sharp
//                             border: Border.all(color: Colors.white12),
//                           ),
//                           child: Image.asset(template.imagePath, fit: BoxFit.contain),
//                         ),
//                         const SizedBox(height: 40),
                        
//                         // Title & Info
//                         Text(
//                           template.title.toUpperCase(),
//                           style: const TextStyle(
//                             color: Colors.white, fontSize: 40, fontWeight: FontWeight.w900, letterSpacing: -2.0, height: 0.9
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         Row(
//                           children: [
//                             Container(width: 4, height: 4, color: const Color(0xFFB5A642)),
//                             const SizedBox(width: 8),
//                             Text(
//                               template.category.toUpperCase(),
//                               style: TextStyle(
//                                 color: Colors.white.withValues(alpha: 0.5), fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 1.0
//                               ),
//                             ),
//                           ],
//                         ),
                        
//                         const SizedBox(height: 30),
                        
//                         Text(
//                           template.description,
//                           style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 15, height: 1.6, fontWeight: FontWeight.w400),
//                         ),
                        
//                         const SizedBox(height: 40),
//                         const Text("FEATURES", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.0)),
//                         const SizedBox(height: 16),
                        
//                         Wrap(
//                           spacing: 8,
//                           runSpacing: 8,
//                           children: template.features.map((feature) => Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                             decoration: BoxDecoration(
//                               color: Colors.white.withValues(alpha: 0.05),
//                               borderRadius: BorderRadius.circular(2), // Sharp
//                               border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
//                             ),
//                             child: Text(feature.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
//                           )).toList(),
//                         ),

//                         const SizedBox(height: 60),
                        
//                         // Action Button
//                         SizedBox(
//                           width: double.infinity,
//                           height: 60,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   backgroundColor: const Color(0xFF222222),
//                                   content: Text('INITIALIZING ${template.title.toUpperCase()}...', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12, letterSpacing: 1.0)),
//                                 ),
//                               );
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.white,
//                               foregroundColor: Colors.black,
//                               elevation: 0,
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
//                             ),
//                             child: Text(
//                               template.isPremium ? 'UNLOCK PREMIUM' : 'USE TEMPLATE',
//                               style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: 1.0),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // --- 6. SKELETON CARD WIDGET ---
// class SkeletonCard extends StatefulWidget {
//   const SkeletonCard({super.key});

//   @override
//   State<SkeletonCard> createState() => _SkeletonCardState();
// }

// class _SkeletonCardState extends State<SkeletonCard> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Color?> _colorAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 1000),
//       vsync: this,
//     )..repeat(reverse: true);

//     _colorAnimation = ColorTween(
//       begin: Colors.white.withValues(alpha: 0.02),
//       end: Colors.white.withValues(alpha: 0.05),
//     ).animate(_controller);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (context, child) {
//         return Container(
//           decoration: BoxDecoration(
//             color: Colors.transparent, 
//             borderRadius: BorderRadius.circular(4), // Sharp
//             border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Image Placeholder
//               Expanded(
//                 child: Container(
//                   margin: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: _colorAnimation.value,
//                     borderRadius: BorderRadius.circular(2),
//                   ),
//                 ),
//               ),
//               // Text Placeholders
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: 60, height: 10,
//                       color: _colorAnimation.value,
//                     ),
//                     const SizedBox(height: 8),
//                     Container(
//                       width: 100, height: 14,
//                       color: _colorAnimation.value,
//                     ),
//                     const SizedBox(height: 6),
//                     Container(
//                       width: 30, height: 8,
//                       color: _colorAnimation.value,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }



import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:vetto_ai/widgets/vetto_scaffold.dart';

// --- 1. MODEL ---
class WebsiteTemplate {
  final String id;
  final String title;
  final String description;
  final String category;
  final String imagePath;
  final bool isPremium;
  final double rating;
  final int uses;
  final List<String> features;

  WebsiteTemplate({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.imagePath,
    required this.isPremium,
    required this.rating,
    required this.uses,
    this.features = const [],
  });
}

// --- 2. MAIN PAGE ---
class SiteBuilderPage extends StatefulWidget {
  const SiteBuilderPage({super.key});

  @override
  State<SiteBuilderPage> createState() => _SiteBuilderPageState();
}

class _SiteBuilderPageState extends State<SiteBuilderPage> with SingleTickerProviderStateMixin {
  final List<WebsiteTemplate> _templates = [];
  final List<WebsiteTemplate> _filteredTemplates = [];
  String _currentCategory = 'All';
  bool _isLoading = true;

  final List<String> _categories = ['All', 'Business', 'Portfolio', 'Store', 'Blog', 'Landing'];
  
  // Animation Controller for smooth entry
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeOut);
    
    _loadTemplates();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _loadTemplates() {
    // Simulating network delay
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (!mounted) return;
      setState(() {
        _templates.addAll(_getMockTemplates());
        _filteredTemplates.addAll(_templates);
        _isLoading = false;
        _animationController.forward();
      });
    });
  }

  List<WebsiteTemplate> _getMockTemplates() {
    return [
      WebsiteTemplate(
        id: '1',
        title: 'Neon Portfolio',
        description: 'High-impact personal branding template.',
        category: 'Portfolio',
        imagePath: 'assets/images/3dgraphics/image-8HR0ctKWczS8YFn67f3UW0M0cvWXBw.png',
        isPremium: false,
        rating: 4.8,
        uses: 1247,
        features: ['Dark Mode', 'Animations', 'Contact Form'],
      ),
      WebsiteTemplate(
        id: '2',
        title: 'Cyber Business',
        description: 'Corporate layout with futuristic elements.',
        category: 'Business',
        imagePath: 'assets/images/3dgraphics/image-aM6jkL7K10n261cCFKqEY7FqQfeaMP.png',
        isPremium: true,
        rating: 4.9,
        uses: 892,
        features: ['SEO Optimized', 'Team Section', 'Analytics'],
      ),
      WebsiteTemplate(
        id: '3',
        title: 'Quantum Store',
        description: 'E-commerce ready with Stripe integration.',
        category: 'Store',
        imagePath: 'assets/images/3dgraphics/image-ElUJAyxcRVHJkNw7oBRIsG5GF7hIgt.png',
        isPremium: true,
        rating: 4.7,
        uses: 1563,
        features: ['Cart System', 'Payment Gateway', 'Inventory'],
      ),
      WebsiteTemplate(
        id: '4',
        title: 'Tech Blog',
        description: 'Minimalist layout for technical writing.',
        category: 'Blog',
        imagePath: 'assets/images/3dgraphics/image-IU0LQSM0ihtW1G0IZB5bYpEFwG97T6.png',
        isPremium: false,
        rating: 4.5,
        uses: 734,
        features: ['Markdown Support', 'Newsletter', 'Comments'],
      ),
      WebsiteTemplate(
        id: '5',
        title: 'Startup Launch',
        description: 'High conversion landing page.',
        category: 'Landing',
        imagePath: 'assets/images/3dgraphics/image-k1htnek7frg4W1bRqSfOnMuNzJGdmX.png',
        isPremium: false,
        rating: 4.6,
        uses: 1023,
        features: ['A/B Testing', 'Hero Section', 'Email Capture'],
      ),
      WebsiteTemplate(
        id: '6',
        title: 'Agency Pro',
        description: 'Showcase your work with style.',
        category: 'Business',
        imagePath: 'assets/images/3dgraphics/image-keoWINYYBgXx7vwibZe2cbllJ4SaQA.png',
        isPremium: true,
        rating: 5.0,
        uses: 567,
        features: ['Case Studies', 'Client Portal', 'Gallery'],
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
      MaterialPageRoute(builder: (context) => TemplatePreviewPage(template: template)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return VettoScaffold(
      // Wrapped FAB in Padding to lift it above the Navbar
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 90), // Clears the navbar
        child: FloatingActionButton.extended(
          onPressed: _createNewSite,
          backgroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)), // Sharp FAB
          label: const Text('NEW SITE', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black, letterSpacing: 0.5)),
          icon: const Icon(Icons.add, color: Colors.black, weight: 600),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // --- 1. PREMIUM DARK BACKGROUND ---
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF121212), Color(0xFF000000)],
              ),
            ),
          ),
          
          // Radial Spotlight
          Positioned(
            top: -200, left: -200,
            child: Container(
              width: 600, height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Colors.white.withValues(alpha: 0.05), Colors.transparent],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
          ),

          // Geometric Typography Texture
          Positioned(
            top: 100, left: -20,
            child: Text(
              "SITES",
              style: TextStyle(
                fontSize: 160, fontWeight: FontWeight.w900,
                color: Colors.white.withValues(alpha: 0.03),
                letterSpacing: -10.0, height: 0.8,
              ),
            ),
          ),
          Positioned(
            bottom: -50, right: -20,
            child: Text(
              "04",
              style: TextStyle(
                fontSize: 250, fontWeight: FontWeight.w900,
                color: Colors.white.withValues(alpha: 0.02),
                letterSpacing: -15.0,
              ),
            ),
          ),

          // --- 2. CONTENT ---
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- NEW FIXED APP BAR ---
                _buildFixedAppBar(),

                // --- MAIN TITLE HEADER ---
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 10, 24, 20), // Adjusted top padding
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'SITE BUILDER',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900, // Swiss Bold
                          color: Colors.white,
                          letterSpacing: -1.5,
                          height: 1.0,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.search, color: Colors.white.withValues(alpha: 0.5)), 
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // --- CATEGORY FILTER ---
                Container(
                  height: 36,
                  margin: const EdgeInsets.only(bottom: 24),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: _categories.length,
                    separatorBuilder: (_,__) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      final isSelected = _currentCategory == category;
                      
                      return GestureDetector(
                        onTap: () => _filterTemplates(category),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.03),
                            borderRadius: BorderRadius.circular(4), // Sharp corners
                            border: Border.all(
                              color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.1),
                            ),
                          ),
                          child: Text(
                            category.toUpperCase(),
                            style: TextStyle(
                              color: isSelected ? Colors.black : Colors.white.withValues(alpha: 0.6),
                              fontWeight: FontWeight.w800,
                              fontSize: 11,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // --- GRID (SKELETON vs CONTENT) ---
                Expanded(
                  child: _isLoading
                      ? _buildSkeletonGrid() // Skeleton Loading
                      : FadeTransition(
                          opacity: _fadeAnimation,
                          child: GridView.builder(
                            // Increased bottom padding so last items are visible above Navbar
                            padding: const EdgeInsets.fromLTRB(24, 0, 24, 160), 
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.75, // Slightly taller
                            ),
                            itemCount: _filteredTemplates.length,
                            itemBuilder: (context, index) {
                              return _buildTemplateCard(_filteredTemplates[index]);
                            },
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- NEW FIXED APP BAR WIDGET ---
  Widget _buildFixedAppBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "VETTO // SITE BUILDER",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.white54,
              letterSpacing: 1.5, // Wide spacing for small caps feel
            ),
          ),
          Container(
            width: 8, height: 8,
            decoration: const BoxDecoration(color: Color(0xFFB5A642), shape: BoxShape.circle), // Gold accent
          ),
        ],
      ),
    );
  }

  // --- SKELETON GRID ---
  Widget _buildSkeletonGrid() {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 80),
      physics: const NeverScrollableScrollPhysics(), // Disable scroll during load
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: 6, // Show 6 placeholders
      itemBuilder: (context, index) {
        return const SkeletonCard();
      },
    );
  }

  Widget _buildTemplateCard(WebsiteTemplate template) {
    return GestureDetector(
      onTap: () => _previewTemplate(template),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.03), // 3% White Fill
          borderRadius: BorderRadius.circular(4), // Sharp corners
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Area
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black, // Dark background for image
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      template.imagePath,
                      fit: BoxFit.contain,
                      errorBuilder: (_,__,___) => const Icon(Icons.image, color: Colors.white24, size: 30),
                    ),
                  ),
                ),
              ),
            ),
            // Info Area
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          template.category.toUpperCase(),
                          style: const TextStyle(
                            color: Color(0xFFB5A642), // Gold/Olive accent
                            fontWeight: FontWeight.w800, 
                            fontSize: 9,
                            letterSpacing: 0.5
                          ),
                          maxLines: 1, overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (template.isPremium)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white24),
                            borderRadius: BorderRadius.circular(2)
                          ),
                          child: const Text("PRO", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: Colors.white)),
                        )
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    template.title.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                      height: 1.0,
                      letterSpacing: -0.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Rating Star
                  Row(
                    children: [
                      Icon(Icons.star, size: 10, color: Colors.white.withValues(alpha: 0.3)),
                      const SizedBox(width: 4),
                      Text(
                        template.rating.toString(),
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateSiteSheet() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(4)), // Sharp
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: const Color(0xFF121212).withValues(alpha: 0.9), // Deep Matte
            border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.1))),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40, height: 2,
                  margin: const EdgeInsets.only(bottom: 30),
                  decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(0)),
                ),
              ),
              const Text('CREATE PROJECT', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: -1.0)),
              const SizedBox(height: 30),
              TextField(
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  labelText: 'PROJECT NAME',
                  labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                  ),
                  child: const Text('START BUILDING', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13, letterSpacing: 1.0)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 5. PREVIEW PAGE ---
class TemplatePreviewPage extends StatelessWidget {
  final WebsiteTemplate template;

  const TemplatePreviewPage({super.key, required this.template});

  @override
  Widget build(BuildContext context) {
    return VettoScaffold(
      body: Stack(
        children: [
          // Background
          Container(color: const Color(0xFF000000)),
          
          SafeArea(
            child: Column(
              children: [
                // Custom AppBar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                      const Icon(Icons.share, color: Colors.white54),
                    ],
                  ),
                ),
                
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hero Image Frame
                        Container(
                          height: 350,
                          width: double.infinity,
                          padding: const EdgeInsets.all(40),
                          decoration: BoxDecoration(
                            color: const Color(0xFF121212),
                            borderRadius: BorderRadius.circular(4), // Sharp
                            border: Border.all(color: Colors.white12),
                          ),
                          child: Image.asset(template.imagePath, fit: BoxFit.contain),
                        ),
                        const SizedBox(height: 40),
                        
                        // Title & Info
                        Text(
                          template.title.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white, fontSize: 40, fontWeight: FontWeight.w900, letterSpacing: -2.0, height: 0.9
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Container(width: 4, height: 4, color: const Color(0xFFB5A642)),
                            const SizedBox(width: 8),
                            Text(
                              template.category.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.5), fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 1.0
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 30),
                        
                        Text(
                          template.description,
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 15, height: 1.6, fontWeight: FontWeight.w400),
                        ),
                        
                        const SizedBox(height: 40),
                        const Text("FEATURES", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.0)),
                        const SizedBox(height: 16),
                        
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: template.features.map((feature) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(2), // Sharp
                              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                            ),
                            child: Text(feature.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
                          )).toList(),
                        ),

                        const SizedBox(height: 60),
                        
                        // Action Button
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: const Color(0xFF222222),
                                  content: Text('INITIALIZING ${template.title.toUpperCase()}...', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12, letterSpacing: 1.0)),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                            ),
                            child: Text(
                              template.isPremium ? 'UNLOCK PREMIUM' : 'USE TEMPLATE',
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: 1.0),
                            ),
                          ),
                        ),
                      ],
                    ),
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

// --- 6. SKELETON CARD WIDGET ---
class SkeletonCard extends StatefulWidget {
  const SkeletonCard({super.key});

  @override
  State<SkeletonCard> createState() => _SkeletonCardState();
}

class _SkeletonCardState extends State<SkeletonCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: Colors.white.withValues(alpha: 0.02),
      end: Colors.white.withValues(alpha: 0.05),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.transparent, 
            borderRadius: BorderRadius.circular(4), // Sharp
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Placeholder
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _colorAnimation.value,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Text Placeholders
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 60, height: 10,
                      color: _colorAnimation.value,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 100, height: 14,
                      color: _colorAnimation.value,
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: 30, height: 8,
                      color: _colorAnimation.value,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}