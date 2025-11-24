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