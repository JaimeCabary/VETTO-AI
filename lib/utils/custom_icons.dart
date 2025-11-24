// import 'package:flutter/material.dart';

// class CustomIcons {
//   // AI & Cyberpunk themed icons
//   static const String brain = '🧠';
//   static const String rocket = '🚀';
//   static const String shield = '🛡️';
//   static const String zap = '⚡';
//   static const String globe = '🌐';
//   static const String workflow = '⚙️';
//   static const String template = '🎨';
//   static const String chat = '💬';
//   static const String offline = '📴';
//   static const String sync = '🔄';
//   static const String security = '🔒';
//   static const String performance = '🚀';
//   static const String customize = '🎛️';
// }


import 'package:flutter/material.dart';

/// String-based icon keys matching the original names
class CustomIcons {
  static const String brain = 'brain';
  static const String rocket = 'rocket';
  static const String shield = 'shield';
  static const String zap = 'zap';
  static const String globe = 'globe';
  static const String workflow = 'workflow';
  static const String template = 'template';
  static const String chat = 'chat';
  static const String offline = 'offline';
  static const String sync = 'sync';
  static const String security = 'security';
  static const String performance = 'performance';
  static const String customize = 'customize';
}

/// Convert the string key → actual icon widget
Icon getIcon(String key, {double size = 24, Color? color}) {
  switch (key) {
    case 'brain':
      return Icon(Icons.psychology, size: size, color: color);
    case 'rocket':
      return Icon(Icons.rocket_launch, size: size, color: color);
    case 'shield':
      return Icon(Icons.shield, size: size, color: color);
    case 'zap':
      return Icon(Icons.bolt, size: size, color: color);
    case 'globe':
      return Icon(Icons.public, size: size, color: color);
    case 'workflow':
      return Icon(Icons.settings, size: size, color: color);
    case 'template':
      return Icon(Icons.palette, size: size, color: color);
    case 'chat':
      return Icon(Icons.chat, size: size, color: color);
    case 'offline':
      return Icon(Icons.portable_wifi_off, size: size, color: color);
    case 'sync':
      return Icon(Icons.sync, size: size, color: color);
    case 'security':
      return Icon(Icons.lock, size: size, color: color);
    case 'performance':
      return Icon(Icons.rocket_launch, size: size, color: color);
    case 'customize':
      return Icon(Icons.tune, size: size, color: color);
    default:
      return Icon(Icons.help_outline, size: size, color: color);
  }
}
