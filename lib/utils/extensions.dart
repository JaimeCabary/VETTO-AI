// lib/utils/extensions.dart
import 'dart:ui';

extension ColorExtensions on Color {
  /// Convert 0–1 value to 0–255 int
  int _to255(double value) => (value * 255.0).round().clamp(0, 255);

  /// Darken the color by [percent] (0–100)
  Color darken([int percent = 10]) {
    assert(percent >= 0 && percent <= 100);
    final factor = 1 - (percent / 100);

    return Color.fromARGB(
      _to255(a),
      _to255(r * factor),
      _to255(g * factor),
      _to255(b * factor),
    );
  }

  /// Lighten the color by [percent] (0–100)
  Color lighten([int percent = 10]) {
    assert(percent >= 0 && percent <= 100);
    final factor = 1 + (percent / 100);

    return Color.fromARGB(
      _to255(a),
      _to255((r * factor).clamp(0.0, 1.0)),
      _to255((g * factor).clamp(0.0, 1.0)),
      _to255((b * factor).clamp(0.0, 1.0)),
    );
  }

  /// Create a color with custom alpha (0.0–1.0) without using deprecated APIs
  Color withValues({double alpha = 1.0}) {
    assert(alpha >= 0.0 && alpha <= 1.0);
    return Color.fromARGB(
      _to255(alpha),
      _to255(r),
      _to255(g),
      _to255(b),
    );
  }
}
