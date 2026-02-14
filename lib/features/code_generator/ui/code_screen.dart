import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/api_service.dart';
import '../bloc/code_bloc.dart';
import '../bloc/code_event.dart';
import '../bloc/code_state.dart';

class CodeScreen extends StatelessWidget {
  const CodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CodeBloc(ApiService()),
      child: const CodeView(),
    );
  }
}

class CodeView extends StatefulWidget {
  const CodeView({super.key});

  @override
  State<CodeView> createState() => _CodeViewState();
}

class _CodeViewState extends State<CodeView> {
  final TextEditingController promptController = TextEditingController();
  final TextEditingController languageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Code Generator")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: promptController,
              decoration: const InputDecoration(
                  labelText: "Requirement/Prompt",
                  border: OutlineInputBorder()),
              maxLines: 4,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: languageController,
              decoration: const InputDecoration(
                  labelText: "Programming Language (e.g., Dart, Python)",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                if (promptController.text.isNotEmpty &&
                    languageController.text.isNotEmpty) {
                  context.read<CodeBloc>().add(
                    GenerateCodeEvent(
                      prompt: promptController.text,
                      language: languageController.text,
                    ),
                  );
                }
              },
              child: const Text("Generate Code"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<CodeBloc, CodeState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.error.isNotEmpty) {
                    return Center(
                        child:
                        Text(state.error, style: const TextStyle(color: Colors.red)));
                  } else if (state.generatedCode.isNotEmpty) {
                    return SingleChildScrollView(
                      child: Text(
                        state.generatedCode,
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
