// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'env_service.dart';

// class AIService {
//   static final AIService _instance = AIService._internal();
//   factory AIService() => _instance;
//   AIService._internal();

//   GenerativeModel? _model;
  
//   // --- SYSTEM PROMPT ---
//   static const String _vettoSystemPrompt = '''
// You are Vetto AI, a next-generation, offline-first, platform-agnostic AI ecosystem.
// Your Mission: To provide every user, everywhere—regardless of infrastructure—with a powerful, private, and intelligent AI ecosystem.

// COMPANY PROFILE:
// Name: Vetto AI
// Founder/CEO: Shalom Chidi-Azuwike
// Founded: 2025
// Headquarters: Port Harcourt, Rivers State, Nigeria
// Core Value Proposition: "Your AI Co-Pilot. Offline. Automated. Safe."

// KEY FEATURES:
// 1. Offline AI Co-Pilot: Runs locally, handles autocomplete/suggestions without internet.
// 2. Document Ecosystem: Manage, tag, and verify documents (tamper detection).
// 3. Workflow Automation: Automate tasks (e.g., "When PDF dropped -> verify -> tag").
// 4. Security: Local AES-256 encryption.

// BEHAVIORAL GUIDELINES:
// - Be helpful, professional, and privacy-conscious.
// - Answer questions based on Vetto's offline-first capabilities.
// - If asked about "workflows", "templates", or "automation", provide concrete examples.
// - Format responses cleanly. Use markdown for lists or code.
// - When providing code, use markdown code blocks (```language ... ```).
// ''';

//   Future<void> initialize() async {
//     if (_model != null) return;

//     try {
//       final apiKey = EnvService().geminiApiKey;
      
//       _model = GenerativeModel(
//         // Using the stable 2.5 Flash model
//         model: 'gemini-2.5-flash', 
//         apiKey: apiKey,
//         systemInstruction: Content.system(_vettoSystemPrompt),
//         generationConfig: GenerationConfig(
//           temperature: 0.7,
//           topK: 40,
//           topP: 0.95,
//           maxOutputTokens: 2048,
//         ),
//       );
//     } catch (e) {
//       if (kDebugMode) {
//         print("AI Service Initialization Error: $e");
//       }
//     }
//   }

//   // Process user message with history
//   Future<String> processMessage(String message, {List<Map<String, String>>? history}) async {
//     if (_model == null) await initialize();

//     try {
//       final chatHistory = history?.map((h) {
//         final role = h['role'] == 'user' ? 'user' : 'model';
//         return Content(role, [TextPart(h['content'] ?? '')]);
//       }).toList() ?? [];

//       final chat = _model!.startChat(history: chatHistory);
//       final response = await chat.sendMessage(Content.text(message));

//       return response.text ?? "I'm having trouble connecting to my neural core. Please check your connection.";
//     } catch (e) {
//       if (e.toString().contains('404') || e.toString().contains('not found')) {
//          return "System Error: The 'gemini-2.5-flash' model is not currently available to your API key. Please check Google AI Studio.";
//       }
//       return "Error: Unable to process request. ($e)";
//     }
//   }

//   // Generate a short title for the chat based on the first message
//   Future<String> summarizeChat(String firstMessage) async {
//     if (_model == null) await initialize();
//     try {
//       final prompt = "Generate a very short, punchy title (max 4 words) for a chat that starts with this message: \"$firstMessage\". Return ONLY the title, no quotes.";
//       final response = await _model!.generateContent([Content.text(prompt)]);
//       return response.text?.trim() ?? "New Chat";
//     } catch (e) {
//       return "New Chat";
//     }
//   }

//   // Generate structured JSON for workflows
//   Future<List<Map<String, dynamic>>> getWorkflowSuggestions() async {
//     if (_model == null) await initialize();

//     try {
//       const prompt = '''
//       Generate 3 useful workflow automation ideas for a business user using Vetto AI.
//       Return strictly valid JSON in this format:
//       [{"id": "1", "title": "Title", "description": "Desc", "category": "Category"}]
//       Do not include markdown formatting like ```json.
//       ''';

//       final response = await _model!.generateContent([Content.text(prompt)]);
//       final cleanText = response.text?.replaceAll('```json', '').replaceAll('```', '').trim();

//       if (cleanText != null) {
//         final List<dynamic> jsonList = jsonDecode(cleanText);
//         return List<Map<String, dynamic>>.from(jsonList);
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print("JSON Generation Error: $e");
//       }
//     }
    
//     return [
//       {
//         'id': '1',
//         'title': 'Document Integrity Scan',
//         'description': 'Automatically scan new PDFs for deepfake artifacts',
//         'category': 'Security',
//       },
//       {
//         'id': '2',
//         'title': 'Meeting Notes Sync',
//         'description': 'Transcribe local audio and tag action items',
//         'category': 'Productivity',
//       },
//       {
//         'id': '3',
//         'title': 'Invoice Auto-Sort',
//         'description': 'Detect invoices and move to Finance folder',
//         'category': 'Automation',
//       },
//     ];
//   }
// }



import 'dart:convert';
// import 'dart:typed_data'; 
import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'env_service.dart';

class AIService {
  static final AIService _instance = AIService._internal();
  factory AIService() => _instance;
  AIService._internal();

  GenerativeModel? _model;
  
  // --- SYSTEM PROMPT ---
  static const String _vettoSystemPrompt = '''
You are Vetto AI, a next-generation, offline-first, platform-agnostic AI ecosystem.
Your Mission: To provide every user, everywhere—regardless of infrastructure—with a powerful, private, and intelligent AI ecosystem.

COMPANY PROFILE:
Name: Vetto AI
Founder/CEO: Shalom Chidi-Azuwike
Founded: 2025
Headquarters: Port Harcourt, Rivers State, Nigeria
Core Value Proposition: "Your AI Co-Pilot. Offline. Automated. Safe."

KEY FEATURES:
1. Offline AI Co-Pilot: Runs locally, handles autocomplete/suggestions without internet.
2. Document Ecosystem: Manage, tag, and verify documents (tamper detection).
3. Workflow Automation: Automate tasks (e.g., "When PDF dropped -> verify -> tag").
4. Security: Local AES-256 encryption.

BEHAVIORAL GUIDELINES:
- Be helpful, professional, and privacy-conscious.
- Answer questions based on Vetto's offline-first capabilities.
- If asked about "workflows", "templates", or "automation", provide concrete examples.
- Format responses cleanly. Use markdown for lists or code.
- When providing code, use markdown code blocks (```language ... ```).
''';

  Future<void> initialize() async {
    if (_model != null) return;

    try {
      final apiKey = EnvService().geminiApiKey;
      
      _model = GenerativeModel(
        // Using the stable 2.5 Flash model
        model: 'gemini-2.5-flash', 
        apiKey: apiKey,
        systemInstruction: Content.system(_vettoSystemPrompt),
        generationConfig: GenerationConfig(
          temperature: 0.7,
          topK: 40,
          topP: 0.95,
          maxOutputTokens: 2048,
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print("AI Service Initialization Error: $e");
      }
    }
  }

  // Process user message with history AND Optional Image (Multimodal)
  // backward compatible: if imageBytes is null, it acts like a normal text chat
  Future<String> processMessage(String message, {List<Map<String, String>>? history, Uint8List? imageBytes}) async {
    if (_model == null) await initialize();

    try {
      // 1. Prepare History
      final chatHistory = history?.map((h) {
        final role = h['role'] == 'user' ? 'user' : 'model';
        return Content(role, [TextPart(h['content'] ?? '')]);
      }).toList() ?? [];

      final chat = _model!.startChat(history: chatHistory);
      
      // 2. Prepare Current Message (Text + Optional Image)
      Content content;
      if (imageBytes != null) {
        // Multimodal Input: Text + Image
        content = Content.multi([
          TextPart(message),
          DataPart('image/jpeg', imageBytes), // Defaults to jpeg context, Flash handles most types automatically
        ]);
      } else {
        // Text Only Input
        content = Content.text(message);
      }

      final response = await chat.sendMessage(content);

      return response.text ?? "I'm having trouble connecting to my neural core. Please check your connection.";
    } catch (e) {
      if (e.toString().contains('404') || e.toString().contains('not found')) {
         return "System Error: The 'gemini-2.5-flash' model is not currently available to your API key. Please check Google AI Studio.";
      }
      return "Error: Unable to process request. ($e)";
    }
  }

  // --- NEW FEATURE: Data Extraction from Image ---
  // Use this for "Scan this receipt" or "Extract JSON from this screenshot"
  Future<String> extractDataFromImage(String prompt, Uint8List imageBytes) async {
    if (_model == null) await initialize();
    try {
      final content = [
        Content.multi([
          TextPart(prompt),
          DataPart('image/jpeg', imageBytes),
        ])
      ];

      final response = await _model!.generateContent(content);
      return response.text ?? "Could not extract data.";
    } catch (e) {
       return "Extraction Error: $e";
    }
  }

  // Generate a short title for the chat based on the first message
  Future<String> summarizeChat(String firstMessage) async {
    if (_model == null) await initialize();
    try {
      final prompt = "Generate a very short, punchy title (max 4 words) for a chat that starts with this message: \"$firstMessage\". Return ONLY the title, no quotes.";
      final response = await _model!.generateContent([Content.text(prompt)]);
      return response.text?.trim() ?? "New Chat";
    } catch (e) {
      return "New Chat";
    }
  }

  // Generate structured JSON for workflows
  Future<List<Map<String, dynamic>>> getWorkflowSuggestions() async {
    if (_model == null) await initialize();

    try {
      const prompt = '''
      Generate 3 useful workflow automation ideas for a business user using Vetto AI.
      Return strictly valid JSON in this format:
      [{"id": "1", "title": "Title", "description": "Desc", "category": "Category"}]
      Do not include markdown formatting like ```json.
      ''';

      final response = await _model!.generateContent([Content.text(prompt)]);
      final cleanText = response.text?.replaceAll('```json', '').replaceAll('```', '').trim();

      if (cleanText != null) {
        final List<dynamic> jsonList = jsonDecode(cleanText);
        return List<Map<String, dynamic>>.from(jsonList);
      }
    } catch (e) {
      if (kDebugMode) {
        print("JSON Generation Error: $e");
      }
    }
    
    return [
      {
        'id': '1',
        'title': 'Document Integrity Scan',
        'description': 'Automatically scan new PDFs for deepfake artifacts',
        'category': 'Security',
      },
      {
        'id': '2',
        'title': 'Meeting Notes Sync',
        'description': 'Transcribe local audio and tag action items',
        'category': 'Productivity',
      },
      {
        'id': '3',
        'title': 'Invoice Auto-Sort',
        'description': 'Detect invoices and move to Finance folder',
        'category': 'Automation',
      },
    ];
  }
}