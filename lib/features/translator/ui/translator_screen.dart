import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/api_service.dart';
import '../bloc/translator_bloc.dart';
import '../bloc/translator_event.dart';
import '../bloc/translator_state.dart';

class TranslatorScreen extends StatelessWidget {
  const TranslatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TranslatorBloc(ApiService()),
      child: const TranslatorView(),
    );
  }
}

class TranslatorView extends StatefulWidget {
  const TranslatorView({super.key});

  @override
  State<TranslatorView> createState() => _TranslatorViewState();
}

class _TranslatorViewState extends State<TranslatorView> {
  final TextEditingController inputController = TextEditingController();
  final TextEditingController languageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Translator")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: inputController,
              decoration: const InputDecoration(
                  labelText: "Text to Translate",
                  border: OutlineInputBorder()),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: languageController,
              decoration: const InputDecoration(
                  labelText: "Target Language (e.g., French, Spanish)",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                if (inputController.text.isNotEmpty &&
                    languageController.text.isNotEmpty) {
                  context.read<TranslatorBloc>().add(TranslateTextEvent(
                      text: inputController.text,
                      targetLanguage: languageController.text));
                }
              },
              child: const Text("Translate"),
            ),
            const SizedBox(height: 20),
            BlocBuilder<TranslatorBloc, TranslatorState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const CircularProgressIndicator();
                } else if (state.error.isNotEmpty) {
                  return Text(state.error, style: const TextStyle(color: Colors.red));
                } else if (state.translatedText.isNotEmpty) {
                  return Text(
                    state!.translatedText,
                    style: const TextStyle(fontSize: 18),
                  );
                } else {
                  return const SizedBox();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
