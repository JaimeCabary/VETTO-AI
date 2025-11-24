import 'dart:ui';

// class OnboardingSlide {
//   final String id;
//   final String title;
//   final String description;
//   final String imagePath;
//   final Color backgroundColor;
//   final Color textColor;
//   final List<String> features;

//   const OnboardingSlide({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.imagePath,
//     required this.backgroundColor,
//     required this.textColor,
//     required this.features,
//   });
// }



class OnboardingSlide {
  final String id;
  final String title;
  final String description;
  final String mainImage;
  final List<String> doodleImages;
  final Color backgroundColor;
  final Color textColor;
  final List<String> features;

  const OnboardingSlide({
    required this.id,
    required this.title,
    required this.description,
    required this.mainImage,
    required this.doodleImages,
    required this.backgroundColor,
    required this.textColor,
    required this.features,
  });
}