import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';

class EnvService {
  static final EnvService _instance = EnvService._internal();
  factory EnvService() => _instance;
  EnvService._internal();

  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;
    
    try {
      await dotenv.load(fileName: ".env");
      _isInitialized = true;
    } catch (e) {
      if (kDebugMode) {
        print("Warning: .env file not found. Ensure GEMINI_API_KEY is set in environment.");
      }
    }
  }

  String get geminiApiKey {
    // Tries to get from .env, falls back to OS environment (for CI/CD), then throws readable error
    final key = dotenv.env['GEMINI_API_KEY'] ?? const String.fromEnvironment('GEMINI_API_KEY');
    
    if (key.isEmpty) {
      throw Exception('GEMINI_API_KEY is missing. Please create a .env file or set build arg.');
    }
    return key;
  }
}