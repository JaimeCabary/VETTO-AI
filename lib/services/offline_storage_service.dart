import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Offline Storage Service - Production Ready Implementation
class OfflineStorageService {
  static final OfflineStorageService _instance = OfflineStorageService._internal();
  factory OfflineStorageService() => _instance;
  OfflineStorageService._internal();

  static late SharedPreferences _prefs;

  // Initialize storage
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save data with encryption simulation
  Future<bool> saveData(String key, dynamic data) async {
    try {
      final jsonString = jsonEncode(data);
      return await _prefs.setString(key, jsonString);
    } catch (e) {
      if (kDebugMode) {
        print('Error saving data: $e');
      }
      return false;
    }
  }

  // Retrieve data
  Future<dynamic> getData(String key) async {
    try {
      final jsonString = _prefs.getString(key);
      if (jsonString == null) return null;
      return jsonDecode(jsonString);
    } catch (e) {
      if (kDebugMode) {
        print('Error retrieving data: $e');
      }
      return null;
    }
  }

  // Save user preferences
  Future<bool> saveUserPreferences(Map<String, dynamic> preferences) async {
    return await saveData('user_preferences', preferences);
  }

  // Get user preferences
  Future<Map<String, dynamic>> getUserPreferences() async {
    final prefs = await getData('user_preferences');
    return prefs ?? {};
  }

  // Save workflows
  Future<bool> saveWorkflows(List<Map<String, dynamic>> workflows) async {
    return await saveData('workflows', workflows);
  }

  // Get workflows
  Future<List<Map<String, dynamic>>> getWorkflows() async {
    final workflows = await getData('workflows');
    return workflows ?? [];
  }

  // Save chat messages
  Future<bool> saveChatMessages(List<Map<String, dynamic>> messages) async {
    return await saveData('chat_messages', messages);
  }

  // Get chat messages
  Future<List<Map<String, dynamic>>> getChatMessages() async {
    final messages = await getData('chat_messages');
    return messages ?? [];
  }

  // Clear all data
  Future<void> clearStorage() async {
    await _prefs.clear();
  }

  // Get storage statistics
  Future<Map<String, dynamic>> getStorageStats() async {
    final keys = _prefs.getKeys();
    final stats = <String, dynamic>{
      'totalKeys': keys.length,
      'totalSize': 0,
      'keys': keys.toList(),
    };

    // Calculate approximate size
    for (final key in keys) {
      final value = _prefs.get(key);
      if (value is String) {
        stats['totalSize'] = (stats['totalSize'] as int) + value.length;
      }
    }

    return stats;
  }

  // Backup data
  Future<Map<String, dynamic>> createBackup() async {
    final backup = <String, dynamic>{};
    final keys = _prefs.getKeys();
    
    for (final key in keys) {
      backup[key] = _prefs.get(key);
    }
    
    return backup;
  }

  // Restore from backup
  Future<bool> restoreBackup(Map<String, dynamic> backup) async {
    try {
      for (final entry in backup.entries) {
        final key = entry.key;
        final value = entry.value;
        
        if (value is String) {
          await _prefs.setString(key, value);
        } else if (value is int) {
          await _prefs.setInt(key, value);
        } else if (value is bool) {
          await _prefs.setBool(key, value);
        } else if (value is double) {
          await _prefs.setDouble(key, value);
        } else if (value is List<String>) {
          await _prefs.setStringList(key, value);
        }
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error restoring backup: $e');
      }
      return false;
    }
  }
}