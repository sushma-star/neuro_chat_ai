import 'package:flutter/material.dart';

import '../../features/chat/ui/chat_screen.dart';
import '../../features/code_generator/ui/code_screen.dart';
import '../../features/grammer/ui/grammar_screen.dart';
import '../../features/history/ui/history_screen.dart';
import '../../features/image_to_text/ui/ocr_screen.dart';
import '../../features/summarizer/ui/summarizer_screen.dart';
import '../../features/translator/ui/translator_screen.dart';
import '../../features/voice_chat/ui/voice_screen.dart';
import '../../widget/feature_cart.dart';


class HomeScreen extends StatelessWidget {
    HomeScreen({super.key});

  final List<Map<String, dynamic>> features = [
    {"title": "Chat AI", "icon": Icons.chat, "screen": ChatScreen()},
    const {"title": "Translator", "icon": Icons.translate, "screen": TranslatorScreen()},
    {"title": "Summarizer", "icon": Icons.summarize_outlined, "screen": const SummarizerScreen()},
    const {"title": "Grammar Fix", "icon": Icons.spellcheck, "screen": GrammarScreen()},
    const {"title": "Code Generator", "icon": Icons.code, "screen": CodeScreen()},
    const {"title": "Image to Text", "icon": Icons.image, "screen": OcrScreen()},
    const {"title": "Voice Chat", "icon": Icons.mic, "screen": VoiceScreen()},
    const {"title": "History", "icon": Icons.history, "screen": HistoryScreen()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI Assistant App")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: features.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final feature = features[index];
            return FeatureCard(
              title: feature['title'],
              icon: feature['icon'],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => feature['screen']),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
